open Component_defs
(* A module to initialize and retrieve the global state *)
type t = {
  window : Gfx.window;
  ctx : Gfx.context;
  mutable player1 : player;
  mutable player2 : player;
  mutable door1 : door;
  mutable door2 : door;
  (*ball : ball;*)
  mutable current_level : int;
  mutable waiting : int;
}

val get_current_level : t -> int
val set_level : t -> int -> unit 
val get_door : t -> door*door
val set_door : t->Vector.t->Vector.t->unit
val get : unit -> t
val set : t -> unit
