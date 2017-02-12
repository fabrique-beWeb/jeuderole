/**
 * Pour l'affectation des skills
 * On genere un pool de points a répartir dans les champs input de type number
 * On bloque les valeurs des champs avec les propriétés min et max des balises input :
 *      - les valeurs minimales sont la somme des stats de la race et des stats de la classe
 *      - Les valeurs max sont la valeur de chacun des champs + le pool
 * A chaque fois qu'on rajoute des points on recalcule la valeur max pour tous les champs 
 * 
 * @type Number|oldDelta|@exp;base|base|delta|baseUp|@exp;baseUp
 */

var pool;
var tries = 10;
var oldValue;

/**
 * Generateur de Points
 * @param {type} e
 * @returns {undefined}
 */
var generator = function (e) {
    e.preventDefault();
    if (tries >= 0) {
        tries--;
        pool = Math.random() * 40 + 10;
        pool = Math.round(pool);
        $("#pool").text(pool).trigger('poolChanged');
    }
};
//ecouteur sur le bouton generateur de points 
$("#generator").click(generator);

// sert au calcul du nombre de points attribués
var base; // somme des valeurs minimales
var baseUp; //somme des valeurs des champs 
// sert a determiner l'ajout ou la suppression des points
// si oldDelta > delta alors on a enlevé des points
var oldDelta = 0; // ancienne valeur attribuée
var delta = 0; // nb de points au moment de l'evenement
/**
 * Declenchement lors d'un changement de valeur 
 * dans un de champs textes
 * @param {type} param
 */
$("input[type='number']").change(function (e) {
    // init des points totals
    base = 0;
    baseUp = 0;
    
    /**
     * Calcul du delta entre la valeur de base et la valeur actuelle
     * on boucle sur chaque champ pour recuperer les valeurs a calculer
     * 
     */
    $.each($("input[type='number']"), function (key, val) {
        base = base + parseInt($(val).attr('min'));
        baseUp = baseUp + parseInt($(val).val());
    });
    //points insérés
    delta = baseUp - base;
    //mise a jour du pool de points
    pool = pool - ( delta - oldDelta );
    //sauvergarde des points ( incrément ou decrement )
    oldDelta = delta;
    // mise a jour de la vue avec le nouveau pool +
    //declenchement du nouveau calcul des valeurs max
    $("#pool").text(pool).trigger('poolChanged');

});

/**
 * On affecte la valeur maximale de points par rapport 
 * au pool de points pour tous les champs input
 * @param {type} param1
 * @param {type} param2
 */
$('#pool').on('poolChanged', function () {
    $.each($("input[type='number']"),function(key,val){
        var min = parseInt($(val).val());
        $(val).attr('max', min + pool);
        
    });

});
