open Ecs
open Component_defs
open System_defs

let current_level = ref 1


let walls    = ref []
let swalls   = ref []
let monsters = ref []
let diamonts = ref []
let pieges   = ref []
let portails = ref []

let c_register lst =
  List.iter
  (fun e ->
     Collision_system.register (e :> Collision_system.t)
  ) lst

let d_register lst =
  List.iter
  (fun e ->
     Draw_system.register (e :> Draw_system.t)
  ) lst

let d_unregister lst =
  List.iter
  (fun e ->
     Draw_system.unregister (e :> Draw_system.t)
  ) lst

let c_unregister lst =
  List.iter
  (fun e ->
     Collision_system.unregister (e :> Collision_system.t)
  ) lst




let unload_level () =
  Gfx.debug"unload_level";
  Gfx.debug"wall";
   c_unregister !walls; 
   d_unregister !walls;
   Gfx.debug"swall";
   c_unregister !swalls;
    d_unregister !swalls;
    Gfx.debug"monster";
   c_unregister !monsters;  
   d_unregister !monsters;
   Gfx.debug"diamonts";
   c_unregister !diamonts;  
   d_unregister !diamonts;
   Gfx.debug"piege";
   c_unregister !pieges;  
   d_unregister !pieges;
   Gfx.debug"portail";
   c_unregister !portails; 
   d_unregister !portails;
   Gfx.debug"fin_unload_level"



let register w sw m d p pt =
  walls := w;
  swalls := sw;
  monsters := m;
  diamonts := d;
  pieges := p;
  portails := pt;


  c_register w; d_register w;
  c_register sw; d_register sw;
  c_register m;  d_register m;
  c_register d;  d_register d;
  c_register p;  d_register p;
  c_register pt; d_register pt


let load_level lvl =
  Gfx.debug"load";
  match lvl with
  | 1 ->
    Gfx.debug"1";

   let w = Level01.walls () in
   let sw = Level01.swalls () in
   let m = Level01.monsters () in
   let d = Level01.diamonts () in
   let p = Level01.pieges () in
   let pt = Level01.portails () in

   register w sw m d p pt ;

   | 2 ->
    Gfx.debug"2";

      let w = Level02.walls () in
      let sw = Level02.swalls () in
      let m = Level02.monsters () in
      let d = Level02.diamonts () in
      let p = Level02.pieges () in
      let pt = Level02.portails () in

       register w sw m d p pt ;
   | 3 ->
    Gfx.debug"3";

      let w = Level03.walls () in
      let sw = Level03.swalls () in
      let m = Level03.monsters () in
      let d = Level03.diamonts () in
      let p = Level03.pieges () in
      let pt = Level03.portails () in
      register w sw m d p pt ;

  | _ ->
      Gfx.debug"                   rien              ";




        
