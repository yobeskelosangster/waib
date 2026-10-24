extends TextureButton  # change to Button if your orange node is a Button

func _ready() -> void:
	button_down.connect(func(): Input.action_press("ui_accept"))
	button_up.connect(func(): Input.action_release("ui_accept"))
