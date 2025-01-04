function finalizar_batalha() {
    battle_over = true;

    // Agora decidimos a transição de sala
    if (player.hp <= 0) {
        // Player perdeu -> Volta para rm_praca
        // mas queremos manter o delay e a animação final?
        room_goto(rm_resultado);
        global.resultado_batalha = {
            jogadorVenceu: false,
            nomePlayer: player.name,
            nomeEnemy: enemy.name,
            // Se quiser exibir sprites no resultado...
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
    } else {
        // Player venceu
        room_goto(rm_resultado);
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
    }
}
