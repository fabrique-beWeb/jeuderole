
//quand le document est pret ( a la fin du chargement de la page)
$(document).ready(function () {
    
    center($("#selection"));
    center($("form"));
    center($("#launch"));
    $("body").css("visibility", "visible");
    
    
});
//quand on redimmensionne la fenetre
$(window).resize(function () {
    center($("#selection"));
    center($("form"));
    center($("#launch"));
});

//quand on clique sur le bouton
$("#launch").click(function () {
    $(this).fadeOut(600, function () {
        $("#selection").fadeIn(600);
    });

});
function center(object) {
    //on recupère les dimmensions de la fenetre
    var w = $(window).width();
    var h = $(window).height();
    //on recupère les dimmensions du bouton 
    var buttonw = $(object).width();
    var buttonh = $(object).height();
    //on calcule la position du bouton afin qu'il soit au centre
    var top = (h - buttonh - 100) / 2;
    var left = (w - buttonw) / 2;
    //on affecte les nouvelles positions calculées
    $(object).css({
        "left": left + "px",
        "top": top + "px"
    });
}