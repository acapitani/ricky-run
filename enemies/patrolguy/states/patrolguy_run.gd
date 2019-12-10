extends "res://scripts/state.gd"

var state_timer

func initialize( obj ):
	obj.anim_nxt = "run"
	
func run( obj, delta ):
	obj.vel.x = obj.MAX_VEL * obj.dir_cur
	
	# gravity
	obj.vel.y = min( obj.vel.y + game.GRAVITY * delta, game.TERMINAL_VELOCITY )
	# move
	obj.vel = obj.move_and_slide( obj.vel )
	
	# check limits
	if obj.reached_limit():
		obj.dir_nxt = -obj.dir_cur
