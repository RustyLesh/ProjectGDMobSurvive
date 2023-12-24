extends Node
class_name SaveManager
# Go through everything in the Saveable category and ask them to return a
# dict of relevant variables.
		

func _ready():
	await get_tree().create_timer(1).timeout
	
		#Check if game has loaded since launch
	if GameData.has_first_load == false:
		load_game()
		GameData.has_first_load = true
	else:
		save_game()
	


func save_game():
	print("Saving")
	var save_game_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Saveable")
	for node in save_nodes:
	# Check the node is an instanced scene so it can be instanced again during load.
		if node.scene_file_path.is_empty():
			print("Saveable node '%s' is not an instanced scene, skipped" % node.name)
			continue
		
		# Check the node has a save function.
		if !node.has_method("save"):
			print("Saveable node '%s' is missing a save() function, skipped" % node.name)
			continue
			
		var node_data = node.call("save")
		
		var json_string = JSON.stringify(node_data)
		
		# Store the save dictionary as a new line in the save file.
		save_game_file.store_line(json_string)

func load_game():
	print("Loading")
	if not FileAccess.file_exists("user://savegame.save"):
		return # Error! We don't have a save to load.

	# We need to revert the game state so we're not cloning objects
	# during loading. This will vary wildly depending on the needs of a
	# project, so take care with this step.
	# For our example, we will accomplish this by deleting saveable objects.
	var save_nodes = get_tree().get_nodes_in_group("Saveable")
		
	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	var save_game_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	while save_game_file.get_position() < save_game_file.get_length():
		var json_string = save_game_file.get_line()

		# Creates the helper class to interact with JSON
		var json = JSON.new()

		# Check if there is any error while parsing the JSON string, skip in case of failure
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue

		# Get the data from the JSON object
		var node_data = json.get_data()
		
		for node in save_nodes:
			if !node.name == node_data["node_name"]:
				print("none files: ",node.name , " : ",  node_data["filename"])
				continue
				
			if !node.has_method("load_data"):
				print("Saveable node '%s' is missing a load_data() function, skipped" % node.name)
				continue
			
			node.load_data(node_data)
