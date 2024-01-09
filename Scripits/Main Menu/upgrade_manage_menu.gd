extends Control
class_name UpgradeManageMenu

@onready var upgrade_pool_ui = $"Upgrade Pool Container/Upgrade Pool List"
@onready var selected_upgrade_list_ui = $"Selected Upgrade Container/Selected Upgrade List"

@onready var add_button = $"Add Button"
@onready var remove_button = $"Remove Button"
@onready var main_menu = $"../"
@export var upgrade_pool: Array[UpgradeResource]
@export var selected_upgrades: Array[UpgradeResource]

var highlighted_in_upgrade_pool : int = -1
var highlighted_in_selected_upgrades : int = -1

func _ready():
	add_button.disabled = true
	remove_button.disabled = true
	main_menu.on_start_combat.connect(on_combat_start)

func on_combat_start():
	print("Upgrade menu combat start")
	PlayerSetup.upgrade_pool = selected_upgrades.duplicate()

func remove_upgrade_by_slot_type(gear_type: GearResource.GearType):
	var remove_pool: Array[UpgradeResource]
	for upgrade_resource in selected_upgrades:
		if gear_type == upgrade_resource.source_type:
			remove_pool.append(upgrade_resource)
	
	for upgrade_resource in remove_pool:
		upgrade_pool.erase(upgrade_resource)
		selected_upgrades.erase(upgrade_resource)
	
	update_ui()

func update_ui():
	upgrade_pool_ui.clear()
	selected_upgrade_list_ui.clear()
	for upgrade in upgrade_pool:
		upgrade_pool_ui.add_item(upgrade._name, upgrade._icon)
	
	for upgrade in selected_upgrades:
		selected_upgrade_list_ui.add_item(upgrade._name, upgrade._icon)

func select_upgrade():
	if highlighted_in_upgrade_pool >= 0:
		selected_upgrades.append(upgrade_pool[highlighted_in_upgrade_pool])
		upgrade_pool.pop_at(highlighted_in_upgrade_pool)
		add_button.disabled = true
	update_ui()

func remove_upgrade():
	if highlighted_in_selected_upgrades >= 0:
		upgrade_pool.append(selected_upgrades[highlighted_in_selected_upgrades])
		selected_upgrades.pop_at(highlighted_in_selected_upgrades)
		remove_button.disabled = true

	update_ui()

func on_upgrade_pool_item_selected(index):
	highlighted_in_upgrade_pool = index;
	selected_upgrade_list_ui.deselect_all()
	highlighted_in_selected_upgrades = -1
	remove_button.disabled = true
	add_button.disabled = false

func on_selected_upgrades_item_selected(index):
	highlighted_in_selected_upgrades = index;
	upgrade_pool_ui.deselect_all()
	highlighted_in_upgrade_pool = -1
	remove_button.disabled = false
	add_button.disabled = true

func remove_upgrades_by_source(slot_type: GearResource.GearType):
	#Remove from upgrade_pool
	var remove_pool: Array[UpgradeResource]
	for upgrade in upgrade_pool:
		if upgrade.source_type == slot_type:
			remove_pool.append(upgrade)
	
	for upgrade in remove_pool:
		upgrade_pool.erase(upgrade)
	
	#Remove from selected upgrades pool	
	remove_pool.clear()
	for upgrade in selected_upgrades:
		if upgrade.source_type == slot_type:
			remove_pool.append(upgrade)
	
	for upgrade in remove_pool:
		selected_upgrades.erase(upgrade)
