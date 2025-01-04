function simular_acao(_gladiator, _opponent) {
    var _action_type = choose("Ataque", "Esquiva", "Defesa");
    var _critical_hit = false;
    var _damage_dealt = 0;
    var _damage_received = 0;
    var _result = "";
    var _time = irandom_range(1, 5); // Tempo da ação em segundos
    var _hit_chance = 0; // Probabilidade de acerto

    switch (_action_type) {
        case "Ataque":
            // Verifica se é um golpe crítico
            if (random(1) < _gladiator.crit_attack_rate) {
                _critical_hit = true;
            }

            // Calcula o dano
            _damage_dealt = _gladiator.attack + (_critical_hit ? _gladiator.attack * 0.5 : 0);

            // Calcula a chance de acerto
            _hit_chance = 1 - _opponent.dodge_rate;

            // O oponente tenta esquivar
            if (random(1) < _opponent.dodge_rate) {
                _result = "Esquiva do Oponente";
                _damage_dealt = 0;
            } else {
                _result = "Acerto";
            }
            break;

        case "Esquiva":
            _result = "Esquiva Bem-sucedida";
            _hit_chance = _gladiator.dodge_rate;
            break;

        case "Defesa":
            _result = "Defesa Bem-sucedida";
            _hit_chance = _gladiator.crit_defense_rate;
            break;
    }

    // O oponente pode contra-atacar
    if (_action_type != "Defesa" && random(1) < 0.5) {
        _damage_received = _opponent.attack - _gladiator.defense;
        if (_damage_received < 0) _damage_received = 0;
    }

    var _action = {
        action_type: _action_type,
        damage_dealt: _damage_dealt,
        damage_received: _damage_received,
        result: _result,
        critical_hit: _critical_hit,
        time: _time,
        hit_chance: _hit_chance
    };

    return _action;
}
