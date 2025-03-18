// Lista de gladiadores disponíveis
gladiadores_disponiveis = ds_list_create();

// Gerar gladiadores aleatórios
var _num_gladiadores = 5; // Quantos gladiadores estarão disponíveis
for (var _i = 0; _i < _num_gladiadores; _i++) {
    var _perfil = choose("Agressivo", "Defensivo", "Equilibrado");
    var _gladiator = criar_perfil_gladiador(_perfil, true);
    ds_list_add(gladiadores_disponiveis, _gladiator);
}

// Índice do gladiador selecionado
gladiador_selecionado = 0;

// Variáveis de paginação para batalhas
battle_page = 0;
battles_per_page = 1; // Número de batalhas por página

// Variáveis de scroll
scroll_y = 0;
scroll_speed = 18; // Ajuste a velocidade do scroll conforme necessário
max_scroll = 0;