(*


(* ------------------------------------------------------------------------- *)
(*  Module Assets : chargement asynchrone des sprites                        *)
(* ------------------------------------------------------------------------- *)

open Gfx
open Texture

type key =
  | PlayerFire | PlayerWater
  | DiamontFire | DiamontWater
  (* + ajoute d’autres clés ici *)

let _tbl : (key, Texture.t) Hashtbl.t = Hashtbl.create 16

(* ---------------------------  Loader interne  --------------------------- *)

module Loader = struct
  type entry = { k : key; handle : Gfx.surface Gfx.resource }
  type t = { entries : entry list; mutable finished : bool }

  let key_of_string = function
    | "PlayerFire"   -> PlayerFire
    | "PlayerWater"  -> PlayerWater
    | s              -> failwith ("Assets: unknown key "^s)

  let start ctx : t =
    (* lit le fichier sprites.txt *)
    let file_r = Gfx.load_file "resources/files/sprites.txt" in
    let txt = Gfx.get_resource file_r in      (* bloquant : fichier très petit *)
    let entries =
      txt |> String.split_on_char '\n'
          |> List.filter (fun l -> l <> "")
          |> List.map (fun line ->
               match String.split_on_char ',' line with
               | [k ; fname] ->
                   let handle = Gfx.load_image ctx ("resources/images/" ^ fname) in
                   { k = key_of_string k; handle }
               | _ -> failwith ("Bad line in sprites.txt: "^line) )
    in
    { entries; finished = false }

  (* Renvoie [true] quand toutes les images sont chargées,
     et remplit la table [_tbl] à ce moment-là. *)
  let poll (t : t) : bool =
    if t.finished then true
    else if List.for_all (fun e -> Gfx.resource_ready e.handle) t.entries then begin
      List.iter (fun e ->
        let surf = Gfx.get_resource e.handle in
        Hashtbl.replace _tbl e.k (Texture.Image surf)
      ) t.entries;
      t.finished <- true;
      true
    end else
      false
end

(* ---------------------------  API publique  ----------------------------- *)

let start_loading ctx = Loader.start ctx        (* retourne un loader *)
let update_loading    = Loader.poll             (* à appeler chaque frame *)
let get k             = Hashtbl.find _tbl k     (* récupère la texture *)
   

*)

(* ---------------------------------------------------------------------------
   Module Assets : chargement BLOQUANT des sprites joueurs
   --------------------------------------------------------------------------- *)

   open Gfx
   open Texture
   
   (** Les seules textures nécessaires pour l’instant. *)
   type key = PlayerFire | PlayerWater
   
   let _tbl : (key, Texture.t) Hashtbl.t = Hashtbl.create 4
   
   (** [init ctx] charge immédiatement les deux PNG. À appeler juste après avoir
       obtenu le contexte graphique. *)
   let init (ctx : Gfx.context) : unit =
     let load k file =
       let res   = Gfx.load_image ctx ("resources/images/" ^ file) in
       let surf  = Gfx.get_resource res in   (* blocant : < 1 ms pour 1 image *)
       Hashtbl.add _tbl k (Image surf)
     in
     load PlayerFire  "player_fire.png";
     load PlayerWater "player_water.png";
     ()
   
   let get k = Hashtbl.find _tbl k
   
