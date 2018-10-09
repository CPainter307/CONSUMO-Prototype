//Get Player input
key_left = keyboard_check(vk_left) || (gamepad_axis_value(0,gp_axislh) < 0);
key_right = keyboard_check(vk_right) ||  (gamepad_axis_value(0,gp_axislh) > 0);
key_jump = keyboard_check_pressed(vk_up) || (gamepad_button_check_pressed(0,gp_face1));
key_jump_held = keyboard_check(vk_up) || (gamepad_button_check(0,gp_face1));


if(key_jump)
{
jumpQueuFramesElapsed = 0;
}


//increase gravity if falling
if(vsp > 0)
{
vsp = vsp + .75
}

//calculate movement
 var move = key_right - key_left;
 hsp = walksp * move;
 vsp = vsp + grv;
 
 if(((totalJumps - currentJumps) > 0) && (jumpQueuFramesElapsed <= 3))
 {	 
 vsp = -15;
 currentJumps = currentJumps + 1;
 }
 
 if  (vsp < 0) && (!key_jump_held) {
	 //vsp += grv;    alternative approach based on grv variable
	 vsp = max(vsp, 0);
	 currentJumps = currentJumps + 1;
 }

 
 
 
 //horizontal collision
 if(place_meeting(x+hsp ,y,oWall))
 {	 
	while(!place_meeting(x+sign(hsp),y,oWall))
	{
	x = x + sign(hsp);
	}
 hsp = 0; 
 }
 x = x + hsp;
 
 
 
 //vertical collision
  if(place_meeting(x,y + vsp,oWall))
 { 
	while(!place_meeting(x,y+sign(vsp),oWall))
		{
			y = y + sign(vsp);
		}
 vsp = 0;
 }
 y = y + vsp;
 
 
 
 //ground detection
 if(place_meeting(x,y+1,oWall))
 {
 currentJumps = 0;
 currentWallJumps = 0;
 sprite_index=sPlayerIdle;

 }
 
 
 
 //animation
 if(!place_meeting(x,y+1,oWall))
 {
	 if(sign(vsp) < 0)
	 {
		sprite_index = sPlayerJump;
	 }
	 else if(sign(vsp) > 0)
	 {
		 sprite_index = sPlayerFall;
	 } 
 }
 else
 {
	if(hsp == 0)
	{
	sprite_index = sPlayerIdle;
	}
	else
	{
	sprite_index = sPlayerRun;
	}
 
 }
 
 //if (hsp != 0) image_xscale = sign(hsp);
 if (hsp != 0) image_xscale = 0.055 * sign(hsp);
 
 jumpQueuFramesElapsed++;
 