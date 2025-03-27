
open Component_defs
open System_defs

type tag += SFire of int | SWater of int

let resultat (x,fire) =

  let e = new resultat () in
  e#texture#set (if fire then Texture.red else Texture.blue);
  e#position#set Vector.{x = float x; y = 0.};
  e#tag#set (if fire then SFire 0 else SWater 0);
  e#box#set Rect.{width= 100; height= 100};
  Draw_system.(register (e :> t));
  e
  

  let resultats () = 
    List.map resultat [ 
      (250,true);  (* Piège feu *)
      (450, false); (* Piège eau *)

    ]

let update_resultat() =
let f, w = Player.get_score() in
List.iter (fun e ->
  match e#tag#get with
  | SFire _ -> e#tag#set (SFire f)
  | SWater _ -> e#tag#set (SWater w)
  | _ -> ()
) (resultats ())


  