extends Control
class_name WeaponSelectMenu
#Menu for selecting player weapon

@onready var weapon_list_container: VBoxContainer = $"Weapon Container/VBoxContainer"
@onready var weapon_scroll_container = $"Weapon Container"
@onready var selected_weapon_infobox: WeaponSelectInfo = $"Selected Weapon"
@onready var upgrade_manage_menu: UpgradeManageMenu = $"../Upgrade Menu"

var select_weapon_button: Resource = preload("res://Objects/Main Menu/weapon_slot.tscn")
var weapon_info: Resource = preload("res://Objects/Main Menu/weapon_info.tscn")

var weapon_info_scene
var y_increase_value
var weapons: Array[WeaponResource]
var current_infobox_index: int = -1

func _ready():
	weapon_info_scene = load(str(weapon_info.resource_path))
	weapons = PlayerSetup.weapon_storage
	await get_tree().create_timer(0.4).timeout
	for i in weapons.size():
		var weapon_button_scene = load(str(select_weapon_button.resource_path))
		var weapon_button_instace = weapon_button_scene.instantiate()
		#y_increase_value = weapon_button_instace.size.y
		if weapon_list_container is VBoxContainer:
			weapon_list_container.add_child(weapon_button_instace)
		#Assign properties to weapon select buttons
		if weapon_button_instace is WeaponSelectButton:
			weapon_button_instace.index = i
			weapon_button_instace.custom_minimum_size = Vector2(weapon_scroll_container.size.x, 0)
			weapon_button_instace.weapon = weapons[i]
			weapon_button_instace.icon = weapons[i].icon
			weapon_button_instace.text = weapons[i].weapon_name
			weapon_button_instace.on_weapon_select.connect(on_weapon_select)
			
	#selected_weapon_infobox._on_weapon_select(weapons[0]) 
	if PlayerSetup.selected_weapon_index >= 0: #if weapon is already selected, show info
		selected_weapon_infobox.on_weapon_select(weapons[PlayerSetup.selected_weapon_index], 0)

func on_weapon_select(weapon, index):
	PlayerSetup.selected_weapon_index = weapons.find(weapon)

	#Info box creation
	print("onweapon select")
	if index == current_infobox_index -1:
		weapon_list_container.get_child(current_infobox_index).queue_free()
		current_infobox_index = -1
		return #Clicked on already selected weapon
	if current_infobox_index >= 0:
		weapon_list_container.get_child(current_infobox_index).queue_free()
	var weapon_info_instance = weapon_info_scene.instantiate()
	weapon_list_container.add_child(weapon_info_instance)
	weapon_info_instance.on_equip.connect(equip_weapon)
	weapon_info_instance.init_info_panel(weapon)
	if index >= current_infobox_index && current_infobox_index > -1:
		weapon_list_container.move_child(weapon_info_instance, index + 2)
	else:
		weapon_list_container.move_child(weapon_info_instance, index + 1)
	current_infobox_index = index + 1

	selected_weapon_infobox.on_weapon_select(weapon, index)

func equip_weapon(weapon_resource):
	print("equip func")
	PlayerSetup.weapon = weapon_resource
	upgrade_manage_menu.remove_upgrade_by_slot_type(GearResource.GearType.WEAPON)
	for upgrade in weapon_resource.upgrades:
		upgrade.source_type = GearResource.GearType.WEAPON
		upgrade.upgrade.source_type = GearResource.GearType.WEAPON
		upgrade_manage_menu.upgrade_pool.append(upgrade)
