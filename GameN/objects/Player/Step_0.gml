/// @description Insert description here
// You can write your code in this editor
key_left = keyboard_check(vk_left);
key_right = keyboard_check(vk_right);
key_down = keyboard_check(vk_down);
key_up = keyboard_check(vk_up);
key_jump = keyboard_check(vk_space);
key_shift = keyboard_check(vk_shift);
var move = key_right - key_left;
var up = key_up - key_down;
show_debug_message(up);
if (key_shift) {
	game_set_speed(30, gamespeed_fps);

show_debug_message(side);

//Sets spacePressed to false if you've let go of space.
if ((!key_jump) && (spacePressed)) {
	spacePressed = false;
}
if ((!key_left) && (leftPressed)) {
	leftPressed = false;
}
if ((!key_right) && (rightPressed)) {
	rightPressed = false;
}
if (state == moveStates.running) {
	//Code for acceleration.
	if (abs(hsp) < maxSpeed) {
		hsp = maxSpeed * move;
	} else {
		if ((sign(hsp) != sign(move)) && (move != 0)) {
			//Reverses direction but loses excess speed.
			hsp = sign(hsp) * -maxSpeed;
		} else {
			//If you're not on the wall and pressing the same direction you won't accelerate.
			hsp = hsp + accel * move;
		}
	}
	//Code for slowing you down if you're not pressing a direction.
	if ((move == 0) && (place_meeting(x,y + 1, oWall))) {
		hsp *= 0.85;
	}
	//if you touch a wall, sets your hsp to 0.
	if ((abs(hsp) < (maxSpeed / 2)) && !place_meeting(x,y + 1, oWall)) {
		hsp = 0;
	}
	//Code for gravity.
	vsp = vsp + grav;
	//Checks for jump.
	if (place_meeting(x, y + 1, oWall)) && !(spacePressed) && (key_jump) {
		vsp += -jump;
		spacePressed = true;
	}

	//Code for horizontal collision.
	if (place_meeting(x + hsp, y, oWall)) {
		while (!place_meeting(x + sign(hsp),y,oWall))
		{
			//Gets you right next to a wall on collision instead of inside.
			x = x + sign(hsp);
		}
		if ((up != 0) && (place_meeting(x + sign(hsp),y,oWall) || place_meeting(x + -sign(hsp),y,oWall))) {
			//Kicks you into wallrunning state on entering a wall.
			//Sets hsp to maxSpeed if below for some reason.
			if (hsp < maxSpeed) {
				hsp = sign(hsp) * maxSpeed;
			}
			if (up == 1) {
				vsp = sign(vsp) * abs(hsp);
			} else {
				vsp = -(up * abs(hsp));
			}
			side = sign(hsp);
			hsp = 0;
			state = moveStates.wallRunning;
		} else {
			//If you're not pressing right or left it nulls your horizontal speed.
			hsp = 0;
		}
	}
	//Code for vertical collision
	if (place_meeting(x, y + vsp, oWall)) {
		while (!place_meeting(x,y + sign(vsp),oWall))
		{
			y = y + sign(vsp);
		}
		vsp = 0;
	}
}
//Code for wallRunning
if (state == moveStates.wallRunning) {
	//Allows changing direction in wallrunning.
	if (sign(up) == sign(vsp) && move != 0) {
		vsp *= -1;
	}
	//Checks if there's something blocking you moving up or down, kicks you into normal mode.

	//Checks if there's wall to wallrun on, kicks you into normal mode.
	if (!place_meeting(x + 1, y, oWall) && !place_meeting(x - 1, y, oWall)) {
			state = moveStates.running;
		}
	//Checks whether you've pressed space, kicks you into normal mode.
	if (key_jump && !spacePressed) {
		if (side != move) {
		hsp = -abs(vsp) * side;
		vsp = -jump;
		state = moveStates.running;
		}
	}
	if (place_meeting(x, y + vsp, oWall)) {
		while (!place_meeting(x,y + vsp,oWall))
		{
			//Gets you right next to a wall.
			y = y + sign(hsp);
		}
	}
		if (place_meeting(x, y + 1, oWall) || place_meeting(x, y - 1, oWall)) {
			vsp = 0;
			state = moveStates.running;
		}

}
//Executes positional changes.
y = y + vsp;
x = x + hsp;