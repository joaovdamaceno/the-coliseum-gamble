function aplicar_defesa(_defensor, _dano_recebido) {
    var _defesa_total = _defensor.defense;

    // Defesa Crítica
    if (random(1) < _defensor.crit_defense_rate) {
        _defesa_total *= 2;
        battle_log_push(_defensor.name + " realizou uma defesa crítica!");
    }

    var _dano_final = _dano_recebido - _defesa_total;
    if (_dano_final < 0) _dano_final = 0;

    return _dano_final;
}
