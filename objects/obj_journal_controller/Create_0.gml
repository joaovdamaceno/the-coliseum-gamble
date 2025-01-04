pagina_atual = 0;
batalhas_por_pagina = 2;

if (!variable_global_exists("historico_batalhas")) {
    global.historico_batalhas = ds_list_create();
}
