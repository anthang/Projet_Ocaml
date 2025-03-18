open Ecs
open Component_defs
open System_defs

type tag += Fire of player | Water of player


let stop_players () = 
  let Global.{player1; player2; _ } = Global.get () in
  player1#velocity#set Vector.zero ;
  player2#velocity#set Vector.zero  (* À remplacer en question 7.5, mettre la vitesse
        à 0 *)

let game_over () =
  Gfx.debug "Game Over ! Ctrl + r pour recommencé";
  (*Gfx.debug "score : %a\n%!" Vector.pp player#velocity#get; *)
  stop_players ();
  Unix.sleep 1  



let player (name, x, y, txt, width, height,fire) =
  let e = new player (name) in
  e#texture#set txt;
  e#tag#set (if(fire) then Fire e else Water e);
  e#position#set Vector.{x = float x; y = float y};
  e#box#set Rect.{width; height};
  e#velocity#set Cst.gravitie;
  Draw_system.(register (e :> t));
  Collision_system.(register (e :> t));
  Move_system.(register (e :> t));
  e#resolve#set (fun _ t ->
    match t#tag#get with
    | Wall.Wall w -> 
      begin
        let player_pos = e#position#get in
        let player_box = e#box#get in
        let wall_pos = w#position#get in
        let wall_box = w#box#get in
  

        let s_pos, s_rect = Rect.mdiff player_pos player_box wall_pos wall_box in
        
        if Rect.has_origin s_pos s_rect then
          let penetration = Rect.penetration_vector s_pos s_rect in
          let separation = Vector.sub Vector.zero Vector.{ x = penetration.x; y = penetration.y } in
          

          let new_pos = Vector.{ x = player_pos.x +. separation.x; y = player_pos.y +. separation.y } in
          e#position#set new_pos;
          

          let normal = if Rect.is_zero penetration.x then Vector.{ x = 0.0; y = 1.0 } else Vector.{ x = 1.0; y = 0.0 } in
          let new_velocity = Rect.reflect e#velocity#get normal in
          e#velocity#set new_velocity;
          

          if penetration.y <> 0.0 then e#velocity#set Cst.gravitie
      end
      ;

      | Piege.FPiege fp -> if e#tag#get = Water  e then begin
        Draw_system.(unregister (e :> t));  
        game_over();
      end
    else
      ()

      | Piege.WPiege wp -> if e#tag#get = Fire e then begin
        Draw_system.(unregister (e :> t));  
        Gfx.debug"Perdue";
        game_over();
      end
    else
      ()

  
  
    (* Autres collisions ou objets non spécifiques *)
    | _ ->
      let new_velo = Vector.{ x = e#velocity#get.x; y = e#velocity#get.y } in
      e#velocity#set new_velo
  );
  
  
  (* Question 7.5 enregistrer auprès du Move_system *)
  e

let players () =  
  player  Cst.("Fire", paddle1_x, paddle1_y, Texture.red, paddle_width, paddle_height,true),
  player  Cst.("Water", paddle2_x, paddle2_y, Texture.blue, paddle_width, paddle_height,false)


let player1 () = 
  let Global.{player1; _ } = Global.get () in
  player1

let player2 () =
  let Global.{player2; _ } = Global.get () in
  player2



  let move_player player v =


    let new_v = 
        if(Vector.gety player#velocity#get >= 0.1&&Vector.gety player#velocity#get <=0.3) then(
          (*Gfx.debug "Mon vecteur de vitesse : %a\n" Vector.pp player#velocity#get;*)
          v
          )
        else(
          Gfx.debug"0\n%!";
          Vector.zero
        )
      in

    let new_veloy = Vector.add (Vector.add new_v player#velocity#get) Cst.gravitie in
      
    let new_velo = Vector.{x=Vector.getx v ; y=Vector.gety new_veloy} in
  
    player#velocity#set  new_velo ;
  
  
    player#position#set  (Vector.add player#position#get player#velocity#get);

