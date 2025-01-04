if (keyboard_check_pressed(vk_enter)) {
    if (vencedor_eh_player) {
        // Player ganhou
        room_goto(rm_mapa);
    } else {
        // Player perdeu
        room_goto(rm_praca);
    }
}
