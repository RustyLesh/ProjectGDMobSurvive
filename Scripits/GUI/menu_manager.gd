extends CanvasLayer
class_name MenuManager
#Manages menus in combat

@onready var upgrade_menu: Control = $"Uprade Menu"
@onready var end_screen = $"End Screen"
@onready var boss_hp_bar_poss = $"HUD/Boss HP Bar Pos" 
var hp_bar_instance

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	upgrade_menu.visible = false
	end_screen.visible = false
	
func _input(event):
	if event.is_action_pressed("open_upgrade_menu"):
		toggle_upgrade_menu()

func _on_button_pressed():
	toggle_upgrade_menu()

func toggle_upgrade_menu():
	upgrade_menu.visible = !upgrade_menu.visible
	get_tree().paused = upgrade_menu.visible

func on_boss_spawn(hp_bar_resource: Resource):
	hp_bar_instance = hp_bar_resource.instantiate()
	hp_bar_instance.global_position = boss_hp_bar_poss.global_position
	add_child(hp_bar_instance)

func on_boss_death():
	hp_bar_instance.queue_free()

func on_boss_current_health_changed(value):
	hp_bar_instance.value = value / 100