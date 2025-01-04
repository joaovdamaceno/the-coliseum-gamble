battle_state = "player_turn";
player = global.player_gladiator;
var perfil_inimigo = choose("Agressivo", "Defensivo", "Equilibrado");
enemy = criar_perfil_gladiador(perfil_inimigo, true);

player_action_selected = "";
battle_log = ds_list_create();
battle_over = false;

// Estados de animação
player.estado_animacao = "idle";
player.animacao_timer  = 0;
enemy.estado_animacao  = "idle";
enemy.animacao_timer   = 0;

player_dano_executado = false;
enemy_dano_executado  = false;

// Contador de delay antes de ir para rm_resultado
delay_resultado = 0; // Em frames (ex. 60 = 1 segundo se room_speed=60)

function registrar_log(_msg) {
    ds_list_add(battle_log, _msg);
}
