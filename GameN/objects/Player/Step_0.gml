/// @description Insert description here
// You can write your code in this editor
key_left = keyboard_check(vk_left);
key_right = keyboard_check(vk_right);
key_down = keyboard_check(vk_down);
key_up = keyboard_check(vk_up);
key_jump = keyboard_check(vk_space);

var move = key_right - key_left;
var up = key_up - key_down;
show_debug_message(up);
if (state == moveStates.running) {
	hsp = hsp + accel * move;
	if (abs(hsp) > maxSpeed) {
		hsp = hsp - sign(hsp) * accel;
	}
	vsp = vsp + grav;
	if (place_meeting(x, y + 1, oWall)) && (key_jump) {
		vsp += -jump;
	}
	if (vsp < 0) {
		if (!(key_jump)) {
			vsp *= 0.75;
		}
	}
	if (place_meeting(x + hsp, y, oWall)) {
		if (key_up || key_down)
			{
				vsp = -(up * abs(hsp));
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
	vsp = vsp + -(accel * up);
	if (abs(vsp) > maxSpeed) {
		vsp = sign(vsp) * maxSpeed;
	}
	if (place_meeting(x, y + 1, oWall) || place_meeting(x, y - 1, oWall)) {
			vsp = 0;
			state = moveStates.running;
		}
	if (key_jump) {
			hsp = vsp * side * 5;
			vsp = -jump;
			state = moveStates.running;
	}
}
y = y + vsp;

x = x + hsp;