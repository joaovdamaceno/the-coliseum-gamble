// Captura a entrada do jogador
var _h_input = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var _v_input = keyboard_check(ord("S")) - keyboard_check(ord("W"));

// Normaliza a velocidade para evitar movimento diagonal mais rápido
if (_h_input != 0 || _v_input != 0) {
    var _move_direction = point_direction(0, 0, _h_input, _v_input);
    var _h_move = lengthdir_x(move_speed, _move_direction);
    var _v_move = lengthdir_y(move_speed, _move_direction);

    // Movimento com colisão
    if (!place_meeting(x + _h_move, y, obj_solid)) {
        x += _h_move;
    }
    if (!place_meeting(x, y + _v_move, obj_solid)) {
        y += _v_move;
    }

    // Controle de animação (se houver)
    image_speed = 0.2; // Ajuste conforme necessário
} else {
    // Parar animação quando não há movimento
    image_speed = 0;
}