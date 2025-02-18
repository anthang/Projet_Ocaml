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

let paddle_width = 24
let paddle_height = 128

let wall_thickness = 32

let hwall_width = window_width
let hwall_height = wall_thickness

let paddle1_x = 64 + paddle_width / 2
let paddle1_y = window_height-wall_thickness-paddle_height

let paddle2_x = window_width - paddle1_x - paddle_width
let paddle2_y = paddle1_y
let paddle_color = Texture.blue

let paddle_v_up = Vector.{ x = 0.0; y = -5.0 }
let paddle_v_right = Vector.{ x = 5.0; y = 0.0 }
let paddle_v_down = Vector.sub Vector.zero paddle_v_up
let gravitie = Vector.{x=0.;y=0.2}
let paddle_v_left = Vector.sub Vector.zero paddle_v_right

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
let platform_y=200

let background_x = wall_thickness
let background_y = wall_thickness
let background_width = window_width-2*wall_thickness
let background_height = window_height-2*wall_thickness
let background_color=Texture.black
let image_path ="./resources/images/block.png"
let font_name = if Gfx.backend = "js" then "monospace" else "resources/images/monospace.ttf"
let font_color = Gfx.color 0 0 0 255
