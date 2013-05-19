#!/usr/bin/python
import unittest

from monkey import Monkey
from path import PathFinder

class TestMonkey(unittest.TestCase):
    def setUp(self):
        self.init_file = open('init.txt', 'r')
        self.turn_file = open('turn.txt', 'r')
        
    def tearDown(self):
        self.init_file.close()
        self.turn_file.close()
        
    def test_init(self):
        monkey = Monkey.process_input(self.init_file)
        self.assertEqual(monkey._id, 9)
        self.assertEqual(monkey._w, 11)
        self.assertEqual(monkey._h, 11)
        self.assertEqual(monkey._turn_limit, 100)
        self.assertEqual(len(monkey._top_tracks), 10)
        self.assertEqual(len(monkey._top_albums), 10)
        self.assertEqual(len(monkey._top_artists), 10)
        self.assertEqual(len(monkey._bad_artists), 5)
        
    def test_turn(self):
        monkey = Monkey.process_input(self.init_file)
        monkey.save()
        monkey = Monkey.process_input(self.turn_file)
        self.assertEqual(monkey._turn, 1)
        self.assertEqual(monkey._capacity, 3)
        self.assertEqual(monkey._time_left, 10000)
        expected_pos = (0, 4)
        expected_user = (10, 5)
        self.assertEqual(monkey._pos, expected_pos)
        self.assertEqual(monkey._map[expected_pos], str(monkey._id))
        self.assertEqual(monkey._user, expected_user)
        self.assertEqual(monkey._map[expected_user], 'U')
        
    def test_path(self):
        monkey = Monkey.process_input(self.init_file)
        monkey.save()
        monkey = Monkey.process_input(self.turn_file)
        pf = PathFinder(monkey._map)
        path = pf.find_path((0, 4), (2, 10))
        self.assertEqual(len(path), 11)
        
if __name__ == '__main__':
    #unittest.main()
    suite = unittest.TestLoader().loadTestsFromTestCase(TestMonkey)
    unittest.TextTestRunner(verbosity=2).run(suite)
    