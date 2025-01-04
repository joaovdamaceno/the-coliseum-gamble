function controlar_acao_jogador() {
    if (keyboard_check_pressed(ord("1"))) {
        player.estado_animacao = "atacando";
        player.animacao_timer  = 40;
        registrar_log(player.name + " atacou!");
        battle_state = "player_animando";
    }
    else if (keyboard_check_pressed(ord("2"))) {
        player.estado_animacao = "esquivando";
        player.animacao_timer  = 40;
        registrar_log(player.name + " tenta esquivar!");
        battle_state = "player_animando";
    }
    else if (keyboard_check_pressed(ord("3"))) {
        player.estado_animacao = "defendendo";
        player.animacao_timer  = 40;
        registrar_log(player.name + " está se defendendo.");
        battle_state = "player_animando";
    }
}
