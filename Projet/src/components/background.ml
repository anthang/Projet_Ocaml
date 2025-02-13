open Component_defs
open System_defs

type tag += Background

let create_background (x, y, img_path, width, height) =

  let Global.{ctx; _} = Global.get () in 
  let e = new background () in
  e#position#set Vector.{x = float x; y = float y};
  let img_res = Gfx.load_image ctx img_path in
  e#texture#set (Image (Gfx.get_resource img_res));
  e#position#set Vector.{ x = float x; y = float y };
  e#box#set Rect.{ width; height };
  e#tag#set Background;
  Draw_system.(register (e :> t));

  e

let background_load () = 
  
  List.map create_background
    Cst.[
      (background_x, background_y, image_path, background_width, background_height);
    ]
    
