This is a 3rd person player controller that uses 2 scripts:
One script for camera movement and one script for player movement.

More in-depth breakdowns of how these work in the scripts themselves.

This 3rd person player controller works like the Dark Souls and Mario 64 camera, in the sense that
the player's model does not rotate with the camera, only when there is character movement.

Every other 3rd person player controller I could find either 1. copies the camera rotation directly
onto the player model constantly, which feels and looks really bad and unprofessional, or 2. was
just way too complicated, and would probably take multiple days to actually fully understand.

With this player controller, I think MOST people should EASILY be able to completely understand
how it all works in less than 20 minutes, but it depends on your skill level of course.

There is no jump or sprint or anything. Just 3rd person camera movement and a player body with
lateral movement, aside from gravity affecting the player when falling off a surface.

Disclaimers/Notes:
	1. When you move the player in the main scene, it won't visually look like it's moving,
	but it is! When you playtest you'll see the player starts at the changed position.
	It just looks like that because the PlayerBody needs it's top_level property to be true.
	
	2. The max step height this controller can do is about 0.1m high.
	
	3. The arrow is just to show the rotation of the player model and how it works.
