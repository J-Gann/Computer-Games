extends Node2D
var param_V = 200
var param_T = 3
var act_T
var col_T
var old_T 
var dis
var old_dis
var stop 
var stop_act = false
var drawnow = false

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
	oldPos = sprite.to_global(sprite.get_position())
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
	if drawnow:
		update()
	if !stop_act:
		if distance() < 0:
			act_T = OS.get_system_time_msecs()
			update_actual()

func _draw():
	var rad	= 15
	var col = Color(1.0,0.0,0.0)
	draw_circle(oldPos,rad,col)
	drawnow = false

func distance():
	if oldPos.x <= wallNode.get_point_position(0).x :
		return (wallNode.get_point_position(1).x-50.0) - oldPos.x
	if oldPos.x > wallNode.get_point_position(0).x:
		return oldPos.x-(wallNode.get_point_position(1).x+50.0)
	
func update_actual():
	$ActualValueLabel.text = String(act_T-timeStart)
	stop_act = true

func fast_correction():
	return (col_T-param_T + (old_dis/param_V))-timeStart
	
func bisection():
	var t1 = col_T-param_T
	var t2 = col_T
	while abs(t1-t2)>(param_T/1000.0):
		var t = (t1+t2)/2
		if act_T > t:
			t1 = t
		else: 
			t2 = t
	return t1-timeStart


func _on_Timer_timeout():
	dis = distance()
	col_T = OS.get_system_time_msecs()
	if dis < 0:
		stop = true
		$FcValueLabel.text= String(fast_correction())
		$BisectionValueLabel.text = String(bisection())
		$Timer.stop()
	else:
		drawnow = true
		
	old_dis = dis
