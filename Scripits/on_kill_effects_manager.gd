class_name OnKillEffectsManager extends Node

@export var on_kill_effects: Array[OnKillEffect]

func _on_entity_killed(entity: Entity):
    print("kill signal recieved")
    for effect in on_kill_effects:
        effect.trigger_effect(entity)