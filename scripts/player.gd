
extends CharacterBody3D

@export var max_speed: float = 20.0
@export var acceleration: float = 10.0
@export var turn_rate: float = 1.5

signal health_changed(new_health: int)
signal died

@export var max_health: int = 100

var health: int = max_health
var damage_cooldown: float = 0.0

const LASER_SCENE = preload("res://scene/laser.tscn")

var current_speed = 0.0

func _physics_process(delta: float) -> void:
	var steer: float = Input.get_axis("ui_left", "ui_right")
	var pitch: float = Input.get_axis("ui_down", "ui_up")

	rotate_y(steer * turn_rate * delta)
	rotate_object_local(Vector3.RIGHT, pitch * turn_rate * delta)

	current_speed = move_toward(current_speed, max_speed, acceleration * delta)
	velocity = -transform.basis.z * current_speed

	move_and_slide()
	damage_cooldown = max(damage_cooldown - delta, 0.0)
	for i in get_slide_collision_count():
		var collider = get_slide_collision(i).get_collider()
		if collider and collider.is_in_group("obstacle") and damage_cooldown == 0.0:
			take_damage(10)
			damage_cooldown = 1.0

	if Input.is_action_just_pressed("ui_accept"):
		var laser = LASER_SCENE.instantiate()
		get_parent().add_child(laser)
		laser.global_transform = $LaserSpawn.global_transform
		
func take_damage(amount: int) -> void:
	health = max(health - amount, 0)
	health_changed.emit(health)
	if health == 0:
		died.emit()
