// ====== COLORS & FONTS ======
// Example RGBA Colors
var cor_titulo     = #81492C;   
var cor_subtitulo  = #81492C;  
var cor_texto      = #81492C;                     
var cor_selecao    = #F1B881;  

draw_set_font(fnt_default);

// ====== BACKGROUND ======
var paper_x = 30; // X position for the background
var paper_y = 16; // Y position for the background
var paper_width = room_width - 343; // Width of the paper area
var paper_height = room_height - 64; // Height of the paper area

var paper_shadow_color = make_color_rgb(0, 0, 0); 
var paper_shadow_offset_x = 3; // Horizontal offset
var paper_shadow_offset_y = 3; // Vertical offset
var paper_shadow_alpha = 0.2;

// Draw shadow
draw_sprite_stretched_ext(spr_medieval_paper, 0, paper_x + paper_shadow_offset_x, paper_y + paper_shadow_offset_y,
		paper_width, paper_height, paper_shadow_color, paper_shadow_alpha);

draw_sprite_stretched(spr_medieval_paper, 0, paper_x, paper_y, paper_width, paper_height);

// ====== MAIN TITLE ======
draw_set_halign(fa_left);
draw_set_valign(fa_top);

draw_set_color(cor_titulo);
draw_text(100, 64, "Praça dos Gladiadores");

// ====== SUBTITLE / Instruction ======
draw_set_color(cor_subtitulo);
draw_text(100, 94, "Selecione um Gladiador para Comprar:");

// ====== LIST OF GLADIATORS ======
var _y_start = 124;
draw_set_color(cor_texto);

for (var _i = 0; _i < ds_list_size(gladiadores_disponiveis); _i++) {
    var _gladiator_item = ds_list_find_value(gladiadores_disponiveis, _i);
    var _text = _gladiator_item.name;
    var _pos_y = _y_start + _i * 20;

    // If selected, highlight
    if (_i == gladiador_selecionado) {
        // Draw a light rectangle behind it
        draw_set_color(cor_texto);
        draw_rectangle(95, _pos_y, 300, _pos_y + 17, false);

        draw_set_color(cor_selecao);
        _text = "> " + _text;
    } else {
        draw_set_color(cor_texto);
    }

    draw_text(100, _pos_y, _text);
}

// Draw vertical line
draw_set_color(#A25B38);
var vertical_line_w = 1;
var vertical_line_h = room_height - 180;
draw_rectangle(394, 64, 394 + vertical_line_w, 80 + vertical_line_h, false);

// ====== CONTROLLERS TUTORIAL ======
draw_set_color(cor_texto);
draw_text_ext(100, room_height - 280,
		"Use as setas esquerda/direita para navegar pelas batalhas.\n\nUse o scroll do mouse para visualizar mais.\n\nPressione Enter para comprar o gladiador selecionado.", 
		20, 270);

// ====== SHOW HISTORY FOR SELECTED GLADIATOR ======
var _gladiator = ds_list_find_value(gladiadores_disponiveis, gladiador_selecionado);

var _history_x = 432; 
var _history_y = 64;  // Vertical offset
draw_set_color(cor_titulo);
draw_text(_history_x, _history_y, "Histórico de " + _gladiator.name + " (Página " + string(battle_page + 1) + ")");

// ====== MARGINS & SCISSOR AREA ======
var margin_top       = 80; 
var margin_bottom    = 100; 
var margin_left      = _history_x;
var margin_right_end = room_width - 20;

var draw_area_x      = margin_left;
var draw_area_y      = margin_top;
var draw_area_width  = margin_right_end - margin_left;
var draw_area_height = room_height - margin_top - margin_bottom;

// ====== GLADIATOR (Sprite) ON THE RIGHT SIDE ======
var sprite_x = room_width - 248; 
var sprite_y = 148;

// Idle animation (light rotation & squash)
var idle_angle = sin(current_time / 1000) * 5;
var idle_y = sin(current_time / 500) * 2;
var idle_squash = 1 + 0.04 * sin(current_time / 500);
var gladiator_scale = 7;

// Define shadow color and offset
var shadow_color = make_color_rgb(0, 0, 0); 
var shadow_offset_x = 5; // Horizontal offset
var shadow_offset_y = 5; // Vertical offset
var shadow_alpha = 0.2;

// Draw shadows
draw_set_color(shadow_color);

desenhar_gladiador(_gladiator, sprite_x, sprite_y, gladiator_scale, shadow_offset_x, shadow_offset_y, shadow_alpha);

// Draw roman pillar below selected gladiator
draw_sprite_ext(spr_roman_pillar, 0, sprite_x - (8 * gladiator_scale), sprite_y + (31 * gladiator_scale), 
        gladiator_scale, gladiator_scale, 0, c_white, 1);

// ====== SCISSOR TEST & RENDER HISTORY ======
gpu_set_scissor(draw_area_x, draw_area_y + 16, draw_area_width, draw_area_height);

// Calculate vertical offset
var _y_history_start = margin_top + 16;
var _y_history       = _y_history_start - scroll_y;

var _start_battle = battle_page * battles_per_page;
var _end_battle   = min(_start_battle + battles_per_page, ds_list_size(_gladiator.battle_history));

var _total_height = 0; 

for (var j = _start_battle; j < _end_battle; j++) {
    var _battle = ds_list_find_value(_gladiator.battle_history, j);

    // Sub-title for each battle
    draw_set_color(cor_subtitulo);
    draw_text(_history_x, _y_history, "Batalha contra: " + _battle.opponent_name + " (" + _battle.opponent_profile + ")");
    _y_history   += 20;
    _total_height+= 20;

    // Stats
    draw_set_color(cor_texto);

    var _stats = _battle.stats;
    draw_text(_history_x, _y_history, "Total de Ações: " + string(ds_list_size(_battle.actions))); 
    _y_history   += 20; 
    _total_height+= 20;

    draw_text(_history_x, _y_history, "Total Dano Causado: " + string(_stats.total_damage_dealt));
    _y_history   += 20;
    draw_text(_history_x, _y_history, "Média Dano Causado: " + string_format(_stats.mean_damage_dealt, 0, 2));
    _y_history   += 20;
    draw_text(_history_x, _y_history, "Desvio Padrão Dano Causado: " + string_format(_stats.std_dev_damage_dealt, 0, 2));
    _y_history   += 20;
    draw_text(_history_x, _y_history, "Total Dano Recebido: " + string(_stats.total_damage_received));
    _y_history   += 20;
    draw_text(_history_x, _y_history, "Média Dano Recebido: " + string_format(_stats.mean_damage_received, 0, 2));
    _y_history   += 20;
    draw_text(_history_x, _y_history, "Desvio Padrão Dano Recebido: " + string_format(_stats.std_dev_damage_received, 0, 2));
    _y_history   += 20;
    draw_text(_history_x, _y_history, "Número de Ataques: " + string(_stats.num_attacks));
    _y_history   += 20;
    draw_text(_history_x, _y_history, "Número de Defesas: " + string(_stats.num_defenses));
    _y_history   += 20;
    draw_text(_history_x, _y_history, "Número de Esquivas: " + string(_stats.num_dodges));
    _y_history   += 20;
    draw_text(_history_x, _y_history, "Número de Golpes Críticos: " + string(_stats.num_critical_hits));
    _y_history   += 30; 
    _total_height+= 30;

    // Now the ds_grid table of actions
    _y_history   += 10; 
    _total_height+= 10;

    var grid_actions = ds_grid_create(5, ds_list_size(_battle.actions)+1);

    // Fill header
    ds_grid_set(grid_actions, 0, 0, "Ação");
    ds_grid_set(grid_actions, 1, 0, "Dano Causado");
    ds_grid_set(grid_actions, 2, 0, "Dano Recebido");
    ds_grid_set(grid_actions, 3, 0, "Resultado");
    ds_grid_set(grid_actions, 4, 0, "Crítico");

    // Fill lines
    for (var r = 0; r < ds_list_size(_battle.actions); r++) {
        var _action = ds_list_find_value(_battle.actions, r);
        
        ds_grid_set(grid_actions, 0, r+1, _action.action_type);
        ds_grid_set(grid_actions, 1, r+1, string(_action.damage_dealt));
        ds_grid_set(grid_actions, 2, r+1, string(_action.damage_received));
        ds_grid_set(grid_actions, 3, r+1, _action.result);
        ds_grid_set(grid_actions, 4, r+1, (_action.critical_hit ? "Sim" : "Não"));
    }

    // Column widths
    var col_widths = [80, 116, 116, 170, 44]; 

    var x_table = _history_x; 
    var y_table = _y_history;

    draw_set_color(cor_texto);
    draw_set_halign(fa_left);

    for (var row = 0; row < ds_grid_height(grid_actions); row++) {
        var x_draw = x_table;
        var y_draw = y_table + row * 20;
        for (var col = 0; col < ds_grid_width(grid_actions); col++) {
            var cell_val = ds_grid_get(grid_actions, col, row);
            draw_text(x_draw, y_draw, cell_val);
            x_draw += col_widths[col];
        }
    }

    _y_history += (ds_grid_height(grid_actions) * 20) + 30;
    _total_height += (ds_grid_height(grid_actions) * 20) + 30;

    ds_grid_destroy(grid_actions);
}

// Turn off scissor
draw_self();

// SCROLL BAR LOGIC
// We check if _total_height > draw_area_height
// If yes, we draw a bar on the right side
max_scroll = max(0, _total_height - draw_area_height + 128);
scroll_y = clamp(scroll_y, 0, max_scroll);

if (max_scroll > 0) {
    // We have content beyond the box => show a scroll bar
    var bar_track_x = draw_area_width + 72; // track on far right
    var bar_track_y = draw_area_y;
    var bar_track_w = 1;
    var bar_track_h = draw_area_height;

    // Draw track
    draw_set_color(#DF9B67);
    draw_rectangle(bar_track_x, bar_track_y, bar_track_x + bar_track_w, bar_track_y + bar_track_h, false);

    // ratio of visible portion
    var ratioContent   = (draw_area_height / _total_height) / 2; 
    var bar_height     = bar_track_h * ratioContent;
    // ratio of how much user scrolled
    var ratioScrolled  = scroll_y / max_scroll;
    // top offset for the bar
    var bar_y_offset   = ratioScrolled * (bar_track_h - bar_height);

    // Draw bar
    var bar_y1 = bar_track_y + bar_y_offset;
    var bar_y2 = bar_y1 + bar_height;

    draw_set_color(#A25B38);
    draw_rectangle(bar_track_x, bar_y1, bar_track_x + bar_track_w, bar_y2, false);
}