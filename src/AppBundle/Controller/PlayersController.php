<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace AppBundle\Controller;

use AppBundle\Entity\Joueur;
use AppBundle\Entity\Personnage;
use AppBundle\Form\PersonnageType;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Method;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;

/**
 * Description of PlayersController
 *
 * @author loic
 */
class PlayersController extends Controller {

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
    public function addPlayers(Request $r) {
        $entityManager = $this->getDoctrine()->getManager();
        //boucle sur valeurs de 1 à 4
        for ($i = 1; $i <= 4; $i++) {
            //stockage de la valeur dans la variabe email
            $email = $r->get('j' . strval($i));
            if ($email != null) {
                $joueurs = $this->getDoctrine()->getRepository(Joueur::class)->findByEmail($email);
                if ($joueurs != null) {
                    $joueur = $joueurs[0];
//                    return new Response($joueurs[0]->getEmail());
                } else {
                    //si nouveau joueur
                    $joueur = new Joueur();
                    $joueur->setEmail($email);
                    $entityManager->persist($joueur);
                }
                //mise en session du joueur
                $r->getSession()->set('j' . strval($i), $joueur); // 
            }else{
                $r->getSession()->remove('j' . strval($i)); // 
            }
        }
        $entityManager->flush();
        $r->getSession()->set('actuel', 1);
        return $this->redirectToRoute('createPerso');
    }

    /**
     * @Route("/perso/create",name="savePersonnage")
     * @param Request $r
     */
    public function savePersonnage(Request $r){
        $em = $this->getDoctrine()->getManager();
        $joueur = $r->getSession()->get("j".strval($r->getSession()->get('actuel')));
        $personnage = new Personnage();
        $form = $this->createForm(PersonnageType::class, $personnage);
        $form->handleRequest($r);
        $em->persist($personnage->majStats());
        $em->persist($personnage);
        $joueur->setPersonnage($personnage);
        $em->merge($joueur);
        $em->flush();
        
        return $this->redirectToRoute("switch");
    }
    
    /**
     * Doit etre appelée par la validation de la création du personnage precendent !
     * @param Request $r
     * @return type
     * @Route("/perso/switch",name="switch")
     */
    public function switchPlayer(Request $r) {
        $next = $r->getSession()->get('actuel') + 1;
        if ($r->getSession()->has('j' . strval($next))) {
            $r->getSession()->set('actuel', $next);
            return $this->redirectToRoute('createPerso');
        }else{
            return $this->redirectToRoute('game');
        }
    }

}
