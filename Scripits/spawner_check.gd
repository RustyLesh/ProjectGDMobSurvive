extends Marker2D

var is_on_screen
signal state_changed(on_screen_node, is_on_screen)

func _on_screen_entered():
	is_on_screen = true
	state_changed.emit(self, is_on_screen)


func _on_screen_exited():
	is_on_screen = false
	state_changed.emit(self, is_on_screen)
	
func _ready():
	var check_node = $VisibleOnScreenNotifier2D
	check_node.connect("screen_entered", _on_screen_entered)
	check_node.connect("screen_exited", _on_screen_exited)
