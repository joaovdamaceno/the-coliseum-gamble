/// desenhar_gladiador(_gladiador, _x, _y, [ _scale, _shadowOfsX, _shadowOfsY, _shadowA ])
///
/// Draws a gladiator with optional animation states, shadows, and body parts.
///
///  - _scale      = default 6
///  - _shadowOfsX = default 5
///  - _shadowOfsY = default 5
///  - _shadowA    = default 0.2
///
/// Example usage:
///   desenhar_gladiador(player, 200, 300);
///   desenhar_gladiador(player, 200, 300, 8, 3, 6, 0.1);

function desenhar_gladiador(_gladiador, _x, _y)
{
    //--------------------------------------
    // 1) READ OPTIONAL ARGUMENTS
    //--------------------------------------
    var _scale      = 6;
    var _shadowOfsX = 5;
    var _shadowOfsY = 5;
    var _shadowA    = 0.2;

    if (argument_count >= 4) _scale      = argument[3];
    if (argument_count >= 5) _shadowOfsX = argument[4];
    if (argument_count >= 6) _shadowOfsY = argument[5];
    if (argument_count >= 7) _shadowA    = argument[6];

    //--------------------------------------
    // 2) CHECK ANIMATION FIELDS
    //--------------------------------------
    var anim_timer = 0;
    var anim_state = "idle";

    if (variable_struct_exists(_gladiador, "animacao_timer")) {
        anim_timer = _gladiador.animacao_timer;
    }
    if (variable_struct_exists(_gladiador, "estado_animacao")) {
        anim_state = _gladiador.estado_animacao;
    }

    //--------------------------------------
    // 3) SET UP ANIMATION
    //--------------------------------------
    var tempo_total = 40.0;
    var resto       = clamp(anim_timer, 0, tempo_total);
    var progresso   = 1 - (resto / tempo_total);

    var rot  = 0;           // Body rotation
    var sclx = _scale;      // Horizontal scale
    var scly = _scale;      // Vertical scale

    // We'll do per-limb offsets for the walk cycle
    var left_leg_offset   = 0;   // how much the left leg lifts
    var right_leg_offset  = 0;   // how much the right leg lifts
    var body_offset       = 0;   // how much the entire upper body lifts
    var arm_offset_left   = 0;   // left arm up-lift
    var arm_offset_right  = 0;   // right arm up-lift

    switch (anim_state)
    {
        //--------------------------------------
        // Idle
        //--------------------------------------
        case "idle": {
            var idle_angle  = sin(current_time / 1000) * 5;
            var idle_squash = 1 + 0.025 * sin(current_time / 500);
            rot  = idle_angle;
            sclx = _scale;
            scly = _scale * idle_squash;
            break;
        }

        //--------------------------------------
        // Walk
        //--------------------------------------
        case "walk": {
            // We want legs only to go up. So if the sine wave is negative, clamp to 0.
            // Then the entire body goes up by the max of the two legs.

            var walk_speed = 180.0; // tweak speed of cycle
            var cycle      = current_time / walk_speed;

            // Mild body rotation & squash
            var body_angle   = sin(cycle) * 4; 
            var body_squash  = 1 + 0.05 * sin(cycle / 2);

            rot  = body_angle;
            sclx = _scale;
            scly = _scale * body_squash;

            // Leg wave
            var wave_left  = sin(cycle) * 4;      // amplitude 3
            var wave_right = sin(cycle + pi) * 4; // out of phase

            // clamp negative to 0
            if (wave_left  < 0) wave_left  = 0;
            if (wave_right < 0) wave_right = 0;

            left_leg_offset  = wave_left;
            right_leg_offset = wave_right;

            // entire body lifts up by whichever leg is higher
            body_offset = max(left_leg_offset, right_leg_offset);

            // Arms: if you want arms up-lift, also clamp negative to 0
            // offset them out of phase with the legs if desired
            var wave_arm_left  = sin(cycle + pi/2) * 4;
            var wave_arm_right = sin(cycle + pi/2 + pi) * 4;
            if (wave_arm_left  < 0) wave_arm_left  = 0;
            if (wave_arm_right < 0) wave_arm_right = 0;

            arm_offset_left  = wave_arm_left;
            arm_offset_right = wave_arm_right;
            break;
        }

        //--------------------------------------
        // Attacking
        //--------------------------------------
        case "atacando": {
            var meio = 0.5;
            if (progresso < meio) {
                var subp   = progresso / meio;
                var eOutBk = easeOutBack(subp);
                rot  = lerp(0, -30, eOutBk);
                sclx = lerp(_scale,   _scale * 1.05, eOutBk);
                scly = lerp(_scale,   _scale * 0.95, eOutBk);
            } else {
                var subp = (progresso - meio) / (1 - meio);
                var eOut = easeOutQuad(subp);
                rot  = lerp(-30, 0, eOut);
                sclx = lerp(_scale * 1.05, _scale, eOut);
                scly = lerp(_scale * 0.95, _scale, eOut);
            }
            break;
        }

        //--------------------------------------
        // Defend or Dodge
        //--------------------------------------
        case "defendendo":
        case "esquivando": {
            var meio2 = 0.5;
            if (progresso < meio2) {
                var subp = progresso / meio2;
                var eOut2= easeOutQuad(subp);
                rot  = lerp(0, 20, eOut2);
                sclx = lerp(_scale,     _scale*0.95, eOut2);
                scly = lerp(_scale,     _scale*1.05, eOut2);
            } else {
                var subp  = (progresso - meio2)/(1 - meio2);
                var eBack = easeOutBack(subp);
                rot  = lerp(20, 0, eBack);
                sclx = lerp(_scale*0.95, _scale, eBack);
                scly = lerp(_scale*1.05, _scale, eBack);
            }
            break;
        }

        //--------------------------------------
        // Celebrating
        //--------------------------------------
        case "comemorando": {
            var wave = sin(current_time / 300) * 12; 
            rot  = wave;
            sclx = _scale * 1.3;
            scly = _scale * 1.3;
            break;
        }
    }

    //--------------------------------------
    // 4) IDLE Y OFFSET
    //--------------------------------------
    var idle_y_offset = sin(current_time / 500) * 2;

    //--------------------------------------
    // 5) SHADOW SETTINGS
    //--------------------------------------
    var shadow_color = c_black;

    //--------------------------------------
    // (A) DRAW SHADOWS FIRST
    //--------------------------------------
    draw_set_color(shadow_color);

    // Leg shadows (going up only)
    if (_gladiador.left_leg_sprite != -1) {
        draw_sprite_ext(
            _gladiador.left_leg_sprite,
            0,
            _x + (1 * _scale) + _shadowOfsX,
            // Floor baseline is (y + 25*scale). We subtract left_leg_offset
            // But we want only upward movement => We'll do minus offset
            // Actually, to keep consistent with the main sprite, let's do +0?
            // We'll do the same offset as main. But we said "not below floor"
            ( _y + (25 * _scale) + _shadowOfsY ) - left_leg_offset,
            _scale,
            _scale,
            0,
            shadow_color,
            _shadowA
        );
    }
    if (_gladiador.right_leg_sprite != -1) {
        draw_sprite_ext(
            _gladiador.right_leg_sprite,
            0,
            _x + (9 * _scale) + _shadowOfsX,
            ( _y + (25 * _scale) + _shadowOfsY ) - right_leg_offset,
            _scale,
            _scale,
            0,
            shadow_color,
            _shadowA
        );
    }

    // Body shadow (shift up by body_offset)
    if (_gladiador.body_sprite != -1) {
        draw_sprite_ext(
            _gladiador.body_sprite,
            0,
            _x + (2 * _scale) + _shadowOfsX,
            ( _y + (14 * _scale) + _shadowOfsY ) - body_offset,
            _scale,
            _scale,
            0,
            shadow_color,
            _shadowA
        );
    }

    // Arms shadow (shift by body_offset + arm offsets)
    if (_gladiador.left_arm_sprite != -1) {
        draw_sprite_ext(
            _gladiador.left_arm_sprite,
            0,
            _x - (2 * _scale) + _shadowOfsX,
            ( _y + (19 * _scale) + _shadowOfsY ) - body_offset - arm_offset_left,
            _scale,
            _scale,
            0,
            shadow_color,
            _shadowA
        );
    }
    if (_gladiador.right_arm_sprite != -1) {
        draw_sprite_ext(
            _gladiador.right_arm_sprite,
            0,
            _x + (13 * _scale) + _shadowOfsX,
            ( _y + (19 * _scale) + _shadowOfsY ) - body_offset - arm_offset_right,
            _scale,
            _scale,
            0,
            shadow_color,
            _shadowA
        );
    }

    // Head shadow (shift by body_offset)
    if (_gladiador.head_sprite != -1) {
        draw_sprite_ext(
            _gladiador.head_sprite,
            0,
            _x - (1 * _scale) + _shadowOfsX,
            ( _y + idle_y_offset + _shadowOfsY ) - body_offset,
            _scale,
            _scale,
            0,
            shadow_color,
            _shadowA
        );
    }

    // Weapon shadow (if not hidden)
    if (!global.hide_weapon && _gladiador.weapon_sprite != -1) {
        draw_sprite_ext(
            _gladiador.weapon_sprite,
            0,
            _x + (13 * _scale) + _shadowOfsX,
            ( _y + (24 * _scale) + _shadowOfsY ) - body_offset,
            _scale,
            _scale,
            0,
            shadow_color,
            _shadowA
        );
    }

    //--------------------------------------
    // (B) DRAW MAIN SPRITES
    //--------------------------------------
    draw_set_color(c_white);

    // L E G S
    if (_gladiador.left_leg_sprite != -1) {
        draw_sprite_ext(
            _gladiador.left_leg_sprite,
            0,
            _x + (1 * _scale),
            ( _y + (25 * _scale) ) - left_leg_offset,
            _scale,
            _scale,
            0,
            c_white,
            1
        );
    }
    if (_gladiador.right_leg_sprite != -1) {
        draw_sprite_ext(
            _gladiador.right_leg_sprite,
            0,
            _x + (9 * _scale),
            ( _y + (25 * _scale) ) - right_leg_offset,
            _scale,
            _scale,
            0,
            c_white,
            1
        );
    }

    // BODY ( shift by body_offset )
    if (_gladiador.body_sprite != -1) {
        draw_sprite_ext(
            _gladiador.body_sprite,
            0,
            _x + (2 * _scale),
            ( _y + (14 * _scale) ) - body_offset,
            sclx,
            scly,
            0,
            c_white,
            1
        );
    }

    // ARMS ( shift by body_offset + arm offsets ), also apply rot if desired
    if (_gladiador.left_arm_sprite != -1) {
        draw_sprite_ext(
            _gladiador.left_arm_sprite,
            0,
            _x - (2 * _scale),
            ( _y + (19 * _scale) ) - body_offset - arm_offset_left,
            sclx,
            scly,
            -rot,
            c_white,
            1
        );
    }
    if (_gladiador.right_arm_sprite != -1) {
        draw_sprite_ext(
            _gladiador.right_arm_sprite,
            0,
            _x + (13 * _scale),
            ( _y + (19 * _scale) ) - body_offset - arm_offset_right,
            sclx,
            scly,
            rot,
            c_white,
            1
        );
    }

    // HEAD ( shift by body_offset )
    if (_gladiador.head_sprite != -1) {
        draw_sprite_ext(
            _gladiador.head_sprite,
            0,
            _x - (1 * _scale),
            ( _y + idle_y_offset ) - body_offset,
            sclx,
            scly,
            0,
            c_white,
            1
        );
    }

    // WEAPON
    if (!global.hide_weapon && _gladiador.weapon_sprite != -1) {
        draw_sprite_ext(
            _gladiador.weapon_sprite,
            0,
            _x + (13 * _scale),
            ( _y + (24 * _scale) ) - body_offset,
            sclx,
            scly,
            0,
            c_white,
            1
        );
    }
}

// ----- Easing Helpers -----
function easeInQuad(t) {
    return t * t;
}
function easeOutQuad(t) {
    return 1 - power(1 - t, 2);
}
function easeOutBack(t) {
    var s = 1.70158;
    t = t - 1;
    return 1 + t*t*((s+1)*t + s);
}
function lerp(a, b, t) {
    return a + (b - a) * t;
}
