open Component_defs
open System_defs

type tag += Wall of wall

let wall (x, y, txt, width, height) =
  let e = new wall () in
  e#texture#set txt;
  e#position#set Vector.{x = float x; y = float y};
  e#tag#set (Wall e);
  e#box#set Rect.{width; height};
  Draw_system.(register (e :> t));
  Collision_system.(register (e :> t));
  e
(*
let walls () = 
  (*
  Random.self_init ();
  let generate_wall count color flag =
    List.init count (fun _ ->
      let x = Random.int 10 in  
      let y = Random.int 10 in  
      wall (x*50, y*20, color,Cst.platform_width,Cst.platform_height, flag)
    )
  in
  
  let lst =
    *)
    List.map wall Cst.[ 
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
    (*
  in

  let lis = generate_wall 5 Cst.diamontf_colo in

  lis@lst

  *)


  *)