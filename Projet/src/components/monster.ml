open Component_defs
open System_defs

type tag += Monster of monster

let monster_table : (unit, monster) Hashtbl.t = Hashtbl.create 16

let monster (dx, dy, txt, width, height, fx, fy) =
  let e = new monster () in
  e#texture#set txt;
  e#position_origin#set Vector.{ x = float dx; y = float dy };
  e#position_fin#set Vector.{ x = float fx; y = float fy };
  e#position#set Vector.{ x = float dx; y = float dy };
  e#tag#set (Monster e);
  e#box#set Rect.{ width; height };
  e#velocity#set Vector.zero;

  e
(*
let monsters () =
  let monster_list = List.map monster Cst.[
    (520, 170, Texture.black, 20, 10, 650, 170);
  ] in
  List.iteri (fun i m ->
    Hashtbl.add monster_table i m
  ) monster_list;
  monster_list

let () = ignore (monsters ())
*)
let move_monsters () =
  Hashtbl.iter (fun _ m ->
    let start_pos = m#position_origin#get in
    let current = m#position#get in
    let end_pos = m#position_fin#get in
    let direction = Vector.normalize (Vector.sub end_pos start_pos) in
    let dist_to_start = Vector.norm (Vector.sub current start_pos) in
    let dist_to_end = Vector.norm (Vector.sub current end_pos) in
    if dist_to_end < 1.0 then
      m#velocity#set (Vector.mult (-1.) direction)
    else if dist_to_start < 1.0 then
      m#velocity#set direction;
    let new_velo = m#velocity#get in
    m#position#set (Vector.add current new_velo)
  ) monster_table
