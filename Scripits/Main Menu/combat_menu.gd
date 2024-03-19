extends Control

@onready var start_button: Button = $Start

func _ready():
     start_button.disabled = true

func on_mission_select():
    start_button.disabled = false