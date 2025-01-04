function gerar_historico_batalha(_gladiator) {
    var _history = ds_list_create();
    var _num_battles = irandom_range(5, 10);

    for (var _i = 0; _i < _num_battles; _i++) {
        var _opponent_profile = choose("Agressivo", "Defensivo", "Equilibrado");
        var _opponent = criar_perfil_gladiador(_opponent_profile, false);

        var _battle = {
            opponent_name: _opponent.name,
            opponent_profile: _opponent.profile,
            actions: ds_list_create(),
            stats: {} // Armazenará os dados estatísticos
        };

        // Variáveis para acumular dados
        var _total_damage_dealt = 0;
        var _total_damage_received = 0;
        var _num_attacks = 0;
        var _num_defenses = 0;
        var _num_dodges = 0;
        var _num_critical_hits = 0;
        var _damage_dealt_list = ds_list_create();
        var _damage_received_list = ds_list_create();
        var _gladiator_hp = _gladiator.hp;
        var _opponent_hp = _opponent.hp;

        // Continua gerando ações até que a batalha termine
        while (_opponent_hp > 0) {
            var _action = simular_acao(_gladiator, _opponent);
            ds_list_add(_battle.actions, _action);

            // Aplica dano ao oponente
            _opponent_hp -= _action.damage_dealt;
            if (_opponent_hp < 0) _opponent_hp = 0;

            // Aplica dano recebido ao gladiador
            _gladiator_hp -= _action.damage_received;
            if (_gladiator_hp < 0) _gladiator_hp = 0;

            // Acumular dados
            _total_damage_dealt += _action.damage_dealt;
            _total_damage_received += _action.damage_received;

            if (_action.action_type == "Ataque") {
                _num_attacks += 1;
            } else if (_action.action_type == "Defesa") {
                _num_defenses += 1;
            } else if (_action.action_type == "Esquiva") {
                _num_dodges += 1;
            }

            if (_action.critical_hit) {
                _num_critical_hits += 1;
            }

            // Coletar dados de dano para cálculo de variância
            ds_list_add(_damage_dealt_list, _action.damage_dealt);
            ds_list_add(_damage_received_list, _action.damage_received);

            // Parar a batalha se o oponente for derrotado
            if (_opponent_hp <= 0) {
                break;
            }

            // Opcional: Parar a batalha se o gladiador for derrotado (não necessário se todas as batalhas devem ser vitórias)
            // if (_gladiator_hp <= 0) {
            //     // Opcionalmente, registrar a derrota ou parar sem adicionar ao histórico
            //     break;
            // }
        }

        // Verificar se o gladiador venceu
        if (_opponent_hp <= 0) {
            // Calcular dados estatísticos
            var _num_actions = ds_list_size(_battle.actions);
            var _mean_damage_dealt = _total_damage_dealt / _num_actions;
            var _mean_damage_received = _total_damage_received / _num_actions;

            // Variância e desvio padrão do dano causado
            var _variance_damage_dealt = 0;
            for (var _k = 0; _k < ds_list_size(_damage_dealt_list); _k++) {
                var _dmg = ds_list_find_value(_damage_dealt_list, _k);
                _variance_damage_dealt += power((_dmg - _mean_damage_dealt), 2);
            }
            _variance_damage_dealt /= (_num_actions - 1);
            var _std_dev_damage_dealt = sqrt(_variance_damage_dealt);

            // Variância e desvio padrão do dano recebido
            var _variance_damage_received = 0;
            for (var _k = 0; _k < ds_list_size(_damage_received_list); _k++) {
                var _dmg = ds_list_find_value(_damage_received_list, _k);
                _variance_damage_received += power((_dmg - _mean_damage_received), 2);
            }
            _variance_damage_received /= (_num_actions - 1);
            var _std_dev_damage_received = sqrt(_variance_damage_received);

            // Armazenar estatísticas na batalha
            _battle.stats = {
                total_damage_dealt: _total_damage_dealt,
                total_damage_received: _total_damage_received,
                mean_damage_dealt: _mean_damage_dealt,
                mean_damage_received: _mean_damage_received,
                variance_damage_dealt: _variance_damage_dealt,
                variance_damage_received: _variance_damage_received,
                std_dev_damage_dealt: _std_dev_damage_dealt,
                std_dev_damage_received: _std_dev_damage_received,
                num_attacks: _num_attacks,
                num_defenses: _num_defenses,
                num_dodges: _num_dodges,
                num_critical_hits: _num_critical_hits
            };

            ds_list_add(_history, _battle);
        }

        // Destruir as listas temporárias
        ds_list_destroy(_damage_dealt_list);
        ds_list_destroy(_damage_received_list);

        // Destruir oponente e suas listas
        ds_list_destroy(_opponent.battle_history);
    }

    return _history;
}
