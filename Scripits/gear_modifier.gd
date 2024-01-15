extends Resource
class_name GearModifier
#Mods that gear holds which is applied to player on equip

enum GearModType
{
	APPLY_NOW,
	ADD_TO_COMBAT_POOL
}

@export var mod_type: GearModType
@export var upgrade_resource: UpgradeResource
@export var slot_source: GearResource.GearType

func get_save_data() -> Dictionary:
	return {
		"mod_type": mod_type,
		"upgrade_resource": upgrade_resource.get_save_data(),
		"slot_source": slot_source,
	}

func set_resource_data(data_dict):
	slot_source = data_dict["slot_source"]
	mod_type = data_dict["mod_type"]
	upgrade_resource = UpgradeResource.new()
	upgrade_resource.set_resource_data(data_dict["upgrade_resource"])
func init_gear_mod(slot: GearResource.GearType):
	slot_source = slot
