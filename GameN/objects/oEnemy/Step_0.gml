/// @description Insert description here
// You can write your code in this editor
image_xscale = sign(moveSpeed);
if (position_meeting(x + moveSpeed * 4, y, oWall)) {
	
	moveSpeed *= -1;
}
x = x + moveSpeed;
