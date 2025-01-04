function desenhar_texto_wrapped_retornando_y(_texto, _x, _y, _width, _line_height) {
    var words = string_split(_texto, " ");
    var line = "";
    for (var i = 0; i < array_length(words); i++) {
        var test_line = (string_length(line) == 0) ? words[i] : line + " " + words[i];
        if (string_width(test_line) > _width) {
            draw_text(_x, _y, line);
            _y += _line_height;
            line = words[i];
        } else {
            line = test_line;
        }
    }
    if (string_length(line) > 0) {
        draw_text(_x, _y, line);
        _y += _line_height;
    }
    return _y;
}
