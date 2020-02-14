/// @description Initializes variables all holdable objects will have.
my_sprite_index = sprite_index
name = ""
followingL = false;
followingR = false;
highlighted = false;
playedPickupSound = false;
objDepth = depth;
placed = false;
collision_type = "circle";

throw_speed = 1200;
gravity_loc = 150;
meter_per_pix =  0.1
update_speed = 120
grav = gravity_loc; // meter/sec^2
grav = grav / meter_per_pix   //  pix/sec^2
grav = grav /  sqr(update_speed)


pickUpSound = snd_pickup_generic;
landSound = snd_object_land;

var fix;
fix = physics_fixture_create()
//physics_fixture_set_circle_shape(fix, 8)
physics_fixture_set_polygon_shape(fix);
physics_fixture_add_point(fix, -25, 10);
physics_fixture_add_point(fix, -10, -20);
physics_fixture_add_point(fix, 10, -20);
physics_fixture_add_point(fix, 25, 10);
physics_fixture_add_point(fix, 0, 20);
physics_fixture_set_linear_damping(fix, 0)
physics_fixture_set_angular_damping(fix, 1)
physics_fixture_set_friction(fix, 1)
physics_fixture_set_density(fix, 0.5);
physics_fixture_bind(fix, self)
physics_fixture_delete(fix)
phy_active = true
physics_world_gravity(0, gravity_loc)
apply_gravity = true

mass = 270

play_hit_sound = true

outline_init()
