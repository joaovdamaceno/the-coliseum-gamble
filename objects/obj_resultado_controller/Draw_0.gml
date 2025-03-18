draw_set_halign(fa_left);
draw_set_valign(fa_top);

// Display outcome messages
if (vencedor_eh_player) {
    draw_text(50, 50, "VOCÊ VENCEU!");
    draw_text(50, 70, enemy_nome + " foi derrotado!");
    draw_text(50, 90, "Pressione ENTER para voltar ao mapa.");

    // Player celebrating on the left
    desenhar_gladiador(player_sprites, 200, 250, 7);

} else {
    draw_text(50, 50, "VOCÊ FOI DERROTADO!");
    draw_text(50, 70, enemy_nome + " venceu a batalha...");
    draw_text(50, 90, "Pressione ENTER para voltar à praça.");

    // Enemy celebrating on the right
    desenhar_gladiador(enemy_sprites, 200, 250, 7);
}