extends KinematicBody2D

const MAX_VEL = 50
const ACCEL = 15

var fsm = null

var dir_cur = -1
export( int ) var dir_nxt = 1
var vel = Vector2()

var front_colliding = false

var anim_cur = ""
var anim_nxt = ""
var limits = []

onready var rotate = $rotate

func _ready():
	fsm = preload( "res://scripts/fsm.gd" ).new( self, $states, $states/patrolguy_run, false )
	call_deferred( "_set_limits" )


func _set_limits():
	var lleft = find_node( "limit_left" )
	var lright = find_node( "limit_right" )
	if lleft != null and lright != null:
		limits = [ lleft.global_position.x, lright.global_position.x ]
	
func _physics_process(delta):
	# update states machine
	fsm.run_machine( delta )
	# direction
	if dir_nxt != dir_cur:
		dir_cur = dir_nxt
		$rotate.scale.x = -1*dir_cur
	# update animations
	if anim_nxt != anim_cur:
		anim_cur = anim_nxt
		$anim.play( anim_cur )
	_check_front()
		
func _check_front():
	var coll = $front.is_colliding()
	var collider = $front.get_collider()
	if collider!=null:
		coll = true
	else:
		coll = false
	if coll!=front_colliding:
		front_colliding = coll
		if coll:
			print("front_colliding = yes")
		else:
			print("front_colliding = no")	

func reached_limit():
	#if $rotate/front.is_colliding():
	#	return true
	if not limits.empty():
		if global_position.x < limits[0] or global_position.x > limits[1]:
			return true
	return false
	