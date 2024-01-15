extends Control
class_name WeaponSelectMenu
#Menu for selecting player weapon

@onready var vbox: VBoxContainer = $VBoxContainer
@onready var selected_weapon_infobox: WeaponSelectInfo = $"Selected Weapon"

var select_weapon_button: Resource = preload("res://Objects/Main Menu/weapon_slot.tscn")

var weapons: Array[WeaponResource]

func _ready():
	weapons = PlayerSetup.weapon_storage
	await get_tree().create_timer(0.4).timeout
	for i in weapons.size():
		var weapon_button_scene = load(str(select_weapon_button.resource_path))
		var weapon_button_instace = weapon_button_scene.instantiate()
		if vbox is VBoxContainer:
			vbox.add_child(weapon_button_instace)
		#Assign properties to weapon select buttons
		if weapon_button_instace is WeaponSelectButton:
			weapon_button_instace.weapon = weapons[i]
			weapon_button_instace.on_weapon_select.connect(selected_weapon_infobox._on_weapon_select)
			weapon_button_instace.on_weapon_select.connect(on_weapon_select)
			weapon_button_instace.icon = weapons[i].icon
			weapon_button_instace.text = weapons[i].weapon_name
	#selected_weapon_infobox._on_weapon_select(weapons[0]) 
	if PlayerSetup.selected_weapon_index >= 0:
		selected_weapon_infobox._on_weapon_select(weapons[PlayerSetup.selected_weapon_index])

func on_weapon_select(weapon):
	PlayerSetup.selected_weapon_index = weapons.find(weapon)