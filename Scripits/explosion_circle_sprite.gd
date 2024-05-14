class_name ExplosionCircleSrpite extends Sprite2D

const UNIT_SIZE = 0.015 #Units per scale increase in transform

## Set size based on units
func set_size(units: int):
    var scaler = UNIT_SIZE * units
    scale = Vector2(scaler, scaler)