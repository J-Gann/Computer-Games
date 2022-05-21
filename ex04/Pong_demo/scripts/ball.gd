# name: Timo Ege
# coauthor list: Jonas Gann
extends Area2D

const DEFAULT_SPEED = 100

var directions = [Vector2.LEFT,Vector2.RIGHT]
var direction

onready var a = get_parent()
onready var _initial_pos = position
onready var _speed = DEFAULT_SPEED

func _ready():
	direction = directions[randi() % directions.size()]
	pass

func _process(delta):
	var b = int(a.get_node("Panel/Label2").text)
	var c = int(a.get_node("Panel/Label4").text)
	if b < 3 && c < 3:
		_speed += delta * 2
		position += _speed * delta * direction 


func reset():
	direction = directions[randi() % directions.size()]
	position = _initial_pos
	_speed = DEFAULT_SPEED


func _on_Button_button_up():
	a.get_node("Panel/Label2").text = "0"
	a.get_node("Panel/Label4").text = "0"
	a.get_node("Panel/Label5").text = "Match!"
	reset()
