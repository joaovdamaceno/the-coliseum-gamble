function simular_batalha(_gladiator, _opponent){
    // Simulação simples baseada na soma dos atributos de ataque e defesa
    var _gladiator_score = _gladiator.attack + _gladiator.defense + random(10);
    var _opponent_score = _opponent.attack + _opponent.defense + random(10);
    
    if (_gladiator_score > _opponent_score) {
        return "Vitória";
    } else {
        return "Derrota";
    }
}