if (distance_to_object(obj_player) < 32) { // Verifica se o jogador está próximo
    if (keyboard_check_pressed(vk_enter)) {
        iniciar_batalha();
    }
}