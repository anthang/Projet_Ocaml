let key_table = Hashtbl.create 16
let table_key_pressed : (string, unit) Hashtbl.t = Hashtbl.create 16

let has_key s = Hashtbl.mem key_table s
let set_key s= Hashtbl.replace key_table s ()
let unset_key s = Hashtbl.remove key_table s

let action_table = Hashtbl.create 16
let register key action = Hashtbl.replace action_table key action


let handle_input () =
  let () =
    match Gfx.poll_event () with
    | KeyDown s ->
      if not (Hashtbl.mem table_key_pressed s) then begin
        set_key s;
        Hashtbl.replace table_key_pressed s ()
      end else unset_key s
    | KeyUp s -> unset_key s ;Hashtbl.remove table_key_pressed s 
    | Quit -> exit 0
    | _ -> ()
  in 


  Hashtbl.iter (fun key action ->
      if has_key key then action () else Player.(move_player (player1()) Cst.gravitie) ) action_table


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
