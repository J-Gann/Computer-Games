# name: Timo Ege
# coauthor list: Jonas Gann
extends Panel

func _ready():
	pass # Replace with function body.


func _on_RightWall_area_entered(area):
	if area.name == "Ball":
		var count = int(get_node("Label2").text) + 1
		get_node("Label2").text = String(count) 


func _on_LeftWall_area_entered(area):
	if area.name == "Ball":
		var count = int(get_node("Label4").text) + 1
		get_node("Label4").text = String(count) 
