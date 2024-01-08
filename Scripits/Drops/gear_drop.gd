extends Drop

var gear_resource: GearResource

func _on_body_entered(body):
	print("Body")
	if body.is_in_group("player"):
		gear_resource.init_gear_drop()
		PlayerSetup.gear_drops.append(gear_resource)
		queue_free()
