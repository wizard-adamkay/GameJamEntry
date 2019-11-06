/// @description Insert description here
// You can write your code in this editor

if (position_meeting(x + movespeed * 5, y, oWall)) {
	movespeed *= -1;
}
x = x + movespeed;
