function gerar_comentario_principal(_vencedor, _perdedor) {
    var frases = [
        "{win} finaliza {lose} na batalha principal!",
        "Foi um duelo incrível: {win} derrotou {lose} diante da multidão!",
        "O poder de {win} foi demais para {lose} suportar!",
        "{lose} não resistiu ao ímpeto de {win}!",
        "A arena vibrou quando {win} saiu vitorioso sobre {lose}!"
    ];
    var frase = choose_array(frases);
    frase = string_replace_all(frase, "{win}", _vencedor);
    frase = string_replace_all(frase, "{lose}", _perdedor);
    return frase;
}
