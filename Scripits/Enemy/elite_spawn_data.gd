class_name EliteSpawnDataResource extends SpawnDataResource

@export var outline_colour: Color
@export var scale = 1.2
var outline_material = preload("res://Scripits/Shaders/outline.gdshader")

func spawn_enemy(spawn_position: Vector2, parent):
	#Spawn animation init
	has_spawned = true

	#spawn Enemy
	var enemy_instance = enemy_resource.create_enemy_instance()
	enemy_instance.character_body.scale = Vector2(scale, scale)
	enemy_instance.position = spawn_position
	parent.add_child(enemy_instance)
	enemy_instance.get_sprite().material = ShaderMaterial.new()
	enemy_instance.get_sprite().material.shader = outline_material
	enemy_instance.get_sprite().material.shader.set("shader_param/line_color", Vector4(outline_colour.r, outline_colour.g, outline_colour.b, outline_colour.a))
