draw_text(50, 50, "Jornal de Batalhas (Página " + string(pagina_atual + 1) + ")");

if (ds_list_size(global.historico_batalhas) == 0) {
    draw_text(70, 80, "Nenhuma batalha registrada.");
} else {
    var _inicio = pagina_atual * batalhas_por_pagina;
    var _fim = min(_inicio + batalhas_por_pagina, ds_list_size(global.historico_batalhas));

    var _y_pos = 80;
    for (var _i = _inicio; _i < _fim; _i++) {
        var _dia_result = ds_list_find_value(global.historico_batalhas, _i);

        var data_str = formatar_data(_dia_result.data);
        draw_text(70, _y_pos, "Data: " + data_str);
        _y_pos += 20;

        // 3 colunas
        var col_x = [70, 320, 570];
        var col_w = 200;
        var line_h= 20;

        // ============== COLUNA 1: Luta Principal ==============
        draw_text(col_x[0], _y_pos, "Luta Principal");
        var y_temp = _y_pos + 20;

        draw_text(col_x[0], y_temp, "Vencedor: " + _dia_result.vencedor);
        y_temp += 20;

        // Comentário principal
        y_temp = desenhar_texto_wrapped_retornando_y(_dia_result.comentarioPrincipal, col_x[0], y_temp, col_w, line_h);

        // ============== COLUNA 2: Luta Extra 1 ==============
        if (array_length(_dia_result.extras) >= 1) {
            var extra1 = _dia_result.extras[0];

            draw_text(col_x[1], _y_pos, "Luta 2");
            var y_temp2 = _y_pos + 20;

            draw_text(col_x[1], y_temp2, "Vencedor: " + extra1.vencedor);
            y_temp2 += 20;
            draw_text(col_x[1], y_temp2, "Perdedor: " + extra1.perdedor);
            y_temp2 += 20;

            y_temp2 = desenhar_texto_wrapped_retornando_y(extra1.comentario, col_x[1], y_temp2, col_w, line_h);
        }

        // ============== COLUNA 3: Luta Extra 2 ==============
        if (array_length(_dia_result.extras) >= 2) {
            var extra2 = _dia_result.extras[1];

            draw_text(col_x[2], _y_pos, "Luta 3");
            var y_temp3 = _y_pos + 20;

            draw_text(col_x[2], y_temp3, "Vencedor: " + extra2.vencedor);
            y_temp3 += 20;
            draw_text(col_x[2], y_temp3, "Perdedor: " + extra2.perdedor);
            y_temp3 += 20;

            y_temp3 = desenhar_texto_wrapped_retornando_y(extra2.comentario, col_x[2], y_temp3, col_w, line_h);
        }

        _y_pos += 200; 
    }
}

draw_text(50, room_height - 30, "Use as setas esquerda/direita para navegar. Esc para voltar.");
