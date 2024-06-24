extends CanvasLayer
class_name MenuManager
#Manages menus in combat

@onready var upgrade_menu: Control = $"Uprade Menu"
@onready var end_screen = $"End Screen/End Screen"
@onready var boss_hp_bar_poss = $"HUD/Boss HP Bar Pos" 
@onready var spawn_manager = get_parent().get_node("EnemySpawner")
@onready var stage_timer = $"HUD/Timer"
@onready var seconds_timer = $"HUD/Seconds Timer"
@onready var upgrade_manager = $"../Upgrade Manager"
@onready var upgrade_menu_toggle: UpgradeMenuButton = $"HUD/CanvasLayer/Upgrade Menu Button"

#GUI Options
@onready var touch_joysticks = $"TouchSticks/Test/Sticks"
@onready var touch_divider = $"TouchSticks/Test/Sticks/Seperator"

var is_player_dead: bool = false

var hp_bar_instance
var touch_mode:= true

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	upgrade_menu.visible = false
	end_screen.visible = false
	spawn_manager.stage_win.connect(end_screen.on_stage_win)

	await get_tree().create_timer(0.01).timeout
	upgrade_manager.current_upgrade_points_changed.connect(update_upgrade_menu_toggle_button)
	upgrade_menu_toggle.toggle_icon(false)

	#Gui options 
	touch_joysticks.visible = ConfigManager.show_touch_joy_stick
	touch_divider.visible = ConfigManager.show_touch_divider
	touch_joysticks.set_opacity(ConfigManager.trouch_controls_opacity / 100)
	InputManager.on_controller_input.connect(on_controller_input)

	if InputManager.controller_was_used_last:
		toggle_touch_mode(false)

func _input(event):
	if event.is_action_pressed("open_upgrade_menu"):
		toggle_upgrade_menu()

func _on_button_pressed():
	toggle_upgrade_menu()

func toggle_upgrade_menu():
	if touch_mode:
		toggle_touch_sticks()

	upgrade_menu.visible = !upgrade_menu.visible
	get_tree().paused = upgrade_menu.visible
	if upgrade_menu.visible:
		upgrade_menu.on_upgrade_menu_opened()

func on_boss_spawn(enemy_spawn_data: SpawnDataResource):
	hp_bar_instance = enemy_spawn_data.hp_bar_texture_resource.instantiate()
	#TODO: Set hp value number value here
	hp_bar_instance.global_position = boss_hp_bar_poss.global_position
	add_child(hp_bar_instance)

func on_boss_death():
	hp_bar_instance.queue_free()

func on_boss_current_health_changed(value):
	hp_bar_instance.value = value / 100

func update_upgrade_menu_toggle_button(current_upgrade_points):
	if current_upgrade_points <= 0:
		upgrade_menu_toggle.toggle_icon(false)
	else:
		upgrade_menu_toggle.toggle_icon(true)

func toggle_touch_sticks():
	touch_joysticks.visible = !touch_joysticks.visible
	touch_divider.visible = !touch_divider.visible
	print("touch toggle")

func toggle_touch_mode(value: bool):
	touch_mode = value

	touch_joysticks.visible = value
	touch_divider.visible = value

func on_controller_input():
	toggle_touch_mode(false)