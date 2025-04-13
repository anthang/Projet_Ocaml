open Component_defs

type t = {
  window : Gfx.window;
  ctx : Gfx.context;
  mutable player1 : player;
  mutable player2 : player;
  mutable door1 : door;
  mutable door2 : door;
  mutable current_level : int;
  
 (* ball : ball;*)
  mutable waiting : int;
}

let state = ref None
let get_current_level g =
  g.current_level
let set_level g v =
  g.current_level <- v

let get_door g =
  (g.door1 , g.door2)

let set_door g v1 v2=
    g.door1#position#set v1;
    g.door2#position#set v2

let get () : t =
  match !state with
    None -> failwith "Uninitialized global state"
  | Some s -> s

let set s = state := Some s
