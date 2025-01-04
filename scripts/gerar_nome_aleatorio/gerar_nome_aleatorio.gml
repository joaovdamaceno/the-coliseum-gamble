function gerar_nome_aleatorio(){
    var _names_first = ["Aulus", "Brutus", "Cassius", "Decimus", "Flavius", "Gaius", "Horatius", "Julius", "Lucius", "Marcus"];
    var _names_last = ["Maximus", "Aquila", "Corvus", "Drusus", "Festus", "Gallus", "Lupus", "Octavius", "Quintus", "Severus"];
    
    var _first_name = choose_array(_names_first);
    var _last_name = choose_array(_names_last);
    
    return _first_name + " " + _last_name;
}

function choose_array(_arr) {
    return _arr[irandom(array_length(_arr) - 1)];
}