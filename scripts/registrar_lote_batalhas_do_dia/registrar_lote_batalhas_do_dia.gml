function registrar_batalhas_do_dia(_playerVenceu) {
    var dataAtual = date_current_datetime();
    var nomeVencedor = (_playerVenceu) ? player.name : enemy.name;
    var nomePerdedor = (_playerVenceu) ? enemy.name : player.name;

    // Gera comentário principal
    var comentarioP = gerar_comentario_principal(nomeVencedor, nomePerdedor);

    // Duas lutas extras
    var extra1 = simular_luta_aleatoria();
    var extra2 = simular_luta_aleatoria();

    var _resultadoDia = {
        data: dataAtual,
        vencedor: nomeVencedor,
        comentarioPrincipal: comentarioP,
        extras: [ extra1, extra2 ]
    };

    if (!variable_global_exists("historico_batalhas")) {
        global.historico_batalhas = ds_list_create();
    }
    ds_list_add(global.historico_batalhas, _resultadoDia);
}
