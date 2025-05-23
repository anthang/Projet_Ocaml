open Ecs
class position () =
  let r = Component.init Vector.zero in
  object
    method position = r
  end
  class position_origin () =
  let r = Component.init Vector.zero in
  object
    method position_origin = r
  end
  class score () =
  let r = Component.init (0) in
  object
    method score = r
  end

  class position_fin () =
  let r = Component.init Vector.zero in
  object
    method position_fin = r
  end


class box () =
  let r = Component.init Rect.{width = 0; height = 0} in
  object
    method box = r
  end

class texture () =
  let r = Component.init (Texture.Color (Gfx.color 0 0 0 255)) in
  object
    method texture = r
  end

class velocity () =
  let r = Component.init Vector.{x=0.;y=0.} in
  object
    method velocity = r
  end

type tag = ..
type tag += No_tag

class tagged () =
  let r = Component.init No_tag in
  object
    method tag = r
  end

class resolver () =
  let r = Component.init (fun (_ : Vector.t) (_ : tagged) -> ()) in
  object
    method resolve = r
  end

(** Interfaces : ici on liste simplement les types des classes dont on hérite
    si deux classes définissent les mêmes méthodes, celles de la classe écrite
    après sont utilisées (héritage multiple).
*)

class type collidable =
  object
    inherit Entity.t
    inherit position
    inherit box
    inherit tagged
    inherit resolver
  end

class type drawable =
  object
    inherit Entity.t
    inherit position
    inherit box
    inherit texture
  end

class type movable =
  object
    inherit Entity.t
    inherit position
    inherit velocity
  end

(** Entités :
    Ici, dans inherit, on appelle les constructeurs pour qu'ils initialisent
    leur partie de l'objet, d'où la présence de l'argument ()
*)
class player name =
  object
    inherit Entity.t ~name ()
    inherit position ()
    inherit box ()
    inherit tagged ()
    inherit texture ()
    inherit resolver ()
    inherit velocity ()
    inherit score()

  end


class ball () =
  object
    inherit Entity.t ()
    inherit position ()
    inherit box ()
    inherit tagged ()
    inherit texture ()
    inherit resolver ()
    inherit velocity()
  end

class wall () =
  object
    inherit Entity.t ()
    inherit position ()
    inherit box ()
    inherit tagged ()
    inherit texture ()
    inherit resolver()
  end

  class background () =
    object
      inherit Entity.t ()
      inherit position ()
      inherit box ()
      inherit tagged ()
      inherit texture ()
    end


    class diamont () =
    object
      inherit Entity.t ()
      inherit position ()
      inherit box ()
      inherit tagged ()
      inherit texture ()
      inherit resolver ()
    end


    class door () =
    object
      inherit Entity.t ()
      inherit position ()
      inherit box ()
      inherit tagged ()
      inherit texture ()
      inherit resolver()
    end

    class piege () =
    object
      inherit Entity.t ()
      inherit position ()
      inherit box ()
      inherit tagged ()
      inherit texture ()
      inherit resolver()
    end


  class swall () =
    object
      inherit Entity.t ()
      inherit position ()
      inherit position_fin ()
      inherit position_origin ()
      inherit box ()
      inherit velocity()
      inherit tagged ()
      inherit texture ()
      inherit resolver()
    end


  class resultat () =
    object
      inherit Entity.t ()
      inherit position ()
      inherit box ()
      inherit tagged ()
      inherit texture ()

    end

  class fin () =
    object
      inherit Entity.t ()
      inherit position ()
      inherit box ()
      inherit texture ()

    end

    class monster () =
    object
      inherit Entity.t ()
      inherit position ()
      inherit position_fin ()
      inherit position_origin ()
      inherit box ()
      inherit velocity()
      inherit tagged ()
      inherit texture ()
      inherit resolver()
    end



    class portail () =
    object
      inherit Entity.t ()
      inherit position ()
      inherit position_fin ()
      inherit box ()
      inherit tagged ()
      inherit texture ()
      inherit resolver()
    end