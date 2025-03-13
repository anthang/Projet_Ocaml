let key_table = Hashtbl.create 16
type bouton = {current : bool ; last: bool}
let table_key_pressed : (string, bouton) Hashtbl.t = Hashtbl.create 16 

let has_key s = Hashtbl.mem key_table s
let set_key s= Hashtbl.replace key_table s ()
let unset_key s = Hashtbl.remove key_table s

let action_table = Hashtbl.create 16
let register key action = Hashtbl.replace action_table key action

let handle_input () =
  let () =
    match Gfx.poll_event () with
    | KeyDown s ->
        set_key s;
        let last = match Hashtbl.find_opt table_key_pressed s with
          | None -> false
          | Some b -> b.current
        in
        Hashtbl.replace table_key_pressed s { last = last; current = true }
      
    | KeyUp s ->
        unset_key s;
        let last = match Hashtbl.find_opt table_key_pressed s with
          | None -> false
          | Some b -> b.current
        in
        Hashtbl.replace table_key_pressed s { last = last; current = false }
      
    | Quit -> exit 0
    | _ -> ()
  in 
  

  if (Hashtbl.mem table_key_pressed "i" && (Hashtbl.find table_key_pressed "i").current && (Hashtbl.find table_key_pressed "i").last ) then
    unset_key "i"
    ;

  

  Hashtbl.iter (fun key action ->
    if has_key key then 
        action ()
      else 
      Player.(move_player (player1()) Vector.zero)
  ) action_table;

  if(Hashtbl.mem table_key_pressed "i" && not(Hashtbl.find table_key_pressed "i").last) then 
    Hashtbl.replace table_key_pressed "i" { last = true; current = true }


let () =
  register "i" (fun () -> Player.(move_player (player1()) Cst.paddle_v_up));
  (*register "k" (fun () -> Player.(move_player (player1()) Cst.paddle_v_down));*)
  register "l" (fun () -> Player.(move_player (player1()) Cst.paddle_v_right));
  register "j" (fun () -> Player.(move_player (player1()) Cst.paddle_v_left));
  (*register "g" Ball.restart;*)
  register "s" (fun () ->
      let global = Global.get () in
      global.waiting <- 1;
    )