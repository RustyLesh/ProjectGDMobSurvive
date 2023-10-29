extends Stat
class_name BaseStat

enum BaseStatType
{
	MAX_LIFE,
	DAMAGE,
	FIRE_RATE,
	MOVEMENT_SPEED,
	COUNT
}

@export var base_type: BaseStatType
