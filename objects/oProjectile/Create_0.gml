//event_inherited()

dirx = 1
diry = 0
spd = 10

hitbox = instance_create_depth(x, y, -y, Hitbox)

hitbox.OwnerClass = "Enemy";
hitbox.targetClass = "Adventurer";
hitbox.movePower = 10;
hitbox.attack = 1;
hitbox.attackMultiplier = 1;