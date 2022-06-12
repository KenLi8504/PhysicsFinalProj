# PhysicsFinalProj
By Alex Cho and Ken Li
Our final project is a simulation of a projectile in space that is affected by the gravitational acceleration of planets. It consists of two phases: a sandbox phase, where you can place planets and move them, the goal, and the projectile/rocketship, and a gameplay phase, where everything is locked in and you can only adjust the angle and initial speed of the projectile.

#Sandbox phase
We've spawned in the goal right away.
To spawn in planets, you left click on an empty part of the canvas.
The left and right arrows adjust the radius of the selected planet
Up and down adjust the mass of the selected planet
To spawn in the projectile, you right click on an empty part of the canvas.
To move things around, left click within the sprites and drag them around.
"k" removes the selected planet (the one in blue)
"r" resets everything back to the original state
Finally, the space bar locks everything in and transitions to the gameplay stage
  It doesn't work if there is no projectile spawned in

#Gameplay phase
Left and right arrows now adjust the angle the projectile will travel at when lauched
Up and down adjust the starting speed
There is a velocity vector that indicates direction centered at the projectile
"f" will fire the rocket
  Should the rocket crash into a planet or go out of bounds, it will be reset to the its initial starting position (where you locked it in)
"r" sends the rocket back to the initial starting position (if you know for sure you are going to crash, or if you get stuck in a loop)
"e" transitions back to the sandbox stage
