/// @description Insert description here
// You can write your code in this editor
hsp = 0;
vsp = 0;
grav = 0.75;
accel = 0.2;
maxSpeed = 10;
jump = 12;
side = 0;

//Movement Booleans
spacePressed = false;
leftPressed = false;
rightPressed = false;


enum moveStates {
	running,
	wallRunning,
}
state = moveStates.running;