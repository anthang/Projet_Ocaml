open Component_defs
open System_defs

type tag += WPiege of piege | FPiege of piege

let piege (x, y, txt, width, height, fire) =

  let e = new piege () in
  e#texture#set txt;
  e#position#set Vector.{x = float x; y = float y};
  e#tag#set (if fire then FPiege e else WPiege e);
  e#box#set Rect.{width=width; height=height};

  e
  
(*
  let pieges () = 
    List.map piege Cst.[ 
      (150, 500 - (hwall_height / 2), piegef_color, 100, hwall_height / 2, true);  (* Piège feu *)
      (550, 420 - (hwall_height / 2), piegew_color, 100, hwall_height / 2, false); (* Piège eau *)
      (270, 340 - (hwall_height / 2), piegef_color, 150, hwall_height / 2, true);  (* Piège feu *)
      (520, 260 - (hwall_height / 2), piegew_color, 150, hwall_height / 2, false); (* Piège eau *)
    ]
  *)