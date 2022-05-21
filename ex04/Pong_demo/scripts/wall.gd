# name: Timo Ege
# coauthor list: Jonas Gann
extends Area2D

func _on_wall_area_entered(area):
	if area.name == "Ball":
		var countr = int(get_parent().get_node("Panel/Label2").text) 
		var countl = int(get_parent().get_node("Panel/Label4").text)
		if self.name == "LeftWall":
			countl += 1
			get_parent().get_node("Panel/Label4").text = String(countl)
			
		if self.name == "RightWall":
			countr += 1
			get_parent().get_node("Panel/Label2").text = String(countr) 
		
		if countl == 3:
			get_parent().get_node("Panel/Label5").set_text("Player B wins")
		if countr == 3:
			get_parent().get_node("Panel/Label5").set_text("Player A wins")
		area.reset()
