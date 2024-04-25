class_name ReturnContinuePanel extends Panel
## Panel for the play to return or continue, used for warning the playing and asking if they want to continue

@onready var continue_button: Button = $Continue
@onready var return_button: Button = $Return

signal on_user_choice(bool)

func on_on_continue_pressed():
    on_user_choice.emit(true)

func on_return_pressed():
    on_user_choice.emit(false)