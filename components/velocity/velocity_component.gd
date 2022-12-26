extends Node
class_name VelocityComponent

@export var max_speed := 80
@export var acceleration := 3


func _ready():
	set_process(false) # deactivates process


var vec_velocity := Vector2.ZERO


func get_current_velocity() -> Vector2:
	return vec_velocity


func set_velocity(new_velocity: Vector2) -> void:
	vec_velocity = new_velocity


func get_acceleration() -> int:
	return acceleration


func accelerate_to_velocity(velocity: Vector2) -> void:
	vec_velocity = lerp(vec_velocity, velocity, acceleration * get_physics_process_delta_time())


func accelerate_in_direction(direction: Vector2) -> void:
	accelerate_to_velocity(direction * max_speed)


func decelerate() -> void:
	accelerate_to_velocity(Vector2.ZERO)


func move(body: CharacterBody2D) -> void:
	body.velocity = vec_velocity
	body.move_and_slide()