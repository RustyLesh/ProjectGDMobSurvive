class_name SpawnDataPlugin extends EditorInspectorPlugin

func _can_handle(object):
    return object is SpawnDataResource

func _parse_begin(object):
    var label: Label = Label.new()
    label.set_text("Example")
    add_custom_control(label)
