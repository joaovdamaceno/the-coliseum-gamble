function controlar_acao_inimigo() {
    var acao = choose("attack", "defense");
    switch (acao) {
        case "attack":
            enemy.estado_animacao = "atacando";
            enemy.animacao_timer  = 40;
            registrar_log(enemy.name + " atacou!");
            battle_state = "enemy_animando";
            break;
        case "defense":
            enemy.estado_animacao = "defendendo";
            enemy.animacao_timer  = 40;
            registrar_log(enemy.name + " está se defendendo.");
            battle_state = "enemy_animando";
            break;
    }
}
