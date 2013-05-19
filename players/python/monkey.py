#!/usr/bin/python
import heapq
import logging
import os.path
import pickle
import sys

import util
from path import PathFinder

STATE_FILENAME = 'state.pickle'
TRACK_URI_HEADER = 'spotify:track:'

class Monkey(object):
    def __init__(self):
        self._id = 0
        self._w = 0
        self._h = 0
        self._turn_limit = 0
        self._turn = 0
        self._capacity = 0
        self._time_left = 0
        self._top_tracks = None
        self._top_albums = None
        self._top_artists = None
        self._bad_artists = None
        self._bad_tracks = set()
        self._map = {}
        self._pos = None
        self._user = None
        self._track_pos = {} # pos -> uri
        self._metadata = {} # uri -> metadata
        self._objective = None
        
    @classmethod
    def process_input(cls, stream):
        monkey = None
        line = stream.readline().strip()
        if line == 'INIT':
            logging.basicConfig(filename='monkey.log', filemode='w', level=logging.DEBUG)
            monkey = cls()
            monkey.initialize(stream)
        else:
            logging.basicConfig(filename='monkey.log', filemode='a', level=logging.DEBUG)
            monkey = cls.load()
            monkey.update(stream)
        return monkey
            
    def initialize(self, stream):
        self._id = stream.readline().strip()
        self._w = util.get_int(stream)
        self._h = util.get_int(stream)
        self._turn_limit = util.get_int(stream)
        self._top_tracks = util.get_set(stream)
        self._top_albums = util.get_set(stream)
        self._top_artists = util.get_set(stream)
        self._bad_artists = util.get_set(stream)
        
    def update(self, stream):
        self._id = stream.readline().strip()
        self._turn = util.get_int(stream)
        self._capacity = util.get_int(stream)
        self._time_left = util.get_int(stream)
        self._track_pos = {}
        self.browse_result(sys.stdin)
        for y in xrange(self._h):
            line = stream.readline().strip()
            for x, square in enumerate(line.split(',')):

                self._map[x, y] = square
                if square == self._id:
                    self._pos = (x, y)
                elif square == 'U':
                    self._user = (x, y)
                elif square.startswith(TRACK_URI_HEADER):
                    self._track_pos[x, y] = square
                    try:
                        metadata = self._metadata[square]
                        self._map[x, y] = '+' if self.track_value(metadata) > 0 else '-'
                    except KeyError:
                        self._map[x, y] = '?'
                        
    def action(self):
        if self._turn == 1:
            # Start by using boost to browse some tracks.
            close_tracks = []
            track_finder = self.find_close_tracks()
            try:
                while len(close_tracks) < 3:
                    close_tracks.append(track_finder.next())
            except StopIteration:
                pass
            logging.debug('Tracks close to %s: %s', self._pos, close_tracks)
            cmd = ['B'] + [self._track_pos[track] for track in close_tracks]
            print ','.join(cmd)
            #sys.stdout.flush()
            #self.browse_result(sys.stdin)
        elif self._turn > 1:
            pf = PathFinder(self._map)
            path_to_user = pf.find_path(self._pos, self._user)
            
            if isinstance(self._objective, MoveToUserObjective):
                pass
            elif len(path_to_user) >= self._turn_limit - self._turn:
                # Move to user since time is running out.
                self._objective = MoveToUserObjective(path_to_user)
            elif (self._objective is None) or not self._objective.is_valid(self._map):
                # Find new objective.
                self._objective = None
                if self._capacity > 0 and len(self._track_pos) > 0:
                    # Move to the closest track.
                    track_finder = self.find_close_tracks()
                    track = None
                    while track is None:
                        try:
                            track = track_finder.next()
                        except StopIteration:
                            break
                        uri = self._track_pos[track]
                        try:
                            metadata = self._metadata[uri]
                            if self.track_value(metadata) > 0:
                                logging.debug('[%d] New objective, get track (%s) at: %s', self._turn, uri, track)
                                path = pf.find_path(self._pos, track)
                                self._objective = GetTrackObjective(path)
                            else:
                                self._bad_tracks.add(track)
                                track = None
                        except KeyError:
                            logging.debug('[%d] Browse track (%s) at: %s', self._turn, uri, track)
                            print uri
                            #sys.stdout.flush()
                            #self.browse_result(sys.stdin)
                else:
                    # Move to user.
                    logging.debug('[%d] New objective, move to user.', self._turn)
                    path = pf.find_path(self._pos, self._user)
                    self._objective = MoveToUserObjective(path)
                
            if self._objective is not None:
                move, is_last_move = self._objective.follow(self._pos)
                if is_last_move:
                    self._objective = None
                print move
                                
    def browse_result(self, stream):
        browsed_tracks = util.get_set(sys.stdin)
        for track in browsed_tracks:
            logging.debug('[%d] Browsed track: %s', self._turn, track)
            uri, metadata = track.split(',', 1)
            self._metadata[uri] = metadata
        
    def find_close_tracks(self):
        pf = PathFinder(self._map)
        candidates = [(util.distance(self._pos, p), False, p) for p in self._track_pos.iterkeys() if p not in self._bad_tracks]
        heapq.heapify(candidates)
        while candidates:
            d, real_distance, pos = heapq.heappop(candidates)
            if real_distance:
                yield pos
            else:
                path = pf.find_path(self._pos, pos)
                if path is not None:
                    heapq.heappush(candidates, (len(path) - 1, True, pos))
    
    def track_value(self, metadata):
        # Simplified, return 1 for good and -1 for bad.
        try:
            title, artist, album, year = metadata.split(',')
        except ValueError:
            # Parse error (metadata contains comma sign).
            return -1
        if metadata in self._top_tracks:
            return -1
        if artist in self._bad_artists:
            return -1
        return 1
    
    def save(self):
        with open(self.save_path(), 'wb') as f:
            pickle.dump(self, f, pickle.HIGHEST_PROTOCOL)
    
    @classmethod
    def load(cls):
        with open(cls.save_path(), 'rb') as f:
            return pickle.load(f)
    
    @classmethod
    def save_path(cls):
        dir_path = os.path.dirname(__file__)
        return os.path.join(dir_path, STATE_FILENAME)

class Objective(object):
    def __init__(self, path):
        self._path = path
        
    def follow(self, current_pos):
        """ Returns tuple: (move, is_last_move) """
        ix = self._path.index(current_pos)
        is_last_move = (ix + 2 == len(self._path))
        return (util.move(self._path[ix], self._path[ix + 1]), is_last_move)
        
class MoveToUserObjective(Objective):
    def __init__(self, path):
        Objective.__init__(self, path)
        
    def is_valid(self, world):
        return True
    
class GetTrackObjective(Objective):
    def __init__(self, path):
        Objective.__init__(self, path)
        
    def is_valid(self, world):
        return world[self._path[-1]] == '+'
    
if __name__ == '__main__':
    monkey = Monkey.process_input(sys.stdin)
    monkey.action()
    monkey.save()
    sys.stdout.flush()
    
