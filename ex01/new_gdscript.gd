# name: Jonas Gann
# coauthor list: Timo Ege

extends Panel

var time = 0
var active = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if active:
		time = time + delta
		var my_label = $Label
		my_label.text = String(round(time))

func _on_Button_button_up():
	if active:
		time = 0
		active = 0
	else:
		active = 1

# Why is it important to know the time between two frames in a game?
# The reason is, that computation times for frames can be different
# and time dependant actions in the game like movement have to infer
# their position from the time past since the last frame