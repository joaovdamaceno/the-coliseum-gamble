// Verificar se o jogador está próximo
if (distance_to_object(obj_player) < 32) {
    if (keyboard_check_pressed(ord("J"))) {
        room_goto(rm_jornal); // Transiciona para a sala do jornal
    }
}
