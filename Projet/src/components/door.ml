open Ecs
open Component_defs
open System_defs

type tag += DoorW of door | DoorF of door



let door1 () = 
  let Global.{door1; _ } = Global.get () in
 door1

let door2 () =
  let Global.{door2; _ } = Global.get () in
 door2

let get_position() = 
let d1 = door1() in
let d2 = door2() in
(d1#position#get, d2#position#get)


let collisions d p =
  (Vector.gety d < Vector.gety p) &&( Vector.gety p < Vector.gety d +. float(Cst.door_height))
  
  && 
  
  (Vector.getx d < Vector.getx p) && (Vector.getx p < Vector.getx d +. float(Cst.door_width))



let door (x, y,h,w, txt, fire) =
  let e = new door () in
  e#texture#set txt;
  e#position#set Vector.{x = float x; y = float y};
  e#tag#set (if fire then DoorF e else DoorW e);
  e#box#set Rect.{width = w; height = h};
  Draw_system.(register (e :> t));
  Collision_system.(register (e :> t));

  e#resolve#set (fun _ t ->
    let d1, d2 = get_position() in 
    let p1, p2 = Player.get_position() in
    if(collisions d1 p1 && collisions d2 p2) then 
        Player.player_fin()
  else
      ()
  );
  e


let doors () = 
      door Cst.(doorf_x, doorf_y,door_height,door_width, doorf_color, true),
      door Cst.(doorw_x, doorw_y,door_height,door_width, doorw_color, false)

