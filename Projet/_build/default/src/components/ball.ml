open Ecs
open Component_defs
open System_defs

let ball ctx font =
  let e = new ball () in
  let y_orig = float Cst.ball_v_offset in
  e#texture#set Cst.ball_color;
  e#position#set Vector.{x = float Cst.ball_left_x; y = y_orig};
  e#box#set Rect.{width = Cst.ball_size; height = Cst.ball_size};
  
  e#velocity#set Vector.zero;

  Draw_system.(register (e :> t));
  Collision_system.(register (e :> t));
  Move_system.(register (e :> t));
  e#resolve#set (fun n t ->
    match t#tag#get with
    Wall.HWall _ | Player.Player -> (* ici la balle est en collision
    avec un des murs horizontaux ou une des raquettes.
    Le vecteur n passé en argument contient soit { x = -1.0; y = 1.0 }
    soit { x = 1.0; y = -1.0 }. Il suffit de le multiplier à la
    vitesse de la balle , composante par composante pour obtenir le
    symétrique du vecteur n et faire rebondir la balle.
    *)
    e#velocity#set Vector.{x = e#velocity#get.x *. n.x; y = e#velocity#get.y *. n.y};
    | Wall.VWall (i, _) -> (* On est entré en collision avec le mur i=1
    pour gauche ou i=2 pour droite. Il faut arrêter la balle ,
    la repositionner en face de la raquette correspondante puis
    mettre le champ ’waiting ’ de l’objet global à i (1 ou 2).
    Dans cet état, une pression sur la touche G fera repartir la
    balle.
    *)let global = Global.get () in
    if i = 1 then begin
      e#position#set Vector.{x = 140.0; y = y_orig};
      global.waiting <- 1
    end else begin
      e#position#set Vector.{x = 628.0; y = y_orig};
      global.waiting <- 2
    end;
    e#velocity#set Vector.zero

    | _ -> ()
    );

  (* Question 7.6 enregistrer auprès du Move_system *)
  e

let random_v b =
  let a = Random.float (Float.pi/.2.0) -. (Float.pi /. 4.0) in
  let v = Vector.{x = cos a; y = sin a} in
  let v = Vector.mult 5.0 (Vector.normalize v) in
  if b then v else Vector.{ v with x = -. v.x }

let restart () =
  let global = Global.get () in
  if global.waiting <> 0 then begin
    let v = random_v (global.waiting = 1) in
    global.waiting <- 0;
    global.ball#velocity#set v;
    () (* à remplacer question 7.6
          la vitesse de global.ball à v   
    *)
  end