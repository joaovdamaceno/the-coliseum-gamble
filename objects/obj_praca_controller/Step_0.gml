// Obter o gladiador selecionado antes de qualquer potencial destruição da lista
var _gladiator = ds_list_find_value(gladiadores_disponiveis, gladiador_selecionado);

// Manipulação de entrada do usuário
if (keyboard_check_pressed(vk_up)) {
    gladiador_selecionado = (gladiador_selecionado - 1 + ds_list_size(gladiadores_disponiveis)) mod ds_list_size(gladiadores_disponiveis);
    battle_page = 0; // Reinicia a página ao mudar de gladiador
}

if (keyboard_check_pressed(vk_down)) {
    gladiador_selecionado = (gladiador_selecionado + 1) mod ds_list_size(gladiadores_disponiveis);
    battle_page = 0; // Reinicia a página ao mudar de gladiador
}

if (keyboard_check_pressed(vk_left)) {
    battle_page = max(battle_page - 1, 0);
}

if (keyboard_check_pressed(vk_right)) {
    var _total_battles = ds_list_size(_gladiator.battle_history);
    var _max_page = floor((_total_battles - 1) / battles_per_page);
    battle_page = min(battle_page + 1, _max_page);
}

if (keyboard_check_pressed(vk_enter)) {
    // Jogador compra o gladiador
    global.player_gladiator = _gladiator;
    
    // Remove o gladiador da lista de disponíveis
    ds_list_delete(gladiadores_disponiveis, gladiador_selecionado);
    
    // Limpa a lista
    ds_list_destroy(gladiadores_disponiveis);
    
    // Retorna ao mapa principal
    room_goto(rm_mapa);
    
    exit; // Interrompe a execução do evento Step
}

// Atualizar o scroll com o scroll do mouse
var _delta = mouse_wheel_down() - mouse_wheel_up();
scroll_y += _delta * scroll_speed;

// Limitar o scroll para não ultrapassar os limites
scroll_y = clamp(scroll_y, 0, max_scroll);