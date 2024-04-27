class_name UpgradeMenuButton extends TouchScreenButton

@export var default_icon: Texture2D
@export var dim_icon: Texture2D

func toggle_icon(toggle_on: bool):
    if toggle_on:
        texture_normal = default_icon
    else:
        texture_normal = dim_icon