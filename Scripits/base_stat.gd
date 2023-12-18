extends Stat
class_name BaseStat
#Main stats for player
enum BaseStatType
{
	MAX_LIFE,
	DAMAGE,
	FIRE_RATE,
	MOVEMENT_SPEED,
	PROJ_COUNT, #Extra pojectiles 
	BULLET_LIFE_TIME,
	PIERCE,
	COUNT
}

@export var base_type: BaseStatType

#Returns all stats and values as string
func get_string() -> String:
	return str(value, " ", BaseStatType.keys()[base_type])
