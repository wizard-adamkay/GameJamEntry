/// @description Insert description here
// You can write your code in this editor

if (position_meeting(x + moveSpeed * 5, y, oWall)) {
	image_xscale = sign(moveSpeed);
	moveSpeed *= -1;
}
x = x + moveSpeed;
