class_name EliteSpawnDataResource extends SpawnDataResource

@export var outline_colour: Color
@export var scale = 1.2
var outline_shader = preload("res://Scripits/Shaders/outline.gdshader")

func spawn_enemy(spawn_position: Vector2, parent):
	#Spawn animation init
	has_spawned = true

	#spawn Enemy
	var enemy_instance = enemy_resource.create_enemy_instance()
	enemy_instance.character_body.scale = Vector2(scale, scale)
	enemy_instance.position = spawn_position
	parent.add_child(enemy_instance)
	enemy_instance.get_sprite().material = ShaderMaterial.new()
	enemy_instance.get_sprite().material.resource_local_to_scene = true
	enemy_instance.get_sprite().material.set_shader(outline_shader)
	enemy_instance.get_sprite().material.set_shader_parameter("line_color", Vector4(outline_colour.r, outline_colour.g, outline_colour.b, outline_colour.a))
	enemy_instance.get_sprite().material.set_shader_parameter("flash_color", Vector4(1.0, 0.0, 0.0, 1.0))
