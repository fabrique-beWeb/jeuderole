<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace AppBundle\Controller;

use AppBundle\Entity\Joueur;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Method;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;

/**
 * Description of PlayersController
 *
 * @author loic
 */
class PlayersController extends Controller{
    
    /**
     * Methode qui va ajouter les joueurs en base de données
     * A la fin du traitement on est rediriger sur le controlleur de vue
     * afin de retourner la vue de creation de personnages
     * 
     * Si le joueur existe en base de donnée, on le met en session
     * sinon on l'enregistre, et on le met en session.
     * @Route("/players/add",name="addPlayers")
     * @Method({"POST"})
     * @param \Request $r
     */
    public function addPlayers(Request $r){
        $entityManager = $this->getDoctrine()->getManager();
        //boucle sur valeurs de 1 à 4
        for ($i=1 ; $i<=4 ; $i++){
            //stockage de la valeur dans la variabe email
            $email = $r->get('j'. strval($i));
            if( $email != null){
                
                //si nouveau joueur
                $joueur = new Joueur();
                $joueur->setEmail($email);
                $entityManager->persist($joueur);
                //mise en session du joueur
                $r->getSession()->set('j'. strval($i), $joueur);                
            }
        }
        $entityManager->flush();
        
        return $this->redirectToRoute('createPerso');
//        // m'a permis de verifier les valeurs du formulaire
//        return new Response($r->get('j1'));
    }
}
