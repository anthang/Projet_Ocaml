open System_defs
open Component_defs
open Ecs

let update dt =
  (*let () = Player.stop_players () in*)
  let () = Input.handle_input () in
  let() = Sinking_wall.move_swalls() in
  let () = Monster.move_monsters()in
  Collision_system.update dt;
  Move_system.update dt;
  Draw_system.update dt;
  
  None


let run () =
  
  let window_spec = 
    Format.sprintf "game_canvas:%dx%d:"
      Cst.window_width Cst.window_height
  in
  let window = Gfx.create  window_spec in
  let ctx = Gfx.get_context window in
  Assets.init ctx; 

  (*let font = Gfx.load_font Cst.font_name "" 128 in*)

  Level.load_level 2;

  let player1, player2 = Player.players () in
  let door1, door2 = Door.doors ()  in
  
  let global = Global.{ window; ctx; player1; player2;door1;door2; waiting = 1;current_level = 1} in
  
  Global.set global;
  Gfx.main_loop update (fun () -> ())
    

    (*let window_spec =
      Format.sprintf "game_canvas:%dx%d:" Cst.window_width Cst.window_height
    in
    let window = Gfx.create window_spec in
    let ctx = Gfx.get_context window in
  
    (* chargement des sprites *)
    let loader = Assets.start_loading ctx in
    Gfx.main_loop
      (fun _dt ->
         if Assets.update_loading loader then Some () else None)
      (fun () ->
         (* tous les sprites sont chargés — on lance le jeu *)
         Level.load_level 1;
  
         let player1, player2 = Player.players () in
         let door1, door2 = Door.doors () in
  
         let global =Global.{ window; ctx; player1; player2; door1; door2 ; waiting = 1; current_level = 1 }
         in
         Global.set global;
  
         (* boucle de jeu « normale » *)
         Gfx.main_loop update (fun () -> ())
      )

      *)
