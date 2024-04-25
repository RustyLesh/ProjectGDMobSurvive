extends Control
class_name UpgradeMenu
#Shows the player avaliable upgrades, and applies upgrades on selection

var upgrade_option_resources : Array[UpgradeResource]
var upgrade_option_ui : Array[UpgradeOption]
@onready var upgrade_option_button: Resource = preload("res://Objects/GUI/upgrade_option.tscn")
@onready var upgrade_manager: UpgradeManager = get_parent().get_parent().get_node("Upgrade Manager")
@onready var xp_manger: XPManager = $"../../XP Manager"

@onready var upgrade_options_container = $"Upgrade Options Panel/Upgrade Options"
@onready var reroll_button: Button = $Reroll
@onready var reroll_counter: Label = $"Reroll/Reroll Counter"
var selected_option: int = 0
var selected_resource: UpgradeResource

func _ready():
	await get_tree().create_timer(0.01).timeout
	
	upgrade_option_resources = upgrade_manager.upgrade_pool
	update_upgrade_options()
	upgrade_manager.on_reroll.connect(update_upgrade_options)
	upgrade_manager.on_gained_rerolls.connect(update_rerolls)

	xp_manger.on_level.connect(on_upgrade_points_changed)
	update_rerolls()

func on_upgrade_menu_opened():
	upgrade_options_container.get_child(0).grab_focus()

func _on_confirm_pressed():
	upgrade_manager.select_upgrade(selected_option)
	update_upgrade_options()
	selected_option = 0

func update_upgrade_options():
	selected_option = 0
	
	if upgrade_option_resources.size() == 0: #If no upgrades, remove all buttons
		for upgrade in upgrade_option_ui:
			upgrade.queue_free()
		return
	
	while upgrade_manager.number_of_choices > upgrade_option_ui.size(): #if there is not enough buttons for options, create more
		var upgrade_button_scene = load(str(upgrade_option_button.resource_path))
		var upgrade_button_instance = upgrade_button_scene.instantiate()
		upgrade_option_ui.append(upgrade_button_instance)
		upgrade_options_container.add_child(upgrade_button_instance)
		upgrade_button_instance.on_option_selected.connect(select_upgrade)
		
	while upgrade_option_ui.size() > upgrade_option_resources.size(): #if there are to many buttons, delete them
		var upgradeOption = upgrade_option_ui.pop_back()
		if upgradeOption is UpgradeOption:
			upgradeOption.queue_free()
	
	for upgrade_option in upgrade_option_ui: #init buttons, refresh their ui
		if upgrade_option is UpgradeOption:
			upgrade_option.init_button(upgrade_option_ui.find(upgrade_option) + 1, upgrade_manager.get_upgrade(upgrade_option_ui.find(upgrade_option) + 1))
			if upgrade_manager.current_upgrade_points <= 0:
				upgrade_option.disable_button()
			else:
				upgrade_option.enable_button()

func select_upgrade(option_no: int):
	print("upgrade menu selected: ", option_no)
	upgrade_manager.select_upgrade(option_no)

func _on_reroll_pressed():
	upgrade_manager.reroll_points -= 1
	upgrade_manager.roll_upgrade_options()
	update_rerolls()

func update_rerolls():
	if upgrade_manager.reroll_points > 0:
		reroll_button.disabled = false
	else:
		reroll_button.disabled = true
	
	reroll_counter.text = str(upgrade_manager.reroll_points)
	
	update_upgrade_options()

func return_to_main_menu():
	GameData.go_to_main_menu()

func on_add_reroll_points_pressed():
	upgrade_manager.add_reroll_points(1)

func on_upgrade_points_changed(points: int):
	print("points changed: ", points)
	for upgrade_option in upgrade_option_ui: #init buttons, refresh their ui
		if upgrade_option is UpgradeOption:
			if points <= 0:
				upgrade_option.disable_button()
			else:
				upgrade_option.enable_button()

