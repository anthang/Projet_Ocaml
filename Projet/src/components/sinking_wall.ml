open Component_defs
open System_defs

type tag += SWall of swall 


let swall_table : (int, swall) Hashtbl.t = Hashtbl.create 16

let swall (dx, dy, txt, width, height, fx, fy) =
  let e = new swall () in
  e#texture#set txt;
  e#position_origin#set Vector.{ x = float dx; y = float dy };
  e#position_fin#set Vector.{ x = float fx; y = float fy };
  e#position#set Vector.{ x = float dx; y = float dy };
  e#tag#set (SWall e);
  e#box#set Rect.{ width; height };
  e#velocity#set Vector.zero;

  e

(*
let swalls () =
  let swall_list = List.map swall Cst.[
    (100, 100, Texture.yellow, 20, 10,600, 100);
    
  ] in

  List.iteri (fun i sw ->
    Hashtbl.add swall_table i sw
  ) swall_list;
  swall_list

*)

let move_swalls () =
  Hashtbl.iter (fun _ sw ->
    let origin = sw#position_origin#get in
    let current = sw#position#get in
    let fin = sw#position_fin#get in
    let direction = Vector.normalize (Vector.sub fin origin) in
    let dist_to_origin = Vector.norm (Vector.sub current origin) in
    let dist_to_fin = Vector.norm (Vector.sub current fin) in
    if dist_to_fin < 1.0 then
      sw#velocity#set (Vector.mult (-1.) direction)
    else if dist_to_origin < 1.0 then
      sw#velocity#set direction;
    let new_velo = sw#velocity#get in
    sw#position#set (Vector.add current new_velo)
  ) swall_table
