/// @description Insert description here
// You can write your code in this editor

if (position_meeting(x + moveSpeed * 5, y, oWall)) {
	moveSpeed *= -1;
}
x = x + moveSpeed;
