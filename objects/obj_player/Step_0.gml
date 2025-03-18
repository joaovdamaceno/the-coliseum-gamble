// Horizontal input (left/right)
var _h_input = keyboard_check(vk_right) - keyboard_check(vk_left);
hspd = _h_input * spd;

// Gravity
vspd += grv;

// Horizontal collision
if (place_meeting(x + hspd, y, obj_solid)) {
    while (!place_meeting(x + sign(hspd), y, obj_solid)) {
        x += sign(hspd);
    }
    hspd = 0;
}
x += hspd;

// Vertical collision
if (place_meeting(x, y + vspd, obj_solid)) {
    while (!place_meeting(x, y + sign(vspd), obj_solid)) {
        y += sign(vspd);
    }
    vspd = 0;
}
y += vspd;

// Decide animation state
// If the player is pressing horizontal input, we walk; otherwise idle.
if (_h_input != 0) {
    player.estado_animacao = "walk";
} else {
    player.estado_animacao = "idle";
}