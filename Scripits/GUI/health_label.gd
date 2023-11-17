extends Label
class_name HealthLabel

var max_health
var current_health
@onready var health: Health = get_tree().get_first_node_in_group(("player")).get_node("Health")
func _ready():
	await get_tree().create_timer(.1).timeout
	health.max_health_changed.connect(max_health_update)
	health.current_health_changed.connect(current_health_update)
	current_health = health.current_health
	max_health = health.max_health
	update_label()

func current_health_update(value):
	current_health = value
	update_label()

func max_health_update(value):
	max_health = value
	update_label()

func update_label():
	text = str("HP: ", current_health, " / " , max_health)
	
