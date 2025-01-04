function desenhar_gladiador_resultado(_sprites, _estadoFinal, _x, _y) {
    var base_scale = 1.5; // Escala base para desenhar
    var rot  = 0;         // Rotação padrão
    var sclx = base_scale;
    var scly = base_scale;

    switch (_estadoFinal) {

        case "comemorando":
            // Exemplo: levemente maior, pequena rotação oscilante
            rot = sin(current_time / 300) * 10;
            sclx = base_scale * 1.2;
            scly = base_scale * 1.2;
            
            // Desenhar pernas, corpo, braços, etc. normal (abaixo)
            break;

        case "caido":
            // Desistimos de girar todo o corpo.
            // NÃO desenhamos pernas, corpo, braços, arma - somente a cabeça, deitada no chão.
            // Cabeça: rotacionada 90 graus, por ex., para simular tombada
            rot = 90;       
            sclx = base_scale;
            scly = base_scale;
            
            // Vamos, então, **pular** o desenho das demais partes e desenhar só a cabeça
            break;
    }

    // --- Caso "comemorando": desenhar tudo ---
    if (_estadoFinal == "comemorando") {
        // Pernas
        if (_sprites.left_leg_sprite != -1) {
            draw_sprite_ext(
                _sprites.left_leg_sprite, 0,
                _x, _y+50,
                sclx, scly,
                rot, c_white, 1
            );
        }
        if (_sprites.right_leg_sprite != -1) {
            draw_sprite_ext(
                _sprites.right_leg_sprite, 0,
                _x+20, _y+50,
                sclx, scly,
                -rot, c_white, 1
            );
        }

        // Corpo
        if (_sprites.body_sprite != -1) {
            draw_sprite_ext(
                _sprites.body_sprite, 0,
                _x+10, _y+20,
                sclx, scly,
                0, c_white, 1
            );
        }

        // Braços
        if (_sprites.left_arm_sprite != -1) {
            draw_sprite_ext(
                _sprites.left_arm_sprite, 0,
                _x, _y+20,
                sclx, scly,
                -rot, c_white, 1
            );
        }
        if (_sprites.right_arm_sprite != -1) {
            draw_sprite_ext(
                _sprites.right_arm_sprite, 0,
                _x+20, _y+20,
                sclx, scly,
                rot, c_white, 1
            );
        }

        // Cabeça
        if (_sprites.head_sprite != -1) {
            draw_sprite_ext(
                _sprites.head_sprite, 0,
                _x+10, _y,
                sclx, scly,
                0, c_white, 1
            );
        }

        // Arma
        if (_sprites.weapon_sprite != -1) {
            draw_sprite_ext(
                _sprites.weapon_sprite, 0,
                _x+25, _y+20,
                sclx, scly,
                rot, c_white, 1
            );
        }
    }

    // --- Caso "caido": desenhar SOMENTE a cabeça tombada ---
    if (_estadoFinal == "caido") {
        if (_sprites.head_sprite != -1) {
            // Ajuste a posição para parecer “no chão”
            // Por ex.: y+50 para descer mais. 
            // Rot = 90° para ficar de lado
            draw_sprite_ext(
                _sprites.head_sprite, 
                0,
                _x+10, _y+128, // O quão “embaixo” ela vai
                sclx, scly,
                rot,
                c_white,
                1
            );
        }
    }
}
