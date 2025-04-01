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


  (*let font = Gfx.load_font Cst.font_name "" 128 in*)
  (*
  let _walls = Wall.walls () in

  (*let ball = Ball.ball ctx font in*)
  let _diamont = Diamont.diamonts () in
  let _piege = Piege.pieges () in
  let _sk = Sinking_wall.swalls() in

  let _monsters = Monster.monsters() in
  let _monsters = Portail.portails() in
  *)
  Level.load_level 1 ;

  let player1, player2 = Player.players () in
  let door1, door2 = Door.doors ()  in
  
  let global = Global.{ window; ctx; player1; player2;door1;door2; waiting = 1;current_level = 1} in
  
  Global.set global;
  Gfx.main_loop update (fun () -> ())
