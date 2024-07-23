extends Label
class_name StageTimer

func update_timer(seconds: int):
    text = str((seconds/60), ":", (seconds % 60))
