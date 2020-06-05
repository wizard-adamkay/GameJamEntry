/// @description Insert description here
// You can write your code in this editor

//sprite always facing character
if (Player.x != x)
    image_xscale = sign(Player.x - x);


//firing simple projectiles
cooldown--;
if(cooldown <= 0){
	cooldown = 300;
	with (instance_create_layer(x,y,"Bullets",oProjectile))
	{
		direction = 180;
		speed = 8;
		if(Player.x > other.x){
			direction = 0;
		}
		direction += random_range(-3,3);
		image_angle = direction;
	}
}
