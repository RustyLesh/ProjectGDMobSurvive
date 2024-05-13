extends EnemyResource
class_name ShellTurretResource

@export_category("Turret Resource")
@export var move_speed: int = 100
@export var contact_damage: int
@export var follow_range: int
@export var keep_following: bool
@export var bullet_resource: BulletResource
@export var bullet_damage: int
@export var bullet_speed: int = 50
##Duration in seconds
@export var bullet_lifetime: int = 1
@export var delay_betweeen_shots: float