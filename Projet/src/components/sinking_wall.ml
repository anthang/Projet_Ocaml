open Component_defs
open System_defs

type tag += SWall of swall

let swall (x, y, txt, width, height) =
  let e = new swall () in
  e#texture#set txt;
  e#position#set Vector.{x = float x; y = float y};
  e#tag#set (SWall e);
  e#box#set Rect.{width; height};
  e#velocity#set Vector.zero;
  Draw_system.(register (e :> t));
  Collision_system.(register (e :> t));
  e

let swalls () = 
    List.map swall Cst.[ 
      (500, 500, Texture.yellow  , 200, 10); 
      (500, 500, Texture.yellow, 10, 200); 
    ]


let move_swall swall =
  let move_max = 50. in 
  let origin = swall#position_origin#get in
  let current = swall#position#get in
  let decal = false in

  

  let new_velo = 
    if Vector.gety current < move_max && decal  then 
      Vector.{x = 0.5; y = 0.} 
    else if Vector.gety current> Vector.gety origin then 
      Vector.{x = -0.5; y = 0.} 
    else 
      Vector.zero
  in
  
  swall#position#set (Vector.add current new_velo)