open Ecs
open Component_defs
open System_defs

let current_level = ref 1


let load_level lvl =
  Draw_system.reset ();
  Collision_system.reset ();
  Move_system.reset ();
  current_level := lvl;

  match lvl with
  | 1 ->
      let _walls = Level01.walls() in
      let _swalls = Level01.swalls() in
      let _monsters = Level01.monsters() in
      let _diamonts = Level01.diamonts() in
      let _pieges = Level01.pieges() in
      let _portails = Level01.portails() in
      ()

  | 2 ->
    let _walls = Level02.walls() in
    let _swalls = Level02.swalls() in
    let _monsters = Level02.monsters() in
    let _diamonts = Level02.diamonts() in
    let _pieges = Level02.pieges() in
    let _portails = Level02.portails() in
      ()

  | _ ->
      ()


