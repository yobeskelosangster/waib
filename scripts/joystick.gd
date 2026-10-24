
# Virtual joystick. Maps touch drag to the ui_* input actions.

extends TextureRect

var dragging_finger: int = -1
var joystick_radius: float = 150.0

@onready var knob: TextureRect = $JoystickKnob


func _ready() -> void:
	joystick_radius = size.x / 2.0
	knob.position = (size - knob.size) / 2.0
	


func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed and get_global_rect().has_point(event.position):
			dragging_finger = event.index

		elif not event.pressed and event.index == dragging_finger:
			dragging_finger = -1
			knob.position = (size - knob.size) / 2.0

			for action in ["ui_left", "ui_right", "ui_up", "ui_down"]:
				Input.action_release(action)

	if event is InputEventScreenDrag and event.index == dragging_finger:
		var centre: Vector2 = global_position + size / 2.0
		var value: Vector2 = (
			(event.position - centre) / joystick_radius
		).limit_length(1.0)

		# Ignore tiny movements to prevent unwanted steering.
		if absf(value.x) < 0.1:
			value.x = 0.0

		if absf(value.y) < 0.1:
			value.y = 0.0

		# Move the joystick knob.
		knob.position = (size - knob.size) / 2.0 + value * joystick_radius

		# Handle horizontal steering.
		if value.x > 0.0:
			Input.action_release("ui_left")
			Input.action_press("ui_right", value.x)
		elif value.x < 0.0:
			Input.action_release("ui_right")
			Input.action_press("ui_left", absf(value.x))
		else:
			Input.action_release("ui_left")
			Input.action_release("ui_right")

		# Handle vertical steering.
		if value.y > 0.0:
			Input.action_release("ui_up")
			Input.action_press("ui_down", value.y)
		elif value.y < 0.0:
			Input.action_release("ui_down")
			Input.action_press("ui_up", absf(value.y))
		else:
			Input.action_release("ui_up")
			Input.action_release("ui_down")
