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

signal on_equiped_gear_selected()

func _ready():
	#init gear slots
	helmet_slot.init_gear_slot(GearResource.GearType.HELMET)
	ring_slot.init_gear_slot(GearResource.GearType.RING)
	amulet_slot.init_gear_slot(GearResource.GearType.AMULET)
	slots.append(helmet_slot)
	slots.append(ring_slot)
	slots.append(amulet_slot)
	
	#connect signals
	main_menu.on_start_combat.connect(on_start_combat)
	for slot in slots:
		slot.on_gear_selected.connect(on_gear_selected)
		slot.on_gear_slot_clicked.connect(on_gear_slot_selected)
		slot.on_empty_slot_selected.connect(on_empty_gear_slot_selected)
	
	if !PlayerSetup.equiped_gear.is_empty():
		for gear in PlayerSetup.equiped_gear:
			equip_gear(gear)

func on_start_combat():
	PlayerSetup.equiped_gear.clear()
	PlayerSetup.equiped_gear.append_array(get_all_gear())

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save_data()

func save_data():
	PlayerSetup.equiped_gear.clear()
	PlayerSetup.equiped_gear.append_array(get_all_gear())

func equip_gear(gear: GearResource) -> GearResource:
	var return_gear
	match gear._gear_type: 
		GearResource.GearType.HELMET:
			return_gear = helmet_slot.equiped_gear
			helmet_slot.equip_gear(gear)
		
		GearResource.GearType.AMULET:
			return_gear = amulet_slot.equiped_gear
			amulet_slot.equip_gear(gear)
		
		GearResource.GearType.RING:
			return_gear = ring_slot.equiped_gear
			ring_slot.equip_gear(gear)
	return return_gear

func on_gear_selected(gear: GearResource):
	item_info_panel.on_item_select(gear)
	on_equiped_gear_selected.emit()

func on_empty_gear_slot_selected():
	item_info_panel.clear_info()

func on_gear_slot_selected(gear_type: GearResource.GearType):
	gear_menu.filter_by_type(gear_type)
	if main_menu.current_menu != MainMenu.MenuType.GEAR:
		main_menu.change_menu(MainMenu.MenuType.GEAR)

func get_gear_in_slot(gear_type : GearResource.GearType) -> GearResource:
	var return_gear
	match gear_type:
		GearResource.GearType.HELMET:
			return_gear = helmet_slot.equiped_gear
		
		GearResource.GearType.AMULET:
			return_gear = amulet_slot.equiped_gear
		
		GearResource.GearType.RING:
			return_gear = ring_slot.equiped_gear
			
	return return_gear

func get_all_gear() -> Array[GearResource]:
	var equipped_gear: Array[GearResource] 

	if helmet_slot.equiped_gear != null:
		equipped_gear.append(helmet_slot.equiped_gear)
	if amulet_slot.equiped_gear != null:
		equipped_gear.append(amulet_slot.equiped_gear)
	if ring_slot.equiped_gear != null:
		equipped_gear.append(ring_slot.equiped_gear)
		
	return equipped_gear
