extends Node2D
var param_V = 200
var param_T = 3
var act_T
var old_T
var dis
var old_dis
var stop 
var stop_act = false

var rad	= 10
var col = Color(255,0,0)

var pathNode
var wallNode
var roadNode
var sprite

var oldPos
var curPos

var timeStart

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	pathNode = get_node("Path2D/CharacterFollow")
	wallNode = get_node("Wall")
	roadNode = get_node("Road")
	sprite = get_node("Path2D/CharacterFollow/Sprite")

	set_process(false)
	
func _on_Button_pressed():
	timeStart = OS.get_system_time_msecs()
	pathNode.set_offset(0)
	set_process(true)
	param_T = $Time.value
	$Timer.start(param_T)
	old_T = param_T
	stop = false

func _process(delta):
	param_V = $Speed.value
	param_T = $Time.value
	if param_T != old_T:
		$Timer.stop()
		$Timer.start(param_T)
		old_T = param_T
	
	oldPos = sprite.to_global(sprite.get_position())
	dis = distance()
	if !stop:
		var newOffset = pathNode.get_offset() + param_V * delta
		pathNode.set_offset(newOffset)
	update()
	if !stop_act:
		if distance() < 0:
			update_actual()

func _draw():
	pass
	#draw_circle(Vector2(oldPos.x, oldPos.y),rad,col)

func distance():
	if oldPos.x <= wallNode.get_point_position(0).x :
		return (wallNode.get_point_position(1).x-50.0) - oldPos.x
	if oldPos.x > wallNode.get_point_position(0).x:
		return oldPos.x-(wallNode.get_point_position(1).x+50.0)
	
func update_actual():
	$ActualValueLabel.text = String(OS.get_system_time_msecs())
	stop_act = true

func fast_correction():
	return act_T-param_T + (old_dis/param_V)
	
func bisection():
	var t1 = act_T-param_T
	var t2 = act_T
	while abs(t1-t2)>(param_T/1000.0):
		var t = (t1+t2)/2


func _on_Timer_timeout():
	dis = distance()
	act_T = OS.get_system_time_msecs()
	if dis < 0:
		stop = true
		$FcValueLabel.text= String(fast_correction())
		
		$Timer.stop()
	else:
		_draw()
	old_dis = dis
