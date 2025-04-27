
(* ---------------------------------------------------------------------------
   Module Assets : chargement BLOQUANT des sprites joueurs
   --------------------------------------------------------------------------- *)

   open Gfx
   open Texture
   
   (** Les seules textures nécessaires pour l’instant. *)
   type key =
   | PlayerFire
   | PlayerWater
   | DiamantFire          
   | DiamantWater         
   | DoorFire             
   | DoorWater
   
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
     load DiamantFire  "diamont_fire.png";
     load DiamantWater "diamont_water.png";
     load DoorFire "door_fire.png";
     load DoorWater "door_water.png";

     ()
   
   let get k = Hashtbl.find _tbl k
   
