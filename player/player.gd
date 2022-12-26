extends CharacterBody2D
class_name Player


@export @onready var velocity_component : VelocityComponent


func _process(_delta):
	velocity_component.accelerate_in_direction(get_movement())
	velocity_component.move(self)
	look_at(get_global_mouse_position())


func get_movement() -> Vector2:
	var movement := Vector2.ZERO
	movement.x = Input.get_action_strength("walk_right") - Input.get_action_strength("walk_left")
	movement.y = Input.get_action_strength("walk_down") - Input.get_action_strength("walk_up")
	return movement.normalized()
