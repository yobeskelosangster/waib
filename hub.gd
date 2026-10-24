extends CanvasLayer

@onready var health_bar: ProgressBar = $HealthBar


func set_health(value: int) -> void:
	health_bar.value = value
