extends Node
class_name UpgradeInfoPnael

@onready var upgrade_sprite: TextureRect = $Icon
@onready var name_label: Label = $Name
@onready var description_label: Label = $Description
@onready var upgrade_details: RichTextLabel = $"Upgrade Details"

func set_ui(upgrade: UpgradeResource):
	upgrade_sprite.texture = upgrade._icon
	name_label.text = upgrade._name
	description_label.text = upgrade._description
