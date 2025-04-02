open Component_defs

type t = {
  window : Gfx.window;
  ctx : Gfx.context;
  player1 : player;
  player2 : player;
  door1 : door;
  door2 : door;
  mutable current_level : int;
  
 (* ball : ball;*)
  mutable waiting : int;
}

let state = ref None
let get_current_level g =
  g.current_level
let set_level g v =
  g.current_level <- v

let get () : t =
  match !state with
    None -> failwith "Uninitialized global state"
  | Some s -> s

let set s = state := Some s
