function desenhar_gladiador(_g, _x, _y) {
    var base_scale = 1.5;
    var tempo_total = 40.0;
    var resto = clamp(_g.animacao_timer, 0, tempo_total);
    // progresso 0..1
    var progresso = 1 - (resto / tempo_total);

    var rot = 0;
    var sclx= base_scale;
    var scly= base_scale;

    switch (_g.estado_animacao) {
        case "idle": {
            // idle
            var idle_angle = sin(current_time/1000)*5;
            var idle_squash= 1 + 0.05*sin(current_time/500);
            rot = idle_angle;
            sclx= base_scale;
            scly= base_scale*idle_squash;
            break;
        }
        case "atacando": {
            // Dividir em 2 fases
            var meio = 0.5;
            if (progresso < meio) {
                // Fase de ida => Use easeInQuad
                var subp = progresso / meio; // 0..1
                var eIn  = easeInQuad(subp); // comece rápido, termine devagar
                rot = lerp(0, -20, eIn);
                sclx= lerp(base_scale, base_scale*1.3, eIn);
                scly= lerp(base_scale, base_scale*0.9, eIn);
            } else {
                // Fase de volta => Use easeOutQuad
                var subp  = (progresso - meio)/(1 - meio);
                var eOut  = easeOutQuad(subp); 
                rot = lerp(-20, 0, eOut);
                sclx= lerp(base_scale*1.3, base_scale, eOut);
                scly= lerp(base_scale*0.9, base_scale, eOut);
            }
            break;
        }
        case "defendendo":
        case "esquivando": {
            // Dividir em 2 fases (in e out) caso queira
            var meio2 = 0.5;
            if (progresso < meio2) {
                var subp = progresso / meio2;
                var eIn2 = easeInQuad(subp);
                rot = lerp(0, 15, eIn2);
                sclx= lerp(base_scale, base_scale*0.8, eIn2);
                scly= lerp(base_scale, base_scale*1.1, eIn2);
            } else {
                var subp = (progresso - meio2)/(1 - meio2);
                var eOut2= easeOutQuad(subp);
                rot = lerp(15, 0, eOut2);
                sclx= lerp(base_scale*0.8, base_scale, eOut2);
                scly= lerp(base_scale*1.1, base_scale, eOut2);
            }
            break;
        }
    }

    // Desenho das partes
    if (_g.left_leg_sprite != -1) {
        draw_sprite_ext(_g.left_leg_sprite, 0, _x, _y+50, sclx, scly, rot, c_white, 1);
    }
    if (_g.right_leg_sprite != -1) {
        draw_sprite_ext(_g.right_leg_sprite, 0, _x+20, _y+50, sclx, scly, -rot, c_white, 1);
    }
    if (_g.body_sprite != -1) {
        draw_sprite_ext(_g.body_sprite, 0, _x+10, _y+20, sclx, scly, 0, c_white, 1);
    }
    if (_g.left_arm_sprite != -1) {
        draw_sprite_ext(_g.left_arm_sprite, 0, _x, _y+20, sclx, scly, -rot, c_white, 1);
    }
    if (_g.right_arm_sprite != -1) {
        draw_sprite_ext(_g.right_arm_sprite, 0, _x+20, _y+20, sclx, scly, rot, c_white, 1);
    }
    if (_g.head_sprite != -1) {
        draw_sprite_ext(_g.head_sprite, 0, _x+10, _y, sclx, scly, 0, c_white, 1);
    }
    if (_g.weapon_sprite != -1) {
        draw_sprite_ext(_g.weapon_sprite, 0, _x+25, _y+20, sclx, scly, rot, c_white, 1);
    }
}

function easeInQuad(t) {
    return t * t;
}

function easeOutQuad(t) {
    return 1 - power(1 - t, 2);
}

function lerp(a, b, t) {
    return a + (b - a)*t;
}