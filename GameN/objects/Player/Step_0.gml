/// @description Insert description here
// You can write your code in this editor
key_left = keyboard_check(ord("A"));
key_right = keyboard_check(ord("D"));
key_down = keyboard_check(ord("S"));
key_up = keyboard_check(ord("W"));
key_jump = keyboard_check(vk_space);
key_shift = keyboard_check(vk_shift);
var move = key_right - key_left;
var up = key_up - key_down;


//Sets spacePressed to false if you've let go of space.
if ((!key_jump) && (spacePressed)) {
	spacePressed = false;
}
if ((!key_shift) && (shiftPressed)) {
	shiftPressed = false;
}
if ((!key_left) && (leftPressed)) {
	leftPressed = false;
}
if ((!key_right) && (rightPressed)) {
	rightPressed = false;
}
if (state == moveStates.running) {
	//Horizontal speed for if the player is on solid ground vs in midair.
	if (place_meeting(x,y + 1, oWall)) {
		if (move != 0) {
			if (abs(hsp) < maxSpeed) {
				hsp = maxSpeed * move;
			} else {
				if ((sign(hsp) != sign(move)) && (move != 0)) {
					//Reverses direction but loses excess speed.
					hsp = sign(hsp) * -maxSpeed;
				}
			}
		} else {
			hsp *= 0.85;
		}
	} else {
		speedVar = hsp + accel * move;
		if (abs(speedVar) < maxSpeed) {
			hsp = speedVar;
		}
	}

	//Code for gravity.
	vsp = vsp + grav;
	//Checks for jump.
	if (place_meeting(x, y + 1, oWall)) && !(spacePressed) && (key_jump) {
		vsp += -jump;
		spacePressed = true;
	}
	//Shift speed boost.
	if (!(shiftPressed) && (key_shift)) {
		velocity = sqrt(power(hsp, 2) + power(vsp, 2)) + shiftSpeed;
		dir = sqrt(power(mouse_x - x, 2) + power(mouse_y - y, 2));
		vx = (mouse_x - x) / dir;
		vy = (mouse_y - y) / dir;
		hsp = vx * velocity;
		vsp = vy * velocity;
		
		

		
		shiftPressed = true;
	}

	//Code for horizontal collision.
	if (place_meeting(x + hsp, y, oWall)) {
		//Gets you right next to a wall on collision instead of inside.
		while (!place_meeting(x + sign(hsp),y,oWall))
		{
			x = x + sign(hsp);
		}
		//Kicks you into wallrunning state on entering a wall.
		//Sets hsp to maxSpeed if below for some reason.
		if ((up != 0) && (place_meeting(x + sign(hsp),y,oWall) || place_meeting(x + -sign(hsp),y,oWall))) {
			if (hsp < maxSpeed) {
				hsp = maxSpeed;
			}
			vsp = sign(vsp) * abs(hsp);
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
	//Checks if there's wall to wallrun on, kicks you into normal mode.
	if (!place_meeting(x + 1, y, oWall) && !place_meeting(x - 1, y, oWall)) {
		state = moveStates.running;
	}
	//Checks whether you've pressed space, kicks you into normal mode.
	if (key_jump && !spacePressed) {
			show_debug_message("Heyo");
			show_debug_message(side);	
			hsp = abs(vsp) * move;
			vsp = -jump;
			state = moveStates.running;
	}
	
	if (place_meeting(x, y + 1, oWall) || place_meeting(x, y - 1, oWall)) {
		vsp = 0;
		state = moveStates.running;
	}
}
//Executes positional changes.
y = y + vsp;
x = x + hsp;