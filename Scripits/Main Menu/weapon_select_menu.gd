extends Control

@onready var vbox: VBoxContainer = $VBoxContainer
@onready var selected_weapon_infobox: WeaponSelectInfo = $"Selected Weapon"

var select_weapon_button: Resource = preload("res://Objects/Main Menu/weapon_slot.tscn")

@export var weapons: Array[WeaponResource]

func _ready():
	for i in weapons.size():
		var weapon_button_scene = load(str(select_weapon_button.resource_path))
		var weapon_button_instace = weapon_button_scene.instantiate()
		if vbox is VBoxContainer:
			vbox.add_child(weapon_button_instace)
		if weapon_button_instace is WeaponSelectButton:
			weapon_button_instace.weapon = weapons[i]
			weapon_button_instace.on_weapon_select.connect(selected_weapon_infobox._on_weapon_select)
			weapon_button_instace.icon = weapons[i].icon
			weapon_button_instace.text = weapons[i].weapon_name
	selected_weapon_infobox._on_weapon_select(weapons[0]) 
