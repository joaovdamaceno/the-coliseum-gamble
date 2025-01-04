if (keyboard_check_pressed(vk_left)) {
    pagina_atual = max(pagina_atual - 1, 0);
}
if (keyboard_check_pressed(vk_right)) {
    var _total_paginas = 1;
    if (ds_list_size(global.historico_batalhas) > 0) {
        _total_paginas = ceil(ds_list_size(global.historico_batalhas) / batalhas_por_pagina);
    }
    pagina_atual = min(pagina_atual + 1, _total_paginas - 1);
}
if (keyboard_check_pressed(vk_escape)) {
    // Volta ao mapa ou praca, dependendo da sua lógica
    room_goto(rm_mapa);
}
