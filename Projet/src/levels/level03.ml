open Ecs
open Component_defs
open System_defs
open Assets 

let walls () =
  List.map Wall.wall Cst.[
    (* Murs extérieurs *)
    (hwall1_x, hwall1_y, hwall_color, hwall_width, hwall_height);
    (hwall2_x, hwall2_y, hwall_color, hwall_width, hwall_height);
    (vwall1_x, vwall1_y, vwall_color, wall_thickness, window_height - 2*wall_thickness);
    (vwall2_x, vwall2_y, vwall_color, wall_thickness, window_height - 2*wall_thickness);

    (* Plates-formes en "escalier" (hauteur de 10 px pour ne pas dépasser 15 px de saut) *)
    (100, 500, hwall_color, 100, 10);
    (250, 490, hwall_color, 100, 10);
    (400, 480, hwall_color, 100, 10);
    (550, 470, hwall_color, 100, 10);
    (450, 410, hwall_color, 100, 10);
    (300, 350, hwall_color, 100, 10);
    (150, 290, hwall_color, 100, 10);
  ]

let swalls () =
  (* Un exemple de mur "affaisseur" (Sinking_wall) au milieu du niveau *)
  let swall_list = List.map Sinking_wall.swall Cst.[
    (* x, y, texture, width, height, xlim, ylim par exemple *)
    (350, 200, Texture.yellow, 50, 10, 350, 200);
  ] in
  List.iteri (fun i sw ->
    Hashtbl.add Sinking_wall.swall_table i sw
  ) swall_list;
  swall_list

let pieges () =
  List.map Piege.piege Cst.[
    (* Deux pièges au sol (feu et eau) *)
    (200, window_height - hwall_height, piegef_color, 100,  hwall_height, true,false);
    (400, window_height - hwall_height, piegew_color, 100,  hwall_height, false,true);
  ]

let monsters () =
  (* Un monstre patrouillant entre deux points (par exemple) *)
  let monster_list = List.map Monster.monster Cst.[
    (350, 500, Texture.black, 20, 10, 500, 500); 
  ] in
  List.iteri (fun i m ->
    Hashtbl.add Monster.monster_table () m
  ) monster_list;
  monster_list

let diamonts () =
  List.map Diamont.diamont Cst.[
    (* Quelques diamants dispersés sur les plates-formes *)
    (120, 500 - 20, Assets.get DiamantFire, true);      (* Sur la plate-forme y=500 *)
    (270, 490 - 20, Assets.get DiamantWater, false);     (* Sur la plate-forme y=490 *)
    (420, 480 - 20, Assets.get DiamantFire, true);      
    (570, 470 - 20, Assets.get DiamantWater, false);
    (470, 410 - 20, Assets.get DiamantFire, true);
    (320, 350 - 20, Assets.get DiamantWater, false);
    (170, 290 - 20, Assets.get DiamantFire, true);
  ]

let portails () =
  List.map Portail.portail [
    (* Deux portails en haut du niveau, l’un bleu, l’autre rouge *)
    (100, 100, Texture.blue, 700, 100);  (* x, y, texture, x_dest, y_dest *)
    (700, 100, Texture.red, 100, 100);
  ]