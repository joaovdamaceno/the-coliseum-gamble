function desenhar_texto_wrapped(_texto, _x, _y, _width, _line_height) {
    var words = string_split(_texto, " ");
    var line = "";
    for (var i = 0; i < array_length(words); i++) {
        var test_line = line;
        if (string_length(line) == 0) {
            // se line está vazio, começa com a word
            test_line = words[i];
        } else {
            // caso contrário, tenta adicionar " word"
            test_line = line + " " + words[i];
        }

        // Se test_line excede a largura, desenhamos a "line" anterior e pulamos a linha
        if (string_width(test_line) > _width) {
            draw_text(_x, _y, line);
            _y += _line_height;
            line = words[i]; // começa uma nova linha
        } else {
            // cabe na mesma linha
            line = test_line;
        }
    }
    // desenhar a última linha
    if (string_length(line) > 0) {
        draw_text(_x, _y, line);
        _y += _line_height;
    }
}
