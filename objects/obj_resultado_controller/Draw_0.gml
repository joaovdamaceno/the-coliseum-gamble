/// Evento Draw de obj_resultado_controller

draw_set_halign(fa_left);
draw_set_valign(fa_top);

// Mensagem
if (vencedor_eh_player) {
    draw_text(50, 50, "VOCÊ VENCEU!");
    draw_text(50, 70, enemy_nome + " foi derrotado!");
    draw_text(50, 90, "Pressione ENTER para voltar ao mapa.");
} else {
    draw_text(50, 50, "VOCÊ FOI DERROTADO!");
    draw_text(50, 70, enemy_nome + " venceu a batalha...");
    draw_text(50, 90, "Pressione ENTER para voltar à praça.");
}

if (vencedor_eh_player) {
    // Player comemorando à esquerda
    desenhar_gladiador_resultado(player_sprites, "comemorando", 200, 250);
    // Inimigo caído à direita
    desenhar_gladiador_resultado(enemy_sprites, "caido", 600, 300);
} else {
    // Inimigo comemorando à direita
    desenhar_gladiador_resultado(enemy_sprites, "comemorando", 600, 250);
    // Player caído à esquerda
    desenhar_gladiador_resultado(player_sprites, "caido", 200, 300);
}
