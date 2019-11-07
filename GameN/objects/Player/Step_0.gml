/// @description Insert description here
// You can write your code in this editor
key_left = keyboard_check(vk_left);
key_right = keyboard_check(vk_right);
key_down = keyboard_check(vk_down);
key_up = keyboard_check(vk_up);
key_jump = keyboard_check(vk_space);

var move = key_right - key_left;
var up = key_up - key_down;

//Sets spacePressed to false if you've let go of space.
if ((!key_jump) && (spacePressed)) {
	spacePressed = false;
}
if (state == moveStates.running) {
	//Code for acceleration.
	hsp = hsp + accel * move;
	//Code for setting speed to maxspeed.
	if (abs(hsp) > maxSpeed) {
		hsp = hsp - sign(hsp) * accel;
	}
	//Code for gravity.
	vsp = vsp + grav;
	//Checks for jump.
	if (place_meeting(x, y + 1, oWall)) && !(spacePressed) && (key_jump) {
		vsp += -jump;
		spacePressed = true;
		show_debug_message("heyo this is jump");
	}
	//Checks if you're pressing down space while moving upwards. Allows granular control of jumping.
	if (vsp < 0) {
		if (!(spacePressed)) {
			vsp *= 0.75;
		}
	}
	//Kicks you into wallrunning state.
	if (place_meeting(x + hsp, y, oWall)) {
		if (key_up || key_down)
			{
				vsp = -(up * maxSpeed);
				side = sign(hsp);
				hsp = 0;
				state = moveStates.wallRunning;
			}
		else {
			while (!place_meeting(x + sign(hsp),y,oWall))
			{
				x = x + sign(hsp);
			}
			hsp = 0;
		}
	}
	
	if (place_meeting(x, y + vsp, oWall)) {
		while (!place_meeting(x,y + sign(vsp),oWall))
		{
			y = y + sign(vsp);
		}
		vsp = 0;
	}
	if (move == 0) {
		hsp *= 0.4;
	}
}
if (state == moveStates.wallRunning) {
	hsp = 0;
	if (abs(vsp) > maxSpeed) {
		vsp = sign(vsp) * maxSpeed;
	}
	if (place_meeting(x, y + 1, oWall) || place_meeting(x, y - 1, oWall)) {
			vsp = 0;
			state = moveStates.running;
		}
	if (!place_meeting(x + 1, y, oWall) && !place_meeting(x - 1, y, oWall)) {
			state = moveStates.running;
		}
	if (key_jump && !spacePressed) {
			hsp = vsp * side * 5;
			vsp = -jump;
			state = moveStates.running;
	}
}
//Code executes positional changes.
y = y + vsp;

x = x + hsp;