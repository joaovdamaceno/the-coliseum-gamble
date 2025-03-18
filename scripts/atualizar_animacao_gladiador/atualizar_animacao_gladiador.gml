function atualizar_animacao_gladiador(_g) {
    if (_g.animacao_timer > 0) {
        _g.animacao_timer--;
        if (_g.animacao_timer <= 0) {
            _g.estado_animacao = "idle";
        }
    }
}