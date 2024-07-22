extends TextureProgressBar

@onready var life_label: Label = $LifeCounter

var max_hp: float

func init_ui(_max_hp: float):
	max_hp = _max_hp
	life_label.text = str(max_hp, "/", max_hp)
	value = 100
	print("init hp bar ui - max hp: ", max_hp)

func update_hp(_value: float):
	value = (_value / max_hp) * 100
	life_label.text = str(_value, "/", max_hp)
	print("update hp bar ui - HP: ", value, " / ", max_hp)
