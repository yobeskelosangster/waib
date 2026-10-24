
extends Node3D

@export var speed: float = 80.0

func _ready() -> void:
	# Inspired by the KidsCanCode 3D shooting tutorial.
	await get_tree().create_timer(3.0).timeout
	queue_free()

func _physics_process(delta: float) -> void:
	position += -transform.basis.z * speed * delta
