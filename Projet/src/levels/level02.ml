open Ecs
open Component_defs
open System_defs
let walls () =
  List.map Wall.wall Cst.[
    (* Bords extérieurs *)
    (hwall1_x, hwall1_y, hwall_color, hwall_width, hwall_height);                  (* Mur horizontal du haut *)
    (hwall2_x, hwall2_y, hwall_color, hwall_width, hwall_height);                  (* Mur horizontal du bas *)
    (vwall1_x, vwall1_y, vwall_color, wall_thickness, window_height - 2*wall_thickness); (* Mur vertical gauche *)
    (vwall2_x, vwall2_y, vwall_color, wall_thickness, window_height - 2*wall_thickness); (* Mur vertical droit *)

    (* 
       On va ajouter plusieurs "étages" (murs horizontaux) 
       à l’intérieur de la zone de jeu. 
       Chaque étage aura un « trou » (une ouverture) 
       pour laisser passer le personnage.
       
       On alterne le trou soit à gauche, soit à droite.
       y = 100, 200, 300, 400, 500 (épaisseur : wall_thickness)
    *)

    (* Étage 1 : trou à gauche (x=30 -> x=100) *)
    (100, 100, hwall_color, 670, wall_thickness);
    (* Étage 2 : trou à droite (x=730 -> x=770) *)
    (30, 200, hwall_color, 700, wall_thickness);
    (* Étage 3 : trou à gauche *)
    (100, 300, hwall_color, 670, wall_thickness);
    (* Étage 4 : trou à droite *)
    (30, 400, hwall_color, 700, wall_thickness);
    (* Étage 5 : trou à gauche *)
    (100, 500, hwall_color, 670, wall_thickness);
  ]

(** Murs "affaisseurs" (sinking walls) s'il y en a, sinon liste vide *)
let swalls () =
  let swall_list = [] in
  (* Exemple si vous voulez en ajouter :
     let swall_list = List.map Sinking_wall.swall Cst.[
       (100, 150, Texture.yellow, 20, 10, 600, 150);
     ] in
  *)
  List.iteri (fun i sw ->
    Hashtbl.add Sinking_wall.swall_table i sw
  ) swall_list;
  swall_list

(** Pièges éventuels, sinon liste vide *)
let pieges () =
  List.map Piege.piege Cst.[
    (* Par exemple :
       (150, 500, piegef_color, 100, hwall_height / 2, true);
    *)
  ]

(** Monstres éventuels, sinon liste vide *)
let monsters () =
  let monster_list = [] in
  (* Exemple d’un monstre :
     let monster_list = List.map Monster.monster Cst.[
       (520, 170, Texture.black, 20, 10, 650, 170);
     ] in
  *)
  List.iteri (fun i m ->
    Hashtbl.add Monster.monster_table () m
  ) monster_list;
  monster_list

(** Diamants éventuels, sinon liste vide *)
let diamonts () =
  List.map Diamont.diamont Cst.[
    (* Exemple :
       (120, 100, diamontf_color, true);
       (300, 100, diamontw_color, false);
    *)
  ]

(** Portails éventuels, sinon liste vide *)
let portails () =
  List.map Portail.portail [
    (* Exemple :
       (305, 230, Texture.blue, 100, 230);
       (300, 230, Texture.red, 600, 230);
    *)
  ]