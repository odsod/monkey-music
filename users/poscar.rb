# encoding: UTF-8
name "poscar"
country "Sweden"

favorite_tracks([
"Moonlight Sonata - Zero Cult Remix",
"Alchemie Dub",
"Caribbeyond",
"Probability Tree",
"Odysseus Under The Old Tree",
"Wilderness",
"Lost In Translation",
"Molecular Sunrise",
"When The Silence Is Speaking",
"Cruise",
"Deeper (feat. Alyssa Palmer)",
"Bénarès - Vârânaçî Edit",
"Hibernation",
"Process Of Unfolding",
"After The Guidung Venus",
"Summer",
"Altered State - Album Edit",
"Wellness Farm",
"Jeezlh",
"Overload - Putput Mix",
])

favorite_albums([
"When The Silence Is Speaking",
"Sines And Singularities",
"The Divine Invasion",
"Portal Of Perceptions",
"360",
"Future Memories",
"[ Human ]",
"Elementary Particles/Prima Materia",
"Efflorescence",
"Sun Dial",
"Earthshine",
"Natural Born Chillers 2",
"Distances",
"Emotivision",
"A Deep Dive",
"Midnight`s Children",
"In The Air",
"Lungs Of Life",
"Entheogenic",
"Slower Moves",
])

favorite_artists([
"Bluetech",
"Androcell",
"Koan",
"Solar Fields",
"Asura",
"Hol Baumann",
"Entheogenic",
"AES DANA",
"Lemonchill",
"Saafi Brothers",
"Phutureprimitive",
"H.U.V.A. Network",
"Nordlight",
"Vibrasphere",
"Boards of Canada",
"Huva Network",
"Shulman",
"Kuba",
"David Bowie",
"Easily Embarrassed",
])

song({
:uri => "spotify:track:6NmXV4o6bmp704aPGyTVVG", 
:name => "Test song 1", 
:good => true,
:score => 1.8,
:multipliers => [
:from_top_album, 
:by_top_artist, 
:same_album_as_top_track,
:from_favorite_decade,
],
})

song({
:uri => "spotify:track:6NmXV4o6bmp704aPGyTVVG", 
:name => "Test song 2", 
:good => false,
:score => -1.8,
:multipliers => [
:not_available_in_region, 
],
})
