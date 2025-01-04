function iniciar_batalha(){
    // Seleciona um inimigo aleatório
    var _gladiadores_disponiveis = ["Gladiador A", "Gladiador B", "Gladiador C"];

    // Remove o gladiador selecionado pelo jogador para não enfrentar a si mesmo
    array_delete(_gladiadores_disponiveis, array_get_index(_gladiadores_disponiveis, global.player_gladiator), 1);

    global.enemy_gladiator = _gladiadores_disponiveis[irandom(array_length(_gladiadores_disponiveis) - 1)]

    // Transiciona para a sala de batalha
    room_goto(rm_batalha);
}