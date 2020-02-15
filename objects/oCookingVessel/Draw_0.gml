event_inherited()
draw_self()
if (lineToggle) {
	draw_throw_line_pot()
}
if (ds_grid_get(item_grid, 0, 0) != noone) {

	// pot flash effect
	if (shaderBuff > 0) {
		image_xscale = lerp(image_xscale, 1.5, 0.5)
		image_yscale = lerp(image_yscale, 1.5, 0.5)
		shaderBuff -= 0.15;
	
		gpu_set_blendmode(bm_add);
	
		shader_set(shWhiteFlash);
		shdAlpha = shader_get_uniform(shWhiteFlash, "_alpha");
		shader_set_uniform_f(shdAlpha, shaderBuff);
	
		draw_self();
	
		shader_reset();
		gpu_set_blendmode(bm_normal);
	} else {
		image_xscale = lerp(image_xscale, 1 * sign(image_xscale), 0.6)
		image_yscale = lerp(image_yscale, 1 * sign(image_yscale), 0.6)	
	}
	
	// ingredient window
	var yval = 75
	var xval = 45
	draw_sprite(sVesselWindow, 0, x, y+yval+sin(get_timer()/100000))
	if (ds_grid_get(item_grid, 0, 0) != noone) { //draw first ingredient
		draw_sprite_ext(ds_grid_get(item_grid, 5, 0), 0, x-xval, y+yval+5+sin(get_timer()/100000), 1, 1, 0, c_white, 1)
	}
	if (ds_grid_get(item_grid, 0, 1) != noone) { //draw second ingredient
		draw_sprite_ext(ds_grid_get(item_grid, 5, 1), 0, x, y+yval+5+sin(get_timer()/100000), 1, 1, 0, c_white, 1)
	}
	if (ds_grid_get(item_grid, 0, 2) != noone) { //draw third ingredient
		draw_sprite_ext(ds_grid_get(item_grid, 5, 2), 0, x+xval, y+yval+5+sin(get_timer()/100000), 1, 1, 0, c_white, 1)
	}
}

//draw the arms over the player if they're holding something big
if (held) {
	if (oPlayer.sprite_index == sPlayerIdleHoldingBig) {
		draw_sprite_ext(sBigHoldingArmIdle, oPlayer.image_index, oPlayer.x, oPlayer.y, oPlayer.player_dir, 1, image_angle, c_white, image_alpha);	
	}

	if (oPlayer.sprite_index == sPlayerRunHoldingBig) {
		draw_sprite_ext(sBigHoldingArmRun, oPlayer.image_index, oPlayer.x, oPlayer.y, oPlayer.player_dir, 1, image_angle, c_white, image_alpha);	
	}

	if (oPlayer.sprite_index == sPlayerJumpHoldingBig) {
		draw_sprite_ext(sBigHoldingArmJump, oPlayer.image_index, oPlayer.x, oPlayer.y, oPlayer.player_dir, 1, image_angle, c_white, image_alpha);		
	}

	if (oPlayer.sprite_index == sPlayerFallHoldingBig or oPlayer.sprite_index == sPlayerHurtHoldingBig) {
		draw_sprite_ext(sBigHoldingArmFall, oPlayer.image_index, oPlayer.x, oPlayer.y, oPlayer.player_dir, 1, image_angle, c_white, image_alpha);	
	}
}

//WIP hold to pick up graphic
//if (pick_up_timer > 0 and highlighted) {
//	var perc
//	perc = (pick_up_timer/pick_up_timer_max) * 100
//	scr_health_ring(x, y+10/*-(sprite_height/2)-30+sin(get_timer()/100000)*/, 20, 10, 100, perc, 90, 360+90, 1, c_white)
//}

//debug pot radius
//draw_set_alpha(0.3)
//if held {
//	draw_ellipse(x-(sprite_get_width(sPottyDormant)/2), y-10, x+(sprite_get_width(sPottyDormant)/2), y+10, false)
//} else {
//	draw_circle(x, y, pot_radius, false)
//}