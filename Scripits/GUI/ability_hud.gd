extends Control
class_name AbilityHUD

@onready var h_box_container = $HBoxContainer

@export var number_of_ability_slots := 4
@export var abilities_array: Array[AbilityResource]
@export var ability_button_resource: Resource = preload("res://Objects/GUI/ability_button.tscn")
@export var ability_buttons_array: Array[AbilityButton]

func _ready():
	for i in number_of_ability_slots:
		var ability_button = load(str(ability_button_resource.resource_path))
		var ability_button_instance: AbilityButton  = ability_button.instantiate()
		h_box_container.add_child(ability_button_instance)
		ability_button_instance.init_ability_button(i, abilities_array[i].ability_icon)
		ability_button_instance.on_ability_pressed.connect(on_ability_pressed)
		ability_buttons_array.append(ability_button_instance)

func on_ability_pressed(id: int):
	abilities_array[id].use_ability()

func add_ability(ability: AbilityResource):
	if abilities_array.size() < 4:
		abilities_array.append(ability)

func refresh_ability_ui():
	for id in abilities_array.size():
		ability_buttons_array[id].icon = abilities_array[id].ability_icon
