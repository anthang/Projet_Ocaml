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

let get_positionD() = 
let d1 = door1() in
let d2 = door2() in
(d1#position#get, d2#position#get)

let collisions d p =
  let px = Vector.getx p and py = Vector.gety p in
  let dx = Vector.getx d and dy = Vector.gety d in
  let margin = 3. in

  (dy -. margin <= py && py <= dy +. float Cst.door_height +. margin)
  &&
  (dx -. margin <= px && px <= dx +. float Cst.door_width +. margin)


let door (x, y,h,w, txt, fire) =
  let e = new door () in
  e#texture#set txt;
  e#position#set Vector.{x = float x; y = float y};
  e#tag#set (if fire then DoorF e else DoorW e);
  e#box#set Rect.{width = w; height = h};
  Draw_system.(register (e :> t));
  Collision_system.(register (e :> t));
  e#resolve#set (fun _ t ->
    let d1, d2 = get_positionD() in 
    let p1, p2 = Player.get_positionP() in
    if(collisions d1 p1 && collisions d2 p2) then 
      begin
        let g = Global.get () in
        let g_next = { g with current_level = g.current_level + 1 } in
        Global.set g_next;
        Level.load_level g.current_level ;
      end   
  else
      ()
  );
  e


let doors () = 
      door Cst.(doorf_x, doorf_y,door_height,door_width, doorf_color, true),
      door Cst.(doorw_x, doorw_y,door_height,door_width, doorw_color, false)


    