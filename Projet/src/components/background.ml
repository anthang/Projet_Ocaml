open Component_defs
open System_defs

type tag += Background

let create_background (x, y, img_path, width, height) =


  let e = new background () in
  e#position#set Vector.{x = float x; y = float y};

  e#texture#set img_path;
  e#position#set Vector.{ x = float x; y = float y };
  e#box#set Rect.{ width; height };
  e#tag#set Background;
  Draw_system.(register (e :> t));

  e

let background_load () = 
  List.map create_background
    Cst.[
      (background_x, background_y, background_color, background_width, background_height);
    ]
    
