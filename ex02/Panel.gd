# name: Jonas Gann
# coauthor-list: Timo Ege

extends Panel

const STATES = {"BED":0, "HOME":1, "WORK":2}
var state = STATES.WORK

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var label = $Label
	label.text = STATES.keys()[state]
	if state == STATES.WORK:
		if Input.is_action_pressed("home"):
			state = STATES.HOME
	elif state == STATES.HOME:
		if Input.is_action_pressed("bed"):
			state = STATES.BED
		elif Input.is_action_pressed("work"):
			state = STATES.WORK
	elif state == STATES.BED:
		if Input.is_action_pressed("home"):
			state = STATES.HOME
	update()
	
func _draw():
	if state == STATES.WORK:
		self.self_modulate = Color(100,0,0)
	elif state == STATES.HOME:
		self.self_modulate = Color(0,100,0)
	elif state == STATES.BED:
		self.self_modulate = Color(0,0,100)
	

