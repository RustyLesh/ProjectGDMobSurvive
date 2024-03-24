extends Resource
class_name GearModifier
#Mods that gear holds which is applied to player on equip

enum GearModType
{
	APPLY_NOW,
	ADD_TO_COMBAT_POOL
}

func _init():
	upgrade_resource = UpgradeResource.new()

@export var mod_type: GearModType
@export var upgrade_resource: UpgradeResource
@export var slot_source: GearResource.GearType
@export var forced_upgrade: bool

func init_gear_modifier(_mod_type: GearModType, _upgrade_resource: UpgradeResource, _slot_source: GearResource.GearType):
	mod_type = _mod_type
	upgrade_resource = _upgrade_resource
	slot_source = _slot_source

func set_source_type(gear_type):
	slot_source = gear_type
	upgrade_resource.source_type = gear_type
	upgrade_resource.upgrade.source_type = gear_type

func get_save_data() -> Dictionary:
	return {
		"mod_type": mod_type,
		"upgrade_resource": upgrade_resource.get_save_data(),
		"slot_source": slot_source,
		"forced_upgrade": forced_upgrade
	}

func set_resource_data(data_dict):
	slot_source = data_dict["slot_source"]
	mod_type = data_dict["mod_type"]
	forced_upgrade = data_dict["forced_upgrade"]
	upgrade_resource = UpgradeResource.new()
	upgrade_resource.set_resource_data(data_dict["upgrade_resource"])

func init_gear_mod(slot: GearResource.GearType):
	slot_source = slot

func get_upgrade_name():
	return upgrade_resource._name
