open Component_defs
(* A module to initialize and retrieve the global state *)
type t = {
  window : Gfx.window;
  ctx : Gfx.context;
  player1 : player;
  player2 : player;
  door1 : door;
  door2 : door;
  (*ball : ball;*)
  current_level : int;
  mutable waiting : int;
}

val get : unit -> t
val set : t -> unit
