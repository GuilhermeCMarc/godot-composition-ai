extends CharacterBody2D
class_name Enemy


@export @onready var velocity_component : VelocityComponent
@export @onready var ai_pathfinding_component: AIPathfindingComponent


func get_player() -> Node2D:
	return get_node("%Player")


func _process(_delta):
	var target = get_player().global_position if get_player() != null else global_position
	ai_pathfinding_component.set_target_position(target)
	ai_pathfinding_component.follow_path()
	velocity_component.move(self)
	look_at(target)
