extends Node

@export var helmet: Gear
@export var ring: Gear
@export var amulet: Gear

@export var gear: Array[Gear]

@export var is_dirty: bool

func _ready():
	gear.append(helmet)
	gear.append(ring)
	gear.append(amulet)

func equip(equipment: Gear):
	match equipment.GearType:
		Gear.GearType.HELMET:
			helmet = equipment
		
		Gear.GearType.RING:
			ring = equipment
			
		Gear.GearType.AMULET:
			amulet = equipment
