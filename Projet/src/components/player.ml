open Ecs
open Component_defs
open System_defs

type tag += Player

let player (name, x, y, txt, width, height) =
  let e = new player name in
  e#texture#set txt;
  e#tag#set Player;
  e#position#set Vector.{x = float x; y = float y};
  e#box#set Rect.{width; height};
  e#velocity#set Cst.gravitie;
  Draw_system.(register (e :> t));
  Collision_system.(register (e :> t));
  Move_system.(register (e :> t));
  e#resolve#set (fun _ t ->
    match t#tag#get with
    | Wall.HWall w -> 
      begin
        let player_pos = e#position#get in
        let player_box = e#box#get in
        let wall_pos = w#position#get in
        let wall_box = w#box#get in
  
        (* Calcul de la différence Minkowski entre le joueur et le mur *)
        let s_pos, s_rect = Rect.mdiff player_pos player_box wall_pos wall_box in
        
        if Rect.has_origin s_pos s_rect then
          let penetration = Rect.penetration_vector s_pos s_rect in
          let separation = Vector.sub Vector.zero Vector.{ x = penetration.x; y = penetration.y } in
          
          (* Appliquer la séparation *)
          let new_pos = Vector.{ x = player_pos.x +. separation.x; y = player_pos.y +. separation.y } in
          e#position#set new_pos;
          
          (* Réfléchir la vitesse en fonction de la direction de la collision *)
          let normal = if Rect.is_zero penetration.x then Vector.{ x = 0.0; y = 1.0 } else Vector.{ x = 1.0; y = 0.0 } in
          let new_velocity = Rect.reflect e#velocity#get normal in
          e#velocity#set new_velocity;
          
          (* Si le joueur touche un mur, on arrête sa vitesse sur l'axe de la collision *)
          if penetration.y <> 0.0 then e#velocity#set Vector.zero
      end;
  
    (* Cas où il n'y a pas de collision *)
    | No_tag ->
      let new_velo = Vector.{ x = e#velocity#get.x; y = Vector.gety Cst.gravitie } in
      e#velocity#set new_velo
  
    (* Autres collisions ou objets non spécifiques *)
    | _ ->
      let new_velo = Vector.{ x = e#velocity#get.x; y = e#velocity#get.y } in
      e#velocity#set new_velo
  );
  
  
  (* Question 7.5 enregistrer auprès du Move_system *)
  e

let players () =  
  player  Cst.("player1", paddle1_x, paddle1_y, paddle_color, paddle_width, paddle_height),
  player  Cst.("player2", paddle2_x, paddle2_y, paddle_color, paddle_width, paddle_height)


let player1 () = 
  let Global.{player1; _ } = Global.get () in
  player1

let player2 () =
  let Global.{player2; _ } = Global.get () in
  player2

let stop_players () = 
  let Global.{player1; player2; _ } = Global.get () in
  player1#velocity#set Vector.zero ;
  player2#velocity#set Vector.zero  (* À remplacer en question 7.5, mettre la vitesse
        à 0 *)

let move_player player v =
  (* Affichage du vecteur de vitesse *)
  (*Gfx.debug "Mon vecteur de vitesse : %a\n" Vector.pp player#velocity#get;*)
  let new_veloy = 
    if(Vector.gety player#velocity#get = Vector.gety Cst.gravitie) then
      Vector.add v player#velocity#get 
    else
      Vector.add player#velocity#get Cst.gravitie
    in
    
  let new_velo = Vector.{x=Vector.getx v ; y=Vector.gety new_veloy} in
  (* Mise à jour de la vélocité *)
  player#velocity#set  new_velo ;

  (* Mise à jour de la position *)
  player#position#set  (Vector.add player#position#get player#velocity#get);
  Gfx.debug "Mon vecteur de vitesse : %a\n" Vector.pp player#velocity#get

        
