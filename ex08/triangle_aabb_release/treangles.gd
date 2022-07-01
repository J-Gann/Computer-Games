extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var runSpeed = 500
var yellow
var orange
var red
var blue
var green

var rng = RandomNumberGenerator.new()

func randomize_vertices(triangle):
	rng.randomize()
	triangle[0][0] = rng.randi_range(0, 100)
	triangle[0][1] = rng.randi_range(0, 100)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	yellow = get_node("Yellow")
	print(yellow.polygon)
	randomize_vertices(yellow.polygon)
	orange = get_node("Orange")
	red = get_node("Red")
	blue = get_node("Blue")
	green = get_node("Pink")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
#func _input(event):
#	if event is InputEventMouseButton and !yellowPressed:
#		yellow.color = Color.red
#	else:
#		yellow.color = Color.yellow
#		yellowPressed = false


func _on_Yellow_Button_toggled(button_pressed):
	if  button_pressed:
		yellow.color = Color.red
	else:
		yellow.color = Color.yellow
