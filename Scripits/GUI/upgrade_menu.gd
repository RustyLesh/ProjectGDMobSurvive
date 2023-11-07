extends Control
class_name UpgradeMenu

var upgrade_option_resources : Array[UpgradeResource]
var upgrade_option_ui : Array[UpgradeOption]
@onready var upgrade_option_button: Resource = preload("res://Objects/GUI/upgrade_option.tscn")
@onready var upgrade_manager: UpgradeManager = get_parent().get_parent().get_node("Upgrade Manager")

@onready var upgrade_options_container = $"Upgrade Options Panel/Upgrade Options"
@onready var description_panel : UpgradeDescriptionPanel = $"Description Panel"
@onready var confirm_button: Button = $Confirm
var selected_option: int = 0
var selected_resource: UpgradeResource

func _ready():
	await get_tree().create_timer(0.01).timeout
	
	upgrade_option_resources = upgrade_manager.upgrade_pool
	update_upgrade_options()
	upgrade_manager.on_reroll.connect(update_upgrade_options)
	
func _on_confirm_pressed():
	upgrade_manager.select_upgrade(selected_option)
	update_upgrade_options()
	selected_option = 0

func update_upgrade_options():
	selected_option = 0
	confirm_button.disabled = true
	description_panel.clear_info()
	
	if upgrade_option_resources.size() == 0:
		for upgrade in upgrade_option_ui:
			upgrade.queue_free()
		return
	
	while upgrade_manager.number_of_choices > upgrade_option_ui.size(): #if there is not enough buttons for options, create more
		var upgrade_button_scene = load(str(upgrade_option_button.resource_path))
		var upgrade_button_instance = upgrade_button_scene.instantiate()
		upgrade_option_ui.append(upgrade_button_instance)
		upgrade_options_container.add_child(upgrade_button_instance)
		upgrade_button_instance.on_option_selected.connect(highlight_upgrade)
		
	if upgrade_option_ui.size() > upgrade_option_resources.size(): #if there are to many buttons, delete them
		var upgradeOption = upgrade_option_ui.pop_back()
		if upgradeOption is UpgradeOption:
			upgradeOption.queue_free()
	
	for upgrade_option in upgrade_option_ui:
		if upgrade_option is UpgradeOption:
			upgrade_option.init_button(upgrade_option_ui.find(upgrade_option) + 1, upgrade_manager.get_upgrade(upgrade_option_ui.find(upgrade_option) + 1))

func highlight_upgrade(option_no: int):
	selected_resource = upgrade_manager.get_upgrade(option_no)
	description_panel.update_ui(selected_resource)
	selected_option = option_no
	confirm_button.disabled = false

func _on_reroll_pressed():
	upgrade_manager.roll_upgrade_options()
