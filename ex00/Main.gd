"""
name: Jonas Gann
faculty: Informatik
discipline: Data and Computer Science
student number: 3367576
"""

extends Node

export (PackedScene) var Ball

func _input(event):
	if event.is_action_pressed("click"):
		var new_ball = Ball.instance()
		new_ball.position = get_viewport().get_mouse_position()
		add_child(new_ball)
