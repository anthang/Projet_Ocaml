let key_table = Hashtbl.create 16
let table_key_pressed : (string, bool) Hashtbl.t = Hashtbl.create 16 

let has_key s = Hashtbl.mem key_table s
let set_key s= Hashtbl.replace key_table s ()
let unset_key s = Hashtbl.remove key_table s

let is_done s =
    if Hashtbl.mem table_key_pressed s then
      Hashtbl.find table_key_pressed s
    else
      true

let action_done key =
  Hashtbl.replace table_key_pressed key true
let unique_action key =
  key = "i" || key = "z"

let action_table = Hashtbl.create 16
let register key action = Hashtbl.replace action_table key action



let handle_input () =
  let () =
    match Gfx.poll_event () with
    | KeyDown s ->
        set_key s;
        let last = match Hashtbl.find_opt table_key_pressed s with
          | None -> false
          | Some b -> b
        in
        Hashtbl.replace table_key_pressed s last
      
    | KeyUp s ->
        unset_key s;
        Hashtbl.remove table_key_pressed s
      
    | Quit -> exit 0
    | _ -> ()
  in 
  
  

  Hashtbl.iter (fun key action ->
    if not (is_done key) then 
      begin
        action ();
        if unique_action key then
          action_done key
      end

      else 
      begin
        Player.(move_player (player1()) Vector.zero);
        Player.(move_player (player2()) Vector.zero)
      end
  ) action_table

let () =

  register "i" (fun () -> Player.(move_player (player1()) Cst.paddle_v_up));
  register "l" (fun () -> Player.(move_player (player1()) Cst.paddle_v_right));
  register "j" (fun () -> Player.(move_player (player1()) Cst.paddle_v_left));

  register "q" (fun () -> Player.(move_player (player2()) Cst.paddle_v_left));
  register "d" (fun () -> Player.(move_player (player2()) Cst.paddle_v_right));
  register "z" (fun () -> Player.(move_player (player2()) Cst.paddle_v_up));



