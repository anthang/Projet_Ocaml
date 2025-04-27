open Ecs
open Component_defs
open System_defs
open Assets 


(*---------------------------LEVEL01-------------------------------*)

(* --------------------- *)
(*      W A L L S       *)
(* --------------------- *)
let walls () =


  
  List.map Wall.wall Cst.[

    (* Bords extérieurs *)
    (hwall1_x, hwall1_y, hwall_color, hwall_width, hwall_height);                  (* Mur horizontal du haut *)
    (hwall2_x, hwall2_y, hwall_color, 200, hwall_height);   
    (600, hwall2_y, hwall_color, 200, hwall_height);           
    (200, hwall2_y+hwall_height/2, hwall_color, 400, hwall_height/2); 
    (395,550, hwall_color, 10,50 ); 
              (* Mur horizontal du bas *)
    (vwall1_x, vwall1_y, vwall_color, wall_thickness, window_height - 2*wall_thickness); (* Mur vertical gauche *)
    (vwall2_x, vwall2_y, vwall_color, wall_thickness, window_height - 2*wall_thickness); (* Mur vertical droit *)


    (* 1) Deux plateformes symétriques en bas (à ~y=550 pour un écran de 600px de haut). *)
    (110, 530, hwall_color, 100, hwall_height);  (* Plateforme de gauche *)
    (590, 530, hwall_color, 100, hwall_height);  (* Plateforme de droite *)



    (110, 400, hwall_color, 100, hwall_height);  (* Plateforme de gauche *)
    (590, 400, hwall_color, 100, hwall_height);  (* Plateforme de droite *)


    
    (* 2) Un mur horizontal fixe au-dessus du swall (par exemple vers y=400). *)
    (190, 330, hwall_color, 420, hwall_height);

    (* 3) Un mur vertical au centre qui sépare la partie supérieure (on le place vers x=395, y=100). 
       Il fait 10px de large et 200px de haut (à adapter si besoin). *)
    (395, 20, vwall_color, wall_thickness,320);

    (20, 250, hwall_color, 190, hwall_height);  (* Plateforme de gauche *)
    (590, 250, hwall_color, 190, hwall_height);  (* Plateforme de droite *)



    (20, 200, hwall_color, 100, hwall_height);  (* Plateforme de gauche *)
    (680, 200, hwall_color, 100, hwall_height);  (* Plateforme de droite *)


    (250, 85, hwall_color, 300, hwall_height);

  ]

(* -------------------------- *)
(*  S I N K I N G  W A L L S  *)
(* -------------------------- *)

  let swalls () =
    let swall_list = List.map Sinking_wall.swall Cst.[
      (* 1) Swall horizontal entre les deux plateformes du bas. 
            Disons qu’il se trouve entre x=300, y=520, 
            a une largeur de 200px (assez pour relier ~x=200 à x=400), 
            hauteur = hwall_height (20). 
         - Les deux derniers paramètres (x2, y2) définissent la position-cible 
           s’il y a un mouvement (par ex. coulissement vers le haut). 
         - Adapte en fonction du comportement que tu veux (ici, je mets un petit mouvement). *)


      (230, 470, Texture.yellow, 100, hwall_height, 470, 470);




    ]
    in
    (* On enregistre chaque swall dans la table correspondante *)
    List.iteri (fun i sw -> Hashtbl.add Sinking_wall.swall_table i sw) swall_list;
    swall_list
    
(* --------------------- *)
(*       P I E G E S    *)
(* --------------------- *)
let pieges () =
  List.map Piege.piege Cst.[
    (* Exemple :
       On place un piège (spikes, lave, etc.) vers x=380, y=560,
       avec une largeur = 40 et une hauteur = 20 (selon vos besoins).
       À adapter selon le type attendu par Piege.piege et la taille souhaitée.
    *)
    (200, 585, Texture.blue, 195, 5,false,true);
    (405, 585, Texture.red, 195, 5,true,false);
  ]
(* --------------------- *)
(*    M O N S T E R S   *)
(* --------------------- *)
let monsters () =
  let monster_list =
    List.map Monster.monster Cst.[
      (* il y en a pas pour ce niveau*)
    ]
  in
  (* On pourrait remplir la monster_table si nécessaire *)
  List.iteri (fun i m -> Hashtbl.add Monster.monster_table () m) monster_list;
  monster_list

(* --------------------- *)
(*   D I A M O N T S     *)
(* --------------------- *)
let diamonts () =
  List.map Diamont.diamont Cst.[
    (* 1) Au-dessus des plateformes du bas (x=110, y=530) et (x=590, y=530). *)
    (160, 500, Assets.get DiamantFire,true);  (* Centre approx. : 110 + (100/2) = 160, 530 - 30 = 500 *)
    (640, 500, Assets.get DiamantFire,true);  (* Pareil pour x=590 + 50 = 640, y=500 *)

    (* 2) Au-dessus des plateformes à (110,400) et (590,400). *)
    (160, 370, Assets.get DiamantWater,false);
    (640, 370, Assets.get DiamantWater,false);

    (* 3) Au-dessus du grand mur horizontal (190,330) de largeur 420.
       Centre horizontal ~ 190 + (420 / 2) = 400, en l’élevant ~30px au-dessus. *)
    (400, 300, Assets.get DiamantFire,true);

    (* 4) Au-dessus des plateformes à (110, 250) et (590, 250). *)
    (160, 220, Assets.get DiamantFire,true);
    (640, 220, Assets.get DiamantWater,false);

    (* 5) Au-dessus des plateformes à (20, 200) et (680, 200). *)
    (70, 170, Assets.get DiamantFire,true);
    (730, 170, Assets.get DiamantFire,true);

    (* 6) Au-dessus de la plateforme à (250, 85), de largeur 300.
       Centre ~ 250 + (300 / 2) = 400. On place le diamant 30px plus haut => y=55. *)
    (400, 55, Assets.get DiamantWater,false);
  ]
(* --------------------- *)
(*   P O R T A I L S     *)
(* --------------------- *)
let portails () =
  List.map Portail.portail [
    (* Portail en haut du mur vertical central (exemple : deux moitiés autour de x=400, y=90). 
       On reprend la convention : (x, y, texture, x2, y2). 
       Par exemple, on place un demi-portail bleu et un rouge à proximité. *)


    (390,295, Texture.blue, 415+Cst.paddle_width+1, 295);
    (415, 295 , Texture.blue, 390-Cst.paddle_width-1, 295);


    (20,165, Texture.red, 390-Cst.paddle_width-1, 50);
    (390,50 , Texture.red, 20+Cst.paddle_width+1, 165);
  
    (775,165, Texture.black, 415+Cst.paddle_width+1, 50);
    (415,50 , Texture.black, 775-Cst.paddle_width-1, 165);

  ]