open Component_defs
open System_defs

type tag += Portail of portail

let portail (dx, dy, txt,fx,fy) =
  let e = new portail () in
  e#texture#set txt;
  e#position#set Vector.{x = float dx; y = float dy};
  e#position_fin#set Vector.{x = float fx; y = float fy};
  e#tag#set (Portail e);
  e#box#set Rect.{width = 5; height = Cst.paddle_height+3};

  e
(*
let portails () = 
  List.map portail [ 
    (305, 230, Texture.blue,300-Cst.paddle_width-5,230);
    (300, 230, Texture.red,305+Cst.paddle_width+5,230);

  ]
*)