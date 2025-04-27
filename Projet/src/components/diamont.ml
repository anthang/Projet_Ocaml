open Ecs
open Component_defs
open System_defs

(* Déclaration du score *)
let score = ref 0  (* Variable mutable pour stocker le score *)

type tag += DiamontW of diamont | DiamontF of diamont

let diamont (x, y, txt, fire) =
  let e = new diamont () in
  e#texture#set txt;
  e#position#set Vector.{x = float x; y = float y};
  e#tag#set (if fire then DiamontW e else DiamontF e);
  e#box#set Rect.{width = 20; height = 20};


  (* Gestion des collisions pour supprimer le diamant et augmenter le score *)
  e#resolve#set (fun _ t ->
    match t#tag#get with
    | Player.Fire f -> 
        if e#tag#get = DiamontW e then begin
          Draw_system.(unregister (e :> t));  
        end
    | Player.Water w -> 
        if e#tag#get = DiamontF e then begin
          Draw_system.(unregister (e :> t));
        end
    | _ -> ()
  );
  e
(*
let diamonts () =
  (*
  Random.self_init ();
  let generate_diamonts count color flag =
    List.init count (fun _ ->
      let x = Random.int 10 in  
      let y = Random.int 10 in  
      diamont (x*50, y*50, color, flag)
    )
  in
  let list_true = generate_diamonts 10 Cst.diamontf_color true in
  let list_false = generate_diamonts 10 Cst.diamontw_color false in
  list_true @ list_false
*)
  List.map diamont Cst.[
    (* Diamants sur les plateformes principales *)
    (120, 500 - 20, diamontf_color, true);  
    (520, 500 - 20, diamontw_color, false);  

    (280, 420 - 20, diamontf_color, true);  
    (350, 420 - 20, diamontw_color, false);

    (130, 340 - 20, diamontw_color, false);  
    (530, 340 - 20, diamontf_color, true); 

    (320, 260 - 20, diamontf_color, true);  

    (140, 180 - 20, diamontw_color, false);  
    (540, 180 - 20, diamontf_color, true);  

    (350, 100 - 20, diamontw_color, false);  
  ]
*)