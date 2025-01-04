function calcular_dano(_atacante, _defensor) {
    var dano_base = _atacante.attack;
    var variacao = 1 + irandom_range(-8,8)*0.01;
    var dano = dano_base * variacao;

    if (random(1) < _atacante.crit_attack_rate) {
        dano *= 2;
        registrar_log(_atacante.name + " fez um golpe crítico!");
    }

    // Se defensor estiver defendendo
    if (_defensor.estado_animacao == "defendendo") {
        dano *= 0.65;
        registrar_log(_defensor.name + " bloqueou parte do dano!");
    }
    else if (_defensor.estado_animacao == "esquivando") {
        if (random(1) < _defensor.dodge_rate * 1.5) {
            registrar_log(_defensor.name + " esquivou completamente!");
            return 0;
        }
    }

    dano -= _defensor.defense;
    if (dano < 0) dano = 0;
    if (dano > 0) dano = max(1, floor(dano));

    return dano;
}
