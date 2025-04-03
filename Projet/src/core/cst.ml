(*
HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
V                               V
V  1                         2  V
V  1 B                       2  V
V  1                         2  V
V  1                         2  V
V                               V
HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
*)


let window_width = 800
let window_height = 600

let paddle_width = 20
let paddle_height = 30

let wall_thickness = 20

let hwall_width = window_width
let hwall_height = wall_thickness

let paddle1_x = window_width/2 + paddle_width / 2
let paddle1_y = window_height-wall_thickness-paddle_height

let paddle2_x = window_width - paddle1_x - paddle_width
let paddle2_y = paddle1_y
let paddle_color = Texture.blue

let paddle_v_up = Vector.{ x = 0.0; y = -3.0 }
let paddle_v_right = Vector.{ x = 3.5; y = 0.0 }

(*let paddle_v_down = Vector.sub Vector.zero paddle_v_up*)
let gravitie = Vector.{x=0.;y=0.05}
let paddle_v_left = Vector.{ x = -3.5; y = 0.0 }

let ball_size = 24
let ball_color = Texture.red

let ball_v_offset = window_height / 2 - ball_size / 2
let ball_left_x = 128 + ball_size / 2
let ball_right_x = window_width - ball_left_x - ball_size

let hwall1_x = 0
let hwall1_y = 0
let hwall2_x = 0
let hwall2_y = window_height -  wall_thickness
let hwall_color = Texture.green

let vwall_width = wall_thickness
let vwall_height = window_height - 2 * wall_thickness
let vwall1_x = 0
let vwall1_y = wall_thickness 
let vwall2_x = window_width - wall_thickness
let vwall2_y = vwall1_y
let vwall_color = Texture.yellow




let platform_color = Texture.blue
let platform_width = 100
let platform_height = 20
let platform_x=32
let platform_y=window_height-wall_thickness-70

let background_x = wall_thickness
let background_y = wall_thickness
let background_width = window_width-2*wall_thickness
let background_height = window_height-2*wall_thickness
let background_color=Texture.black
let image_path ="./resources/images/block.png"
let font_name = if Gfx.backend = "js" then "monospace" else "resources/images/monospace.ttf"
let font_color = Gfx.color 0 0 0 255

(*--------------------------------------------------------------------  ------------------------------------------------------------------------------------------------------*)



(*--------------------------------------------------------------------DIAMONT------------------------------------------------------------------------------------------------------*)


let diamontw_x = 100
let diamontw_y = 450
let diamontf_x = 200
let diamontf_y = 450
let diamontf_color = Texture.red
let diamontw_color = Texture.blue
let vwall_width = 10
let vwall_height = 10



(*--------------------------------------------------------------------DOOR------------------------------------------------------------------------------------------------------*)


let doorw_x = 100

let door_height = 50
let door_width = 20
let doorw_y = window_height-door_height-wall_thickness
let doorf_x = 200
let doorf_y = doorw_y
let doorf_color = Texture.red
let doorw_color = Texture.blue

(*--------------------------------------------------------------------PIEGE------------------------------------------------------------------------------------------------------*)
let piegew_x = 100

let piege_height = hwall_height/2
let piege_width = hwall_width/2
let piegew_y = window_height-wall_thickness-100
let piegef_x = 200
let piegef_y = piegew_y
let piegef_color = Texture.red
let piegew_color = Texture.blue