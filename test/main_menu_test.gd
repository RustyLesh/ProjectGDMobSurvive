extends Node

func _input(event):
	if event.is_action_pressed("shoot"):
		for tree in PlayerSetup.weapon.weapon_tree.level_1:
			print(tree._name)