draw_self();

// Se o jogador estiver próximo, desenhe a mensagem acima do objeto
if (distance_to_object(obj_player) < 32) {
    draw_set_halign(fa_center);
    draw_text(x, y - sprite_get_height(sprite_index) / 2 - 20, "Pressione 'Enter' para iniciar a batalha");
    draw_set_halign(fa_left); // Reseta o alinhamento
}
