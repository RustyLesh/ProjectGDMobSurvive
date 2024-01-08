extends Control
class_name UpgradeManageMenu

@onready var upgrade_pool_ui = $"Upgrade Pool List"
@onready var selected_upgrade_list_ui = $"Selected Upgrade List"

@export var upgrade_pool: Array[UpgradeResource]
@export var selected_upgrades: Array[UpgradeResource]

func _ready():
    pass

func on_combat_start():
    PlayerSetup.upgrade_pool = selected_upgrades.duplicate()

func remove_upgrade_by_slot_type(gear_type: GearResource.GearType):
    var remove_pool: Array[UpgradeResource]
    for upgrade_resource in selected_upgrades:
        if gear_type == upgrade_resource.source_type:
            remove_pool.append(upgrade_resource)
    
    for upgrade_resource in remove_pool:
        upgrade_pool.erase(upgrade_resource)
        selected_upgrades.erase(upgrade_resource)