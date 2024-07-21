extends Node
# Go through everything in the Saveable category and ask them to return a
# dict of relevant variables.

var has_first_load: bool = false
var load_on_start = false

func _ready():
	await get_tree().create_timer(.3).timeout
	
		#Check if game has loaded since launch
	if has_first_load == false and load_on_start:
		has_first_load = true
		load_game()

func save_game():
	print("Saving")
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
				
		var save_data = node.call("save")

		var save_game_file = FileAccess.open(save_data["file_name"], FileAccess.WRITE)
		var json_string = JSON.stringify(save_data["data"])
		# Store the save dictionary as a new line in the save file.
		save_game_file.store_line(json_string)

func load_game():
	print("Loading")
	var save_nodes = get_tree().get_nodes_in_group("Saveable")
	for node in save_nodes:
		if !node.has_method("load_data") :
			print("Saveable node '%s' is missing a load_data() function, skipped" % node.name)
			continue
			
		if !FileAccess.file_exists(node.FILE_NAME):
			print("File: ", node.FILE_NAME, " does not exist. Node: ", node.name, " skipped")
			continue
		node.load_data()

func load_file(file_name):
	if not FileAccess.file_exists(file_name):
		print("File: ", file_name, "does not exist")
		return false# Error! We don't have a save to load.

	var save_game_file = FileAccess.open(file_name, FileAccess.READ)
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
		return json.get_data()