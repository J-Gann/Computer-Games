# author: Jonas Gann
extends Node2D

var runSpeed = 500
var yellow
var orange
var red
var blue
var pink

var orange_rect

var rng = RandomNumberGenerator.new()

func randomize_vertices(triangle):
	rng.randomize()

	triangle.polygon[0][0] = rng.randi_range(0, 500)
	triangle.polygon[0][1] = rng.randi_range(0, 500)
	
	triangle.polygon[1][0] = rng.randi_range(0, 500)
	triangle.polygon[1][1] = rng.randi_range(0, 500)
	
	triangle.polygon[2][0] = rng.randi_range(0, 500)
	triangle.polygon[2][1] = rng.randi_range(0, 500)

	
# Called when the node enters the scene tree for the first time.
func _ready():
	yellow = get_node("Yellow")
	orange = get_node("Orange")
	red = get_node("Red")
	blue = get_node("Blue")
	pink = get_node("Pink")
	randomize_vertices(yellow)
	randomize_vertices(orange)
	randomize_vertices(red)
	randomize_vertices(blue)
	randomize_vertices(pink)
	yellow.color = Color(1, 1, 1, 0)
	orange.color = Color(1, 1, 1, 0)
	red.color = Color(1, 1, 1, 0)
	blue.color = Color(1, 1, 1, 0)
	pink.color = Color(1, 1, 1, 0)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	


func _on_Button_pressed():
	randomize_vertices(yellow)
	randomize_vertices(orange)
	randomize_vertices(red)
	randomize_vertices(blue)
	randomize_vertices(pink)
	yellow.color = Color(1, 1, 1, 0)
	orange.color = Color(1, 1, 1, 0)
	red.color = Color(1, 1, 1, 0)
	blue.color = Color(1, 1, 1, 0)
	pink.color = Color(1, 1, 1, 0)


func aabb(triangle):
	var pol = triangle.get_polygon()
	var min_x = INF
	var max_x = 0
	var min_y = INF
	var max_y = 0
	
	for i in range(3):
		var x = pol[i][0]
		if min_x > x: min_x = x
		if max_x < x: max_x = x
		
		var y = pol[i][1]
		if min_y > y: min_y = y
		if max_y < y: max_y = y
	
	
	return [[min_x, min_y], [max_x, max_y]]
	
# true if collision
func drc(ABB1, ABB2):
	
	var min_x_1 = ABB1[0][0]
	var min_y_1 = ABB1[0][1]
	var max_x_1 = ABB1[1][0]
	var max_y_1 = ABB1[1][1]
	
	var min_x_2 = ABB2[0][0]
	var min_y_2 = ABB2[0][1]
	var max_x_2 = ABB2[1][0]
	var max_y_2 = ABB2[1][1]
	
	# do x overlap?
	var x_overlap1 = (min_x_1 > min_x_2 and min_x_1 < max_x_2) or (max_x_1 > min_x_2 and max_x_1 < max_x_2)
	var x_overlap2 = (min_x_2 > min_x_1 and min_x_2 < max_x_1) or (max_x_2 > min_x_1 and max_x_2 < max_x_1)
	
	var x_overlap = x_overlap1 or x_overlap2
	
	# do y overlap?
	var y_overlap1 = (min_y_1 > min_y_2 and min_y_1 < max_y_2) or (max_y_1 > min_y_2 and max_y_1 < max_y_2)
	var y_overlap2 = (min_y_2 > min_y_1 and min_y_2 < max_y_1) or (max_y_2 > min_y_1 and max_y_2 < max_y_1)
	
	var y_overlap = y_overlap1 or y_overlap2
	
	var res = x_overlap and y_overlap
	
	print(ABB1, ABB2, res)
	
	return res


func _on_ButtonOrange_button_up():
	var AABB_orange = aabb(orange)	
	var AABB_yellow = aabb(yellow)
	var AABB_red = aabb(red)
	var AABB_blue = aabb(blue)
	var AABB_pink = aabb(pink)
	
	if drc(AABB_orange, AABB_yellow): yellow.color = Color(0, 0, 0, 1)
	if drc(AABB_orange, AABB_red): red.color = Color(0, 0, 0, 1)
	if drc(AABB_orange, AABB_blue): blue.color = Color(0, 0, 0, 1)
	if drc(AABB_orange, AABB_pink): pink.color = Color(0, 0, 0, 1)

	# TODO: USED ONLY LOCAL COORDINATES OF POLYGONS, USE GLOBAL SPACE INSTEAD BY ADDING OFFSET
