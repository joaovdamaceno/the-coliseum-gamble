function simular_luta_aleatoria() {
    var nomes = [ "Brutus", "Cassius", "Decimus", "Flavius", "Gaius", 
                  "Julius", "Lucius", "Marcus", "Severus", "Aquila" ];
    var n1 = choose_array(nomes);
    var n2 = choose_array(nomes);
    while (n2 == n1) {
        n2 = choose_array(nomes);
    }
    var v = choose(n1, n2);
    var p = (v == n1) ? n2 : n1;
    var _coment = gerar_comentario_extras(v, p); 
    return {
        vencedor:  v,
        perdedor:  p,
        comentario:_coment
    };
}
