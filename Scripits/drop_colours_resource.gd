extends Resource
class_name DropColours

@export var common_drop: Color = Color.GRAY
@export var uncommon_drop: Color = Color.BLUE
@export var rare_drop: Color = Color.ORANGE
@export var boss_drop: Color = Color.RED

var colours_array: Array[Color]

func _init():
    colours_array.append(common_drop)
    colours_array.append(uncommon_drop)
    colours_array.append(rare_drop)
    colours_array.append(boss_drop)