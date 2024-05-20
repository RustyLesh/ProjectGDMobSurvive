extends Node2D
class_name Entity
#Base for any scene that can take damage

enum EntityType
{
	GRUNT,
	BOSS,
	PLAYER,
}

@onready var health
@onready var character_body 
@onready var sprite: Sprite2D

@export var entity_type: EntityType
var damage_flash_color: Color = Color("af2222")
var flash_shader = preload("res://flash_color.gdshader")

var is_dead: bool = false

func take_damage(damage):
	if health is Health:
		#Damage logic here
		health.take_damage(damage)

func init_entity():
	health = $Health
	sprite = %Sprite
	character_body = %Body
	if sprite.material == null:
		sprite.material = ShaderMaterial.new()
		sprite.material.shader = flash_shader
		sprite.material.set_shader_parameter("flash_color", Vector4(1.0, 0.0, 0.0, 1.0))
		sprite.material.resource_local_to_scene = true

func get_sprite():
	return %Sprite