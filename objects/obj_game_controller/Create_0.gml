if (!variable_global_exists("historico_batalhas")) {
    global.historico_batalhas = ds_list_create();
}

// Somente defina arrays aqui, SEM aspas, usando referências de sprite
if (!variable_global_exists("historico_batalhas")) {
    global.historico_batalhas = ds_list_create();
}

// IMPORTANTE: as arrays precisam conter recursos do tipo SPRITE, não strings
global.gladiator_heads     = [ spr_gladiator_head_1, spr_gladiator_head_2, spr_gladiator_head_3 ];
global.gladiator_bodies    = [ spr_gladiator_body_1, spr_gladiator_body_2 ];
global.gladiator_left_arms = [ spr_gladiator_left_arm_1, spr_gladiator_left_arm_2 ];
global.gladiator_right_arms= [ spr_gladiator_right_arm_1, spr_gladiator_right_arm_2 ];
global.gladiator_left_legs = [ spr_gladiator_left_leg_1, spr_gladiator_left_leg_2 ];
global.gladiator_right_legs= [ spr_gladiator_right_leg_1, spr_gladiator_right_leg_2 ];
global.gladiator_weapons   = [ spr_gladiator_weapon_1, spr_gladiator_weapon_2, spr_gladiator_weapon_3 ];
