
//quand le document est pret ( a la fin du chargement de la page)
$(document).ready(function(){
    centrerButton();  
    centrerFormulaire();
    $("body").css("visibility","visible");
});
//quand on redimmensionne la fenetre
$(window).resize(function (){
    centrerButton();
    centrerFormulaire();
});

//quand on clique sur le bouton
$("button").click(function(){
    $(this).fadeOut(600,function(){
        $("#selection").fadeIn(600);
    });
    
});


/**
 * Fonction qui centre le bouton
 * @returns {undefined}
 */
function centrerButton(){
     //on recupère les dimmensions de la fenetre
    var w = $(window).width();
    var h = $(window).height();
    //on recupère les dimmensions du bouton 
    var buttonw = $("button").width();
    var buttonh = $("button").height();
    //on calcule la position du bouton afin qu'il soit au centre
    var top = (h - buttonh)/2;
    var left = (w - buttonw)/2;
    //on affecte les nouvelles positions calculées
    $("button").css({
        "left": left+"px", 
        "top": top+"px"
    });       
}
/**
 * Fonction qui centre le bouton
 * @returns {undefined}
 */
function centrerFormulaire(){
     //on recupère les dimmensions de la fenetre
    var w = $(window).width();
    var h = $(window).height();
    //on recupère les dimmensions du bouton 
    var buttonw = $("#selection").width();
    var buttonh = $("#selection").height();
    //on calcule la position du bouton afin qu'il soit au centre
    var top = (h - buttonh - 100)/2;
    var left = (w - buttonw)/2;
    //on affecte les nouvelles positions calculées
    $("#selection").css({
        "left": left+"px", 
        "top": top+"px"
    });       
}