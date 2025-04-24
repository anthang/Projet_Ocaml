open Ecs
open Component_defs
open System_defs
open Assets 

type tag += Fire of player | Water of player
let sprite_w = 20
let sprite_h = 30



let player_fin () =
  let Global.{player1; player2; _ } = Global.get () in
  player1#position#set Vector.{x=float Cst.paddle1_x; y=float Cst.paddle1_y} ;
  player2#position#set Vector.{x=float Cst.paddle2_x; y=float Cst.paddle2_y} 




let player (name, x, y, txt, width, height,fire) =
  let e = new player (name) in
  e#texture#set txt;
  e#tag#set (if(fire) then Fire e else Water e);
  e#position#set Vector.{x = float x; y = float y};
  e#box#set Rect.{width; height};
  e#velocity#set Cst.gravitie;
  e#score#set 0 ;
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

      end
    else
      ()

      | Piege.WPiege wp -> if e#tag#get = Fire e then begin
        Draw_system.(unregister (e :> t));  

      end
    else
      ()
      | Piege.NPiege wp -> 
        Draw_system.(unregister (e :> t))
        
      |Sinking_wall.SWall sw -> 
        begin
          let player_pos = e#position#get in
          let player_box = e#box#get in
          let wall_pos = sw#position#get in
          let wall_box = sw#box#get in
    
  
          let s_pos, s_rect = Rect.mdiff player_pos player_box wall_pos wall_box in
          
          if Rect.has_origin s_pos s_rect then
            let penetration = Rect.penetration_vector s_pos s_rect in
            let separation = Vector.sub Vector.zero Vector.{ x = penetration.x; y = penetration.y } in
            
  
            let new_pos = Vector.{ x = player_pos.x +. separation.x; y = player_pos.y +. separation.y } in
            e#position#set new_pos;
            
  
            let normal = if Rect.is_zero penetration.x then Vector.{ x = 0.0; y = 1.0 } else Vector.{ x = 1.0; y = 0.0 } in
            let new_velocity = Rect.reflect e#velocity#get normal in
            e#velocity#set new_velocity;
            
  
            if penetration.y <> 0.0 then e#velocity#set( Vector.add sw#velocity#get Cst.gravitie)
        end
        ;
        |Monster.Monster _ ->
          Draw_system.(unregister (e :> t));  

        |Portail.Portail p ->
          e#position#set p#position_fin#get
  
  
    (* Autres collisions ou objets non spécifiques *)
    | _ ->
      let new_velo = Vector.{ x = e#velocity#get.x; y = e#velocity#get.y } in
      e#velocity#set new_velo
  );
  
  
  (* Question 7.5 enregistrer auprès du Move_system *)
  e

let players () =  
  (*player  Cst.("Fire" , 50, 500, Texture.red , paddle_width, paddle_height,true ),
  player  Cst.("Water", 750, 500, Texture.blue, paddle_width, paddle_height,false)*)
  player ("Fire",  50, 500, Assets.get PlayerFire,  sprite_w, sprite_h, true),
  player ("Water", 750, 500, Assets.get PlayerWater, sprite_w, sprite_h, false)

let player1 () = 
  let Global.{player1; _ } = Global.get () in
  player1

let player2 () =
  let Global.{player2; _ } = Global.get () in
  player2

let stop = ref false

let switch () = stop := not !stop

let move_player player v =
  (*
  Gfx.debug "move ! %s (%f.2)\n%!" (match Vector.gety v with
  | u when u<0. -> "up"
  | d when d>0. -> "down"
  | _ -> "horiz" ) (Vector.gety v);
  Gfx.debug "player ! %s \n%!" (match player#tag#get  with
  | Fire f  -> "fire"
  | Water w  -> "water"
  | _ -> "none" ) ;

  *)

  let new_v = 
    if(Vector.gety player#velocity#get >= 0.2
      &&Vector.gety player#velocity#get <=0.3) then(
      v
    ) else
      Vector.zero
  in
  let new_veloy = Vector.add (Vector.add new_v player#velocity#get)
                               Cst.gravitie in
  let new_velo = Vector.{x=Vector.getx v ; y=Vector.gety new_veloy} in
  
  player#velocity#set  new_velo;
  
  player#position#set  (Vector.add player#position#get player#velocity#get)



    let get_score() = 
    let p1 = player1() in
    let p2 = player2() in
    (p1#score#get, p2#score#get)


    let get_positionP() = 
    let p1 = player1() in
    let p2 = player2() in
    (p1#position#get, p2#position#get)