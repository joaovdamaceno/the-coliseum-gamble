function criar_perfil_gladiador(_tipo, _generate_history) {
    if (argument_count < 2) {
        _generate_history = true;
    }

    var _gladiator = {
        name: gerar_nome_aleatorio(),
        hp: 100,
        max_hp: 100,
        attack: 0,
        defense: 0,
        dodge_rate: 0,
        crit_attack_rate: 0,
        crit_defense_rate: 0,
        estado_animacao: "idle",
        animacao_timer: 0,
        animacao_frame: 0,
        profile: _tipo,
        battle_history: ds_list_create(),

        // Sprites modulares
        head_sprite:    -1,
        body_sprite:    -1,
        left_arm_sprite:-1,
        right_arm_sprite:-1,
        left_leg_sprite:-1,
        right_leg_sprite:-1,
        weapon_sprite:  -1
    };

    // Ajuste de atributos para evitar 0 de dano
    switch (_tipo) {
        case "Agressivo":
            // Alto ataque, defesa moderada
            _gladiator.attack = irandom_range(40, 55);
            _gladiator.defense = irandom_range(10, 15);
            _gladiator.dodge_rate = 0.15;
            _gladiator.crit_attack_rate = 0.25;
            _gladiator.crit_defense_rate = 0.1;
            break;
        case "Defensivo":
            // Ataque moderado, defesa alta
            _gladiator.attack = irandom_range(25, 35);
            _gladiator.defense = irandom_range(25, 40);
            _gladiator.dodge_rate = 0.15;
            _gladiator.crit_attack_rate = 0.1;
            _gladiator.crit_defense_rate = 0.25;
            break;
        case "Equilibrado":
            // Atributos médios em tudo
            _gladiator.attack = irandom_range(30, 40);
            _gladiator.defense = irandom_range(15, 25);
            _gladiator.dodge_rate = 0.15;
            _gladiator.crit_attack_rate = 0.15;
            _gladiator.crit_defense_rate = 0.15;
            break;
    }

    // Atribuir sprites aleatórias
    _gladiator.head_sprite     = global.gladiator_heads[    irandom_range(0, array_length(global.gladiator_heads)    - 1)];
    _gladiator.body_sprite     = global.gladiator_bodies[   irandom_range(0, array_length(global.gladiator_bodies)   - 1)];
    _gladiator.left_arm_sprite = global.gladiator_left_arms[irandom_range(0, array_length(global.gladiator_left_arms)- 1)];
    _gladiator.right_arm_sprite= global.gladiator_right_arms[irandom_range(0, array_length(global.gladiator_right_arms)-1)];
    _gladiator.left_leg_sprite = global.gladiator_left_legs[irandom_range(0, array_length(global.gladiator_left_legs)-1)];
    _gladiator.right_leg_sprite= global.gladiator_right_legs[irandom_range(0, array_length(global.gladiator_right_legs)-1)];
    _gladiator.weapon_sprite   = choose(
        -1,
        global.gladiator_weapons[irandom_range(0, array_length(global.gladiator_weapons) - 1)]
    );

    // Gerar histórico de batalhas
    if (_generate_history) {
        _gladiator.battle_history = gerar_historico_batalha(_gladiator);
    }

    return _gladiator;
}
