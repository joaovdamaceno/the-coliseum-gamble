// Atualizar animação
atualizar_animacao_gladiador(player);
atualizar_animacao_gladiador(enemy);

// Checar se estamos no estado final_delay
if (battle_state == "final_delay") {
    if (delay_resultado > 0) {
        delay_resultado--;
        if (delay_resultado <= 0) {
            finalizar_batalha();
        }
    }
    exit; // Não processamos mais nada
}

// Caso contrário, processamos a lógica normal
switch (battle_state) {

    case "battle_end":
        // Em vez de usá-lo, podemos pular direto pro final_delay
        // mas se quiser, deixamos vazio
        break;

    case "player_turn":
        controlar_acao_jogador();
        break;

    case "player_animando":
        if (!player_dano_executado && player.estado_animacao == "atacando") {
            var dmg = calcular_dano(player, enemy);
            enemy.hp -= dmg;
            if (enemy.hp < 0) enemy.hp = 0;
            registrar_log(player.name + " causou " + string(dmg) + " de dano a " + enemy.name + ".");
			if (enemy.hp <= 0) {
			    registrar_log(enemy.name + " foi derrotado!");
				
				// Antes de mudar de sala, chamamos registrar_lote_batalhas_do_dia
			    var log_copia = ds_list_create();
			    ds_list_copy(log_copia, battle_log);

				registrar_batalhas_do_dia(true);

			    // Excluir ou limpar battle_log
			    ds_list_clear(battle_log);
				
			    global.resultado_batalha = {
			        jogadorVenceu: true,
			        nomePlayer: player.name,
			        nomeEnemy: enemy.name,
			        spritesPlayer: {
			            head_sprite:    player.head_sprite,
			            body_sprite:    player.body_sprite,
			            left_arm_sprite:player.left_arm_sprite,
			            right_arm_sprite:player.right_arm_sprite,
			            left_leg_sprite:player.left_leg_sprite,
			            right_leg_sprite:player.right_leg_sprite,
			            weapon_sprite:  player.weapon_sprite
			        },
			        spritesEnemy: {
			            head_sprite:    enemy.head_sprite,
			            body_sprite:    enemy.body_sprite,
			            left_arm_sprite:enemy.left_arm_sprite,
			            right_arm_sprite:enemy.right_arm_sprite,
			            left_leg_sprite:enemy.left_leg_sprite,
			            right_leg_sprite:enemy.right_leg_sprite,
			            weapon_sprite:  enemy.weapon_sprite
			        }
			    };
			    // Agora definimos um delay_resultado e trocamos o estado, ou chamamos finalizar_batalha()
			    battle_state = "final_delay";
			    delay_resultado = 120; 
			    exit;
			}
            player_dano_executado = true;
        }
        // Espera animação
        if (player.animacao_timer <= 0 && battle_state != "final_delay") {
            player.estado_animacao = "idle";
            player_dano_executado  = false;
            battle_state = "enemy_turn";
        }
        break;

    case "enemy_turn":
        controlar_acao_inimigo();
        break;

    case "enemy_animando":
        if (!enemy_dano_executado && enemy.estado_animacao == "atacando") {
            var dmgE = calcular_dano(enemy, player);
            player.hp -= dmgE;
            if (player.hp < 0) player.hp = 0;
            registrar_log(enemy.name + " causou " + string(dmgE) + " de dano a " + player.name + ".");
            if (player.hp <= 0) {
                registrar_log(player.name + " foi derrotado!");
				var log_copia = ds_list_create();
			    ds_list_copy(log_copia, battle_log);

			    registrar_batalhas_do_dia(false);


			    ds_list_clear(battle_log);
                global.resultado_batalha = {
                    vencedor: enemy.name,
                    perdedor: player.name,
                    jogador_venceu: false,
			        spritesPlayer: {
			            head_sprite:    player.head_sprite,
			            body_sprite:    player.body_sprite,
			            left_arm_sprite:player.left_arm_sprite,
			            right_arm_sprite:player.right_arm_sprite,
			            left_leg_sprite:player.left_leg_sprite,
			            right_leg_sprite:player.right_leg_sprite,
			            weapon_sprite:  player.weapon_sprite
			        },
			        spritesEnemy: {
			            head_sprite:    enemy.head_sprite,
			            body_sprite:    enemy.body_sprite,
			            left_arm_sprite:enemy.left_arm_sprite,
			            right_arm_sprite:enemy.right_arm_sprite,
			            left_leg_sprite:enemy.left_leg_sprite,
			            right_leg_sprite:enemy.right_leg_sprite,
			            weapon_sprite:  enemy.weapon_sprite
			        }
			    };
			    // Agora definimos um delay_resultado e trocamos o estado, ou chamamos finalizar_batalha()
			    battle_state = "final_delay";
			    delay_resultado = 120; 
			    exit;
			}
            enemy_dano_executado = true;
        }
        if (enemy.animacao_timer <= 0 && battle_state != "final_delay") {
            enemy.estado_animacao = "idle";
            enemy_dano_executado  = false;
            battle_state = "player_turn";
        }
        break;
}
