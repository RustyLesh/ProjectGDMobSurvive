extends Drop
class_name GearDrop

var gear_resource: GearResource

func _on_body_entered(body):
	if body.is_in_group("player"):
		print("Gear picked up: ", gear_resource._item_name)
		gear_resource.init_gear_drop()
		PlayerSetup.gear_drops.append(gear_resource)
		queue_free()
