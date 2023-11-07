extends Stat
class_name BaseStat

enum BaseStatType
{
	MAX_LIFE,
	DAMAGE,
	FIRE_RATE,
	MOVEMENT_SPEED,
	PROJ_COUNT, #Extra pojectiles 
	BULLET_LIFE_TIME,
	COUNT
}

@export var base_type: BaseStatType
