function executar_acao(_atacante, _defensor, _acao) {
    if (_acao == "attack") {
        // Verifica se o defensor está esquivando
        if (_defensor.dodging && random(1) < _defensor.dodge_rate) {
            battle_log_push(_defensor.name + " esquivou do ataque de " + _atacante.name + "!");
            _defensor.dodging = false;
            return;
        }
        _defensor.dodging = false; // Reseta o estado de esquiva

        // Calcula o dano
        var _dano = calcular_dano(_atacante, _defensor);

        // Aplica defesa se o defensor estiver defendendo
        if (_defensor.defending) {
            _dano = aplicar_defesa(_defensor, _dano);
            _defensor.defending = false; // Reseta o estado de defesa
        }

        // Atualiza o HP do defensor
        _defensor.hp -= _dano;
        if (_defensor.hp < 0) _defensor.hp = 0;

        // Registra no log
        battle_log_push(_atacante.name + " causou " + string(_dano) + " de dano a " + _defensor.name + ".");

        // Verifica se o defensor foi derrotado
        if (_defensor.hp <= 0) {
            battle_log_push(_defensor.name + " foi derrotado!");
            battle_state = "battle_end";
			finalizar_batalha(); 
            return;
        }
    }
}
