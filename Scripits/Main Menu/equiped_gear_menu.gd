extends MarginContainer
class_name EquipedGearMenu

@onready var main_menu: MainMenu = $".."
@onready var gear_menu: GearMenu = $"../Gear Menu"

#Gear Slots
@onready var helmet_slot: GearSlot = $GearUIContainer/Helmet
@onready var ring_slot: GearSlot = $GearUIContainer/Ring
@onready var amulet_slot: GearSlot = $GearUIContainer/Amulet

@onready var slots: Array[GearSlot]

@onready var item_info_panel : SelectedItemInfo = $"../Gear Menu/Item Info"

func _ready():
	helmet_slot.init_gear_slot(Gear.GearType.HELMET)
	ring_slot.init_gear_slot(Gear.GearType.RING)
	amulet_slot.init_gear_slot(Gear.GearType.AMULET)
	slots.append(helmet_slot)
	slots.append(ring_slot)
	slots.append(amulet_slot)
	
	for slot in slots:
		slot.on_gear_selected.connect(on_gear_selected)
		slot.on_gear_slot_clicked.connect(on_gear_slot_selected)
	
func equip_gear(gear: Gear) -> Gear:
	var return_gear
	match gear.gear_type:
		Gear.GearType.HELMET:
			return_gear = helmet_slot.equiped_gear
			helmet_slot.equip_gear(gear)
		
		Gear.GearType.AMULET:
			return_gear = amulet_slot.equiped_gear
			amulet_slot.equip_gear(gear)
		
		Gear.GearType.RING:
			return_gear = ring_slot.equiped_gear
			ring_slot.equip_gear(gear)
			
	return return_gear

func on_gear_selected(gear: Gear):
	item_info_panel.on_item_select(gear)

func on_gear_slot_selected(gear_type: Gear.GearType):
	gear_menu.filter_by_type(gear_type)
	if main_menu.current_menu != MainMenu.MenuType.GEAR:
		main_menu.change_menu(MainMenu.MenuType.GEAR)

func get_gear_in_slot(gear_type : Gear.GearType) -> Gear:
	var return_gear
	match gear_type:
		Gear.GearType.HELMET:
			return_gear = helmet_slot.equiped_gear
		
		Gear.GearType.AMULET:
			return_gear = amulet_slot.equiped_gear
		
		Gear.GearType.RING:
			return_gear = ring_slot.equiped_gear
			
	return return_gear
