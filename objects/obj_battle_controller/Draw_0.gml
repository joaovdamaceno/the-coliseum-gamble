draw_text(50, 50, player.name + " HP: " + string(player.hp) + "/" + string(player.max_hp));
draw_text(50, 70, enemy.name + " HP: " + string(enemy.hp) + "/" + string(enemy.max_hp));

// Desenhar player
desenhar_gladiador(player, room_width/2 - 128, 220);

// Desenhar inimigo
desenhar_gladiador(enemy, room_width/2 + 128, 220);

if (battle_state == "player_turn") {
    draw_text(50, 100, "Escolha sua ação:");
    draw_text(70, 130, "1. Atacar");
    draw_text(70, 150, "2. Esquivar");
    draw_text(70, 170, "3. Defender");
}

// Log
var log_y = 320;
for (var i = max(0, ds_list_size(battle_log) - 5); i < ds_list_size(battle_log); i++) {
    draw_text(50, log_y, ds_list_find_value(battle_log, i));
    log_y += 20;
}
