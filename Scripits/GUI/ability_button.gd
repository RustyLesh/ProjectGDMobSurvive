extends Button
class_name AbilityButton

var button_id: int

signal on_ability_pressed(id: int)

func _ready():
    pressed.connect(on_button_pressed())

func init_ability_button(id: int, ability_icon :Texture2D):
    button_id = id
    icon = ability_icon

func on_button_pressed():
    on_ability_pressed.emit(button_id)