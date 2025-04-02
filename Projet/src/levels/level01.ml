open Ecs
open Component_defs
open System_defs


(*---------------------------LEVEL01-------------------------------*)

let walls () = 

    List.map Wall.wall Cst.[ 
      (* Bord*)
      (hwall1_x, hwall1_y, hwall_color, hwall_width, hwall_height);
      (hwall2_x, hwall2_y, hwall_color, hwall_width, hwall_height);
      (vwall1_x, vwall1_y, vwall_color, wall_thickness, window_height - 2 * wall_thickness);
      (vwall2_x, vwall2_y, vwall_color, wall_thickness, window_height - 2 * wall_thickness);
  
      (* Plateformes principales *)
      (100, 500, hwall_color, 200, hwall_height); 
      (500, 500, hwall_color, 200, hwall_height); 
  
      (250, 420, hwall_color, 300, hwall_height); 
      
      (100, 340, hwall_color, 200, hwall_height);  
      (500, 340, hwall_color, 200, hwall_height);
  
      (300, 260, hwall_color, 200, hwall_height); 
      
      (120, 180, hwall_color, 150, hwall_height); 
      (520, 180, hwall_color, 150, hwall_height);  
  
      (320, 100, hwall_color, 160, hwall_height);  
  
      (* Murs sous les pièges *)
      (150, 500, hwall_color, 100, hwall_height / 2);
      (550, 420, hwall_color, 100, hwall_height / 2);
      (270, 340, hwall_color, 150, hwall_height / 2);
      (520, 260, hwall_color, 150, hwall_height / 2);
  

    ]


let swalls () =
  let swall_list = List.map Sinking_wall.swall Cst.[
    (100, 100, Texture.yellow, 20, 10,600, 100);
   
  ] in

  List.iteri (fun i sw ->
    Hashtbl.add Sinking_wall.swall_table i sw
  ) swall_list;
  swall_list
    
    

  let pieges () = 
    List.map Piege.piege Cst.[ 
      (150, 500, piegef_color, 100, hwall_height / 2, true);
      (550, 420, piegew_color, 100, hwall_height / 2, false);
      (270, 340, piegef_color, 150, hwall_height / 2, true);
      (520, 260, piegew_color, 150, hwall_height / 2, false);
    ]
  

let monsters () =
  let monster_list = List.map Monster.monster Cst.[
    (520, 170, Texture.black, 20, 10, 650, 170);
  ] in
  List.iteri (fun i m ->
    Hashtbl.add Monster.monster_table () m
  ) monster_list;
  monster_list

  let diamonts () =

    List.map Diamont.diamont Cst.[
      (* Diamants sur les plateformes principales *)
      (120, 500 - 20, diamontf_color, true);  
      (520, 500 - 20, diamontw_color, false);  
  
      (280, 420 - 20, diamontf_color, true);  
      (350, 420 - 20, diamontw_color, false);
  
      (130, 340 - 20, diamontw_color, false);  
      (530, 340 - 20, diamontf_color, true); 
  
      (320, 260 - 20, diamontf_color, true);  
  
      (140, 180 - 20, diamontw_color, false);  
      (540, 180 - 20, diamontf_color, true);  
  
      (350, 100 - 20, diamontw_color, false);  
    ]

let portails () = 
  List.map Portail.portail [ 
    (305, 230, Texture.blue,300-Cst.paddle_width-5,230);
    (300, 230, Texture.red,305+Cst.paddle_width+5,230);

  ]
