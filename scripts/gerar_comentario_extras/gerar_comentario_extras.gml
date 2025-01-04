function gerar_comentario_extras(_vencedor, _perdedor) {
    var frasesExtras = [
        "{win} dominou {lose} em poucos minutos!",
        "A multidão aplaudiu quando {win} superou {lose}!",
        "Com golpes certeiros, {win} derrotou {lose}!",
        "{lose} até resistiu, mas foi vencido por {win}!",
        "A arena vibrou com a vitória de {win} sobre {lose}!"
    ];
    var frase = choose_array(frasesExtras);
    frase = string_replace_all(frase, "{win}", _vencedor);
    frase = string_replace_all(frase, "{lose}", _perdedor);
    return frase;
}