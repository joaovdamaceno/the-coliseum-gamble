if (!variable_global_exists("historico_batalhas")) {
    global.historico_batalhas = ds_list_create();
}

// IMPORTANTE: as arrays precisam conter recursos do tipo SPRITE, não strings
global.gladiator_heads     = [ spr_gladiator_head_1, spr_gladiator_head_2, spr_gladiator_head_3, spr_gladiator_head_4, spr_gladiator_head_5, spr_gladiator_head_6 ];
global.gladiator_bodies    = [ spr_gladiator_body_1, spr_gladiator_body_2, spr_gladiator_body_3, spr_gladiator_body_4, spr_gladiator_body_5, spr_gladiator_body_6 ];
global.gladiator_left_arms = [ spr_gladiator_left_arm_1, spr_gladiator_left_arm_2, spr_gladiator_left_arm_3, spr_gladiator_left_arm_4, spr_gladiator_left_arm_5, spr_gladiator_left_arm_6 ];
global.gladiator_right_arms= [ spr_gladiator_right_arm_1, spr_gladiator_right_arm_2, spr_gladiator_right_arm_3, spr_gladiator_right_arm_4, spr_gladiator_right_arm_5, spr_gladiator_right_arm_6 ];
global.gladiator_left_legs = [ spr_gladiator_left_leg_1, spr_gladiator_left_leg_2, spr_gladiator_left_leg_3, spr_gladiator_left_leg_4, spr_gladiator_left_leg_5, spr_gladiator_left_leg_6 ];
global.gladiator_right_legs= [ spr_gladiator_right_leg_1, spr_gladiator_right_leg_2, spr_gladiator_right_leg_3, spr_gladiator_right_leg_4, spr_gladiator_right_leg_5, spr_gladiator_right_leg_6 ];
global.gladiator_weapons   = [ spr_gladiator_weapon_1, spr_gladiator_weapon_2, spr_gladiator_weapon_3, spr_gladiator_weapon_4, spr_gladiator_weapon_5, spr_gladiator_weapon_6 ];

// Variável global para esconder a arma do gladiador
global.hide_weapon = false;

// Gerando seeds aleatórias sempre que o jogo inicia
randomize();
