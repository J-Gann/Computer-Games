# author: Jonas Gann
extends Polygon2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
export(Color) var OutLine = Color.yellow setget set_color
export(float) var Width = 1.0 setget set_width

func _draw():
	var poly = get_polygon()
	for i in range(1 , poly.size()):
		draw_line(poly[i-1] , poly[i], OutLine , Width)
	draw_line(poly[poly.size() - 1] , poly[0], OutLine , Width)

func set_color(color):
	OutLine = color
	update()

func set_width(new_width):
	Width = new_width
	update()
