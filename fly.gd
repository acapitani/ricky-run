extends Node2D

const FLY_SPEED = 0.05

var startpos = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	startpos = $fly.position
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_timer_timeout():
	var tween = get_node("tween")
	var target = Vector2(startpos.x + (8-randi()%16), startpos.y + (8-randi()%16)) 
	var dist = target.distance_to(startpos)
	tween.interpolate_property($fly, "position", $fly.position, target, dist * FLY_SPEED, Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)
	tween.start()

func _on_tween_tween_completed(object, key):
	var r = rand_range(0.0, 1.0)
	$timer.wait_time = 0.5+r
	$timer.start()
	