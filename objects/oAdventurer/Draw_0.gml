draw_set_alpha(1);
draw_self();
if (global.fightStarted) {
	draw_healthbar(x-50, y+100, x+50, y+125, (currentHealth/maxHealth) * 100, c_blue, c_red, c_lime, 0, true, true)
}

if (flash > 0)
{
	flash -= 0.25;
	
	gpu_set_blendmode(bm_add);
	
	shader_set(shHit2);
	shdAlpha1 = shader_get_uniform(shHit2, "_alpha");
	shader_set_uniform_f(shdAlpha1, flash);
	
	draw_self();
	
	shader_reset();
	gpu_set_blendmode(bm_normal);
}

if (shaderBuff > 0)
{
	shaderBuff -= 0.05;
	
	gpu_set_blendmode(bm_add);
	
	shader_set(shBuff);
	shdAlpha = shader_get_uniform(shBuff, "_alpha");
	shader_set_uniform_f(shdAlpha, shaderBuff);
	
	draw_self();
	
	shader_reset();
	gpu_set_blendmode(bm_normal);
}