extends CanvasLayer

@onready var continue_button: Button = $VBoxContainer/ContinueButton
@onready var quit_button: Button = $VBoxContainer/QuitButton


func _ready() -> void:
	visible = false
	continue_button.pressed.connect(_on_continue_pressed)
	quit_button.pressed.connect(_on_quit_pressed)


func show_game_over() -> void:
	visible = true
	get_tree().paused = true


func _on_continue_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_quit_pressed() -> void:
	get_tree().paused = false
	get_tree().quit()  # Temporary: later this goes to the main menu.
