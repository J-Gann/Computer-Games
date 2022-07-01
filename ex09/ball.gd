extends Sprite

var waypoints = []
var waypoints_derivatives = [Vector2(2, 0), Vector2(1, 2), Vector2(2, 1), Vector2(1, -2), Vector2(2, 0)]
var speed = 100
var current_segment_length = 0
var k = 0
var total_distance = 0
var spline = true
var movement_speed = 200
# Called when the node enters the scene tree for the first time.
func _ready():
	var p1 = get_node("../sphere1").position
	var p2 = get_node("../sphere2").position
	var p3 = get_node("../sphere3").position
	var p4 = get_node("../sphere4").position
	var p5 = get_node("../sphere5").position
	waypoints = [p1, p2, p3, p4, p5]


func _hermite_spline(p0, p1, d0, d1, t):
	d0 = d0 * speed
	d1 = d1 * speed
	var h00 = 2 * pow(t, 3) - 3 * pow(t, 2) + 1
	var h10 = -2 * pow(t, 3) + 3 * pow(t, 2)
	var h01 = pow(t, 3) - 2 * pow(t, 2) + t
	var h11 = pow(t, 3) - pow(t, 2)
	return h00 * p0 + h10 * p1 + h01 * d0 + h11 * d1

func _catmull_rom_spline(k):
	var Tk = 0.5
	if k == 0 or k == 4: return Vector2(10, 0)
	var res = Tk * (waypoints[k+1] - waypoints[k-1])
	res = Vector2(fmod(res[0], 10), fmod(res[1], 10))
	return res

func _arc_length_point(k):
	var length = 0
	for idx in k+1:
		length += sqrt(pow(waypoints[idx][0] - waypoints[idx-1][0], 2) + pow(waypoints[idx][1] - waypoints[idx-1][1], 2))
	return length

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var total_segment_length = _arc_length_point(k+1) - _arc_length_point(k)	
	current_segment_length += delta * movement_speed
	var next_time_frac = min((current_segment_length) / total_segment_length, 1)

	if spline:
		position = _hermite_spline(waypoints[k], waypoints[k+1], waypoints_derivatives[k], waypoints_derivatives[k+1], next_time_frac)
	else:
		var d0 = _catmull_rom_spline(k)
		var d1 = _catmull_rom_spline(k+1)
		position = _hermite_spline(waypoints[k], waypoints[k+1], d0, d1, next_time_frac)
	
	var arc = get_node("../arc")
	arc.text = "Distance: " + String(total_distance + current_segment_length)
	
	if next_time_frac == 1:
		total_distance += current_segment_length
		k += 1
		current_segment_length = 0
		if k == 4:
			k = 0
			total_distance = 0

# Why is ball moving fast in the beginning? For arc length computation I approximated the arc
# to be piecewise linear in between points. => As this is a bad approximation between the first
# two points, the ball moves faster.


func _on_Button_pressed():
	spline = !spline
	var spline_label = get_node("../spline")
	if spline:
		spline_label.text = "Hermit"
	else:
		spline_label.text = "Catmull"


func _on_HSlider_value_changed(value):
	speed = value
	var speed_label = get_node("../speed")
	speed_label.text = String(speed)


func _on_HSlider2_value_changed(value):
	movement_speed = value
	var speed_label = get_node("../movement_speed")
	speed_label.text = String(movement_speed)
