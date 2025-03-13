open Ecs
open Component_defs
open System_defs

type tag += DoorW of door | DoorF of door

let door (x, y,h,w, txt, fire) =
  let e = new door () in
  e#texture#set txt;
  e#position#set Vector.{x = float x; y = float y};
  e#tag#set (if fire then DoorF e else DoorW e);
  e#box#set Rect.{width = w; height = h};
  Draw_system.(register (e :> t));
  Collision_system.(register (e :> t));


  let fire_touched = ref false in
  let water_touched = ref false in


  e#resolve#set (fun _ t ->
    match t#tag#get with
    | Player.Fire f -> 
        if e#tag#get = DoorF e then begin
          fire_touched := true;  
          if !fire_touched && !water_touched then
            Gfx.debug"2\n";
        end else begin
          fire_touched := false; 
          Gfx.debug"3\n";
        end
    | Player.Water w -> 
        if e#tag#get = DoorW e then begin
          water_touched := true; 

          if !fire_touched && !water_touched then
            Gfx.debug"1\n";
        end else begin
          Gfx.debug"0\n";
        end
    | _ -> ()
  );
  
  e

let doors () = 
  List.map door
    Cst.[ 
      (doorf_x, doorf_y,door_height,door_width, doorf_color, true);
      (doorw_x, doorw_y,door_height,door_width, doorw_color, false);
    ]
