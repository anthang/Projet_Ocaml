let key_table = Hashtbl.create 16
let table_key_pressed : (string, float) Hashtbl.t = Hashtbl.create 16 

let has_key s = Hashtbl.mem key_table s
let set_key s= Hashtbl.replace key_table s ()
let unset_key s = Hashtbl.remove key_table s

let action_table = Hashtbl.create 16
let register key action = Hashtbl.replace action_table key action

let get_key_duration key =
  try Unix.gettimeofday () -. Hashtbl.find table_key_pressed key
  with Not_found -> 0.0

let rec handle_input () =
  let current_time = Unix.gettimeofday () in
  let () =
    match Gfx.poll_event () with
    | KeyDown s ->
      set_key s;
      if(s = "i") then 
      Hashtbl.replace table_key_pressed s current_time
    else ()
    | KeyUp s -> unset_key s ;
    Hashtbl.remove table_key_pressed s 
    | Quit -> exit 0
    | _ -> ()
  in 

(*
  Hashtbl.iter (fun key action ->
    if has_key key then 
      if key = "i" then 
        if (Unix.gettimeofday () -. Hashtbl.find table_key_pressed "i") > 0.5 then
          Player.(move_player (player1()) Cst.gravitie)
        else
          action ()
      else
        action ()
    else 
      Player.(move_player (player1()) Cst.gravitie)
  ) action_table
*)

if(Hashtbl.mem table_key_pressed "i") then
  Hashtbl.iter (fun key action ->
    if has_key key then 
      if key = "i" then 
        if (Unix.gettimeofday () -. Hashtbl.find table_key_pressed "i") > 0.5 then
          Player.(move_player (player1()) Cst.gravitie)
        else
          action ()
      else
        action ()
    else 
      Player.(move_player (player1()) Cst.gravitie)
  ) action_table

let () =
  register "i" (fun () -> Player.(move_player (player1()) Cst.paddle_v_up));
  register "k" (fun () -> Player.(move_player (player1()) Cst.paddle_v_down));
  register "l" (fun () -> Player.(move_player (player1()) Cst.paddle_v_right));
  register "j" (fun () -> Player.(move_player (player1()) Cst.paddle_v_left));
  register "g" Ball.restart;
  register "s" (fun () ->
      let global = Global.get () in
      global.waiting <- 1;
    )
