extends Control
class_name GearFilerUI

@onready var equiped_gear_menu: EquipedGearMenu = $"../../Equiped Gear Menu"
@onready var gear_type_filter_label: Label = $gear_type_filter

@export_subgroup("gear_filter")
@export var default_colour: Color
@export var amulet_colour: Color
@export var helmet_colour: Color
@export var ring_colour: Color

func _ready():
	for slot in equiped_gear_menu.slots:
		slot.on_gear_selected.connect(on_filter_gear_type)
		slot.on_gear_slot_clicked.connect(on_filter_gear_type)

func on_filter_gear_type(gear_type:Gear.GearType):
	var new_sb = StyleBoxFlat.new()

	match gear_type:
		Gear.GearType.AMULET:
			new_sb.bg_color = amulet_colour
			gear_type_filter_label.text = "Amulet"
		Gear.GearType.HELMET:
			new_sb.bg_color = helmet_colour
			gear_type_filter_label.text = "Helmet"	
		Gear.GearType.RING:
			new_sb.bg_color = ring_colour
			gear_type_filter_label.text = "Ring"	
			
	gear_type_filter_label.add_theme_stylebox_override("normal", new_sb)
