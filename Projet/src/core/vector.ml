type t = { x : float; y : float }

let egal a b  =  (a.x = b.x) &&  (a.y = b.y )

let getx v = v.x
let gety v = v.y

let add a b = { x = a.x +. b.x; y = a.y +. b.y }
let sub a b = { x = a.x -. b.x; y = a.y -. b.y }

let mult k a = { x = k*. a.x; y = k*. a.y }

let multab a b = { x = b.x*. a.x; y = b.y*. a.y }

let dot a b =  a.x*.b.x+.a.y*.b.y
let norm a = 
  sqrt(a.x*.a.x+.a.y*.a.y)
let normalize a = {x=a.x/.norm a;y=a.y/.norm a}
let pp fmt a = Format.fprintf fmt "(%f, %f)" a.x a.y

let zero = { x = 0.0; y = 0.0 }
let is_zero v = v.x = 0.0 && v.y = 0.0