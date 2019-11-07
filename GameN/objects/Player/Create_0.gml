/// @description Insert description here
// You can write your code in this editor
hsp = 0;
vsp = 0;
grav = 0.2;
accel = 0.2;
maxSpeed = 4;
jump = 15;
side = 0;
jumpLength = 60;

enum moveStates {
	running,
	wallRunning
}
state = moveStates.running;