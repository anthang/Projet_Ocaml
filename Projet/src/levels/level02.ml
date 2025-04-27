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

    (720,520,hwall_color,60,50);

    (20, 500, hwall_color, 260, wall_thickness);




    (20, 560, hwall_color, 370, wall_thickness);

    (390, 560+wall_thickness/2, hwall_color, 70, wall_thickness/2); (*mur pour soutenir le piege*)

    (460, 560, hwall_color, 40, wall_thickness);
    
    (500, 560+wall_thickness/2, hwall_color, 70, wall_thickness/2); (*mur pour soutenir le piege*)

    (570, 560, hwall_color, 220, wall_thickness);
    

    (480, 440, hwall_color, 250, wall_thickness);

    (20, 440, hwall_color, 300, wall_thickness);
    (300, 440+wall_thickness/2, hwall_color, 180, wall_thickness/2);(*mur pour soutenir le piege*)

    (20, 380, hwall_color, 40, 60);


    (20, 70, hwall_color, 100, wall_thickness);
    (680, 70, hwall_color, 100, wall_thickness);


    (*rectangle geant*)
    (100, 90, hwall_color, 600, wall_thickness);
    (100, 350, hwall_color, 600, wall_thickness);

    (100, 110, hwall_color, wall_thickness, 240);
    (680, 110, hwall_color, wall_thickness, 240);

    (*mur vertical milieu*)

    (400, 110, hwall_color, wall_thickness, 240);

    (*mur horizontal milieu*)

    (360, 220, hwall_color, 100, wall_thickness);







  ]



let pieges () =
  List.map Piege.piege Cst.[

      (390, 563, piegef_color, 70, hwall_height / 2, true,false);
      (500, 563, piegew_color, 70, hwall_height / 2, false,true);


      (320, 443, Texture.black, 160, hwall_height / 2, false,false);
    
  ]



let swalls () =

     let swall_list = List.map Sinking_wall.swall Cst.[
       (280, 410, Texture.yellow, 80, 10, 430, 410);

       (*coté gauche du grand rectangle*)
       (150, 180, Texture.yellow, 80, 10, 300, 180);
       (150, 230, Texture.yellow, 80, 10, 250, 230);
       (150, 280, Texture.yellow, 80, 10, 300, 280);
       (180, 330, Texture.yellow, 80, 10, 300, 330);


       (*cote droit du grand rectangle*)
       (430, 180, Texture.yellow, 80, 10, 580, 180);
       (480, 230, Texture.yellow, 80, 10, 580, 230);
       (430, 280, Texture.yellow, 80, 10, 580, 280);
       (430, 330, Texture.yellow, 80, 10, 550, 330);

     ] in
  
  List.iteri (fun i sw ->
    Hashtbl.add Sinking_wall.swall_table i sw
  ) swall_list;
  swall_list




let monsters () =
     let monster_list = List.map Monster.monster Cst.[
       (100, 430, Texture.black, 20, 10, 250, 430);
     ] in
  List.iteri (fun i m ->
    Hashtbl.add Monster.monster_table () m
  ) monster_list;
  monster_list




  let diamonts () =
    List.map Diamont.diamont Cst.[
      (*les 2 premier diamants*)
      (425, 540, diamontf_color, true);  
      (535, 540, diamontw_color, false); 

      (*au dessus du piege noire*)
      (340, 390, diamontf_color, true);
      (380, 390, diamontw_color, false);
      (420, 390, diamontf_color, true);
      (460, 390, diamontw_color, false);


  
        (*dans le rectangle central*)
      (165, 160, diamontf_color, true);
      (315, 160, diamontw_color, false);

      (165, 210, diamontf_color, true);
      (315, 210, diamontw_color, false);
  
      (165, 260, diamontf_color, true);
      (315, 260, diamontw_color, false);
  
      (195, 310, diamontf_color, true);
      (345, 310, diamontw_color, false);
  


      
      (445, 160, diamontf_color, true);
      (595, 160, diamontw_color, false);
  

      (495, 210, diamontf_color, true);
      (645, 210, diamontw_color, false);
  
      (445, 260, diamontf_color, true);
      (595, 260, diamontw_color, false);
  
      (445, 310, diamontf_color, true);
      (595, 310, diamontw_color, false);
    ]
  

let portails () =

  List.map Portail.portail [
      (*portail dans le rectangle*)
       (395, 185, Texture.blue, 420+Cst.paddle_width, 185);
       (420, 185, Texture.blue,395-Cst.paddle_width, 185);

       (95, 250,  Texture.blue,395-Cst.paddle_width-1, 185);

       (120, 315, Texture.blue,120-Cst.paddle_width-1, 185);
       (675, 315,  Texture.red,675-Cst.paddle_width-10, 54);

      (*portail tout en haut*)
       (120, 55, Texture.blue,675-Cst.paddle_width-1,315);
       (675, 55, Texture.red, 675-Cst.paddle_width-10, 315);
    

  ]