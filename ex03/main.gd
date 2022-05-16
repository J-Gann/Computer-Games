extends Node2D


onready var spr1 = get_node("Sprite")
onready var spr2 = get_node("Sprite2")
onready var spr3 = get_node("Sprite3")

func _ready():
	var size = spr2.scale
	spr1.scale = 2*size
	spr3.scale = 0.5*size
	var t1 = get_node("Timer")
	t1.start(30)
	var t2 = get_node("Timer2")
	t2.start(20)
	var t3 = get_node("Timer3")
	t3.start(10)

func _process(delta):
	var angular_speed = 4
	spr1.rotation += angular_speed * delta
	spr2.rotation += angular_speed * delta * 1.5
	spr3.rotation += -angular_speed * delta * 0.5
	var mouse_pos = get_local_mouse_position()
	var sprt1_pos = spr1.get_position_in_parent()
	var sprt2_pos = spr2.get_position_in_parent()
	spr1.position = spr1.position.linear_interpolate(mouse_pos, delta * 4 )
	spr2.position = spr2.position.linear_interpolate(spr1.position, delta * 4 )
	spr3.position = spr3.position.linear_interpolate(spr2.position, delta * 4 )




func _on_Timer_timeout():
	spr1.hide()


func _on_Timer2_timeout():
	spr2.hide()


func _on_Timer3_timeout():
	spr3.hide()
