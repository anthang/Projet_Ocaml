open Ecs
open Component_defs
open System_defs



let create_background ctx font =


  let e = new background () in
  e#position#set Vector.{x = float Cst.background_x; y = float Cst.background_y};
  e#texture#set Cst.background_color;
  e#box#set Rect.{ width = Cst.background_width; height = Cst.background_height };
  e#tag#set No_tag ;
  Draw_system.(register (e :> t));

  e
