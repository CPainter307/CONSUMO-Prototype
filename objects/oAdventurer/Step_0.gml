current_recipe = instance_place(x, y, oRecipe)
if current_recipe {
	lastBowl = instance_place(x, y, oRecipe).bowl_sprite //still kinda weird for some reason
	part_type_sprite(global.pt_BowlToss, lastBowl, 1, 0, 0);
	part_emitter_burst(global.ps, global.pe_BowlToss, global.pt_BowlToss, 1);
	part_emitter_region(global.ps, global.pe_BowlToss, x-8, x+8, y-8, y+8, ps_shape_rectangle, ps_distr_linear);
	scr_adventurer_eat_recipe()	
}

if attackTimer > 0 {
	attackTimer--
}
if defenseTimer > 0 {
	defenseTimer--
} 
if speedTimer > 0 {
	speedTimer--
}
battleWindow.cur_atk = lerp(battleWindow.cur_atk, attackTimer, 0.5)
battleWindow.cur_def = lerp(battleWindow.cur_def, defenseTimer, 0.5)
battleWindow.cur_spd = lerp(battleWindow.cur_spd, speedTimer, 0.5)

//i frames
if place_meeting(x, y, Hitbox) and is_vulnerable {
	is_vulnerable = false
	i_frames = I_FRAME_LENGTH
}
if !is_vulnerable {
	image_alpha = .5
	i_frames--
}
if i_frames <= 0 {
	image_alpha = 1
	is_vulnerable = true
}

//move 1
//This is our first attack
if(((timer_m1) * (baseSpeed/100) * speedMultiplier) >= move_1[0] and instance_exists(Enemy)) {
	var Hitbox_1 = instance_create_depth(Enemy.x, Enemy.y, 0, Hitbox);
	Hitbox_1.OwnerClass = "Adventurer";
	Hitbox_1.targetClass = "Enemy";
	Hitbox_1.movePower = move_1[1];
	Hitbox_1.attack = baseAttack;
	Hitbox_1.attackMultiplier = attackMultiplier;
	//Start attack animation
	sprite_index = attackSprite;
	image_index = 0;
	
	timer_m1 = 0;
}

//move 2
//This is our second attack
if(((timer_m2) * (baseSpeed/100) * speedMultiplier) >= move_2[0] and instance_exists(Enemy)) {
	var Hitbox_2 = instance_create_depth(Enemy.x, Enemy.y, 0, Hitbox);
	Hitbox_2.OwnerClass = "Adventurer";
	Hitbox_2.targetClass = "Enemy";
	Hitbox_2.movePower = move_2[1];
	Hitbox_2.attack = baseAttack;
	Hitbox_2.attackMultiplier = attackMultiplier;
	//Start attack animation
	sprite_index = attackSprite;
	image_index = 0;
	
	timer_m2 = 0;
}

timer_m2++;
timer_m1++;

if (!stallHunger and hunger >= 0) {
	hunger -= 0.1	
} else if (stallHungerTimer >= 60) {
	stallHunger = false;
	stallHungerTimer = 0;
	hunger = 100;
} else if (stallHunger) {
	stallHungerTimer++;	
}

//If we're at the end of our attack animation, change to idle animation
if (sprite_index == attackSprite) && (image_index == sprite_get_number(attackSprite) - 1) {
	sprite_index = idleSprite;	
}

if (healthThisFrame > currentHealth) {
	flash = 1;
}

healthThisFrame = currentHealth;

if previousHealth > currentHealth { // took damage
	battleWindow.prev_health = lerp(battleWindow.prev_health, (previousHealth/maxHealth)*100, 0.4)
	battleWindow.cur_health = lerp(battleWindow.cur_health, (currentHealth/maxHealth)*100, 0.4)
	battleWindow.cur_healed = lerp(battleWindow.cur_health, (currentHealth/maxHealth)*100, 0.4)
} else { // healed
	battleWindow.cur_healed = lerp(battleWindow.cur_health, (currentHealth/maxHealth)*100, 0.4)
}
	

//check if dead
if (currentHealth <= 0) {
	instance_destroy()
}

//emit proper particles
scr_emit_buff_particles(attackTimer > 0, defenseTimer > 0, speedTimer > 0);


// Follow the path if path exists
if path_exists(path_building) {
    scr_follow_the_path(path_building);
}

if !place_meeting(x, y+1, oCollidable) {
	motiony = motiony + 10	
} else {
	if place_meeting(x, y+1, oOneWayPlatform) {
		walking_on = oOneWayPlatform
	} else {
		walking_on = oCollidable
	}
}
//Collision horizontal with object Collision
if place_meeting(x+motionx, y, oCollidable) {
    while !place_meeting(x+sign(motionx), y, oCollidable) {
        x += sign(motionx);
    }
    motionx = 0;
}
x += motionx;

// Collision vertical with object Collision
if place_meeting(x, y+motiony, oCollidable) {
    while !place_meeting(x, y+sign(motiony), oCollidable) {
        y += sign(motiony);
    }
    motiony = 0;
}
y += motiony;