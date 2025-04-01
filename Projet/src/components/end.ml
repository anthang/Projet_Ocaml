open Ecs
open Component_defs
open System_defs

type tag += Fin of fin

let fin () =
  let e = new fin () in
  e#texture#set Texture.red;
  e#position#set Vector.{x = 0.; y = 0.};
  e#box#set Rect.{width = Cst.window_width; height = Cst.window_height};
  let d1, d2 = Door.get_positionD() in 
  let p1, p2 = Player.get_positionP() in
  let collision p d =
    Vector.getx p < Vector.getx d +. 20.0 
    && Vector.getx d < Vector.getx p 
    && Vector.gety p <= Vector.gety d +. 1.0 
    && Vector.gety d -. 1.0 < Vector.gety p
  in
  if collision p1 d1 && collision p2 d2 then 
    Draw_system.(register (e :> t))
  else 
    Draw_system.(unregister (e :> t));
  e

let init_fin () = 
  fin ()