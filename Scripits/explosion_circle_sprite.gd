class_name ExplosionCircleSrpite extends Sprite2D

const UNIT_SIZE = 0.015

## Set size based on units
func set_size(units: int):
    var scaler = 0.015 * units
    scale = Vector2(scaler, scaler)