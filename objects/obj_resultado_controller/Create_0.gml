if (!variable_global_exists("resultado_batalha")) {
    global.resultado_batalha = {
        jogadorVenceu: false,
        nomePlayer: "???",
        nomeEnemy: "???",
        spritesPlayer: {},
        spritesEnemy: {}
    };
}

// Podemos criar variáveis locais para facilitar
vencedor_eh_player = global.resultado_batalha.jogadorVenceu;

player_nome = global.resultado_batalha.nomePlayer;
enemy_nome  = global.resultado_batalha.nomeEnemy;

// Guardamos os sprites do player e do enemy
player_sprites = global.resultado_batalha.spritesPlayer;
enemy_sprites  = global.resultado_batalha.spritesEnemy;
