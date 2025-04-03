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
  let px = Vector.getx p +. float Cst.paddle_width/.2. and py = Vector.gety p +. float Cst.paddle_height /. 2. in
  let dx = Vector.getx d and dy = Vector.gety d in


  (dy  <= py && py <= dy +. float Cst.door_height )
  &&
  (dx  <= px && px <= dx +. float Cst.door_width )


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
    if(collisions d1 p1 &&  collisions d2 p2) then 
      begin
        Player.player_fin();
        Gfx.debug"avant_unload";
        Level.unload_level();
        Gfx.debug"apres_unload";
        let g = Global.get() in
        Gfx.debug"avant_load";
        let next_lvl = (Global.get_current_level g) + 1 in
        Global.set_level g next_lvl;
        Level.load_level next_lvl ;
        Gfx.debug"apres_load";
      end   
  else
    Gfx.debug"else";
      ()
  );
  e


let doors () = 
      door Cst.(250, 35,door_height,door_width, doorf_color, true),
      door Cst.(530, 35,door_height,door_width, doorw_color, false)


    