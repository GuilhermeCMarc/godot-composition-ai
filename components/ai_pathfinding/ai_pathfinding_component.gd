extends Node2D
class_name AIPathfindingComponent


@export @onready var velocity_component : VelocityComponent

@onready var navigation_agent : NavigationAgent2D = $"NavigationAgent2D"
@onready var interval_timer : Timer = $"IntervalTimer"

@export var max_range := 800
@export var visibility_area : Area2D


func _ready():
    # visibility_area.connect("on_area", self.in_range)
    navigation_agent.connect("velocity_computed", self.on_velocity_computed)


func set_target_position(target_position: Vector2) -> void:
    navigation_agent.target_location = target_position


func force_set_target_position(target_position: Vector2) -> void:
    navigation_agent.target_location = target_position
    interval_timer.call("start")


func follow_path() -> void:
    if navigation_agent.is_navigation_finished():
        velocity_component.decelerate()
        return
    
    var direction = (navigation_agent.get_next_location() - global_position).normalized()
    velocity_component.accelerate_in_direction(direction)
    navigation_agent.set_velocity(velocity_component.get_current_velocity())


func on_velocity_computed(velocity: Vector2) -> void:
     var new_direction = velocity.normalized()
     var current_direction = velocity_component.get_current_velocity().normalized()
     var halfway = new_direction.lerp(current_direction, velocity_component.get_acceleration() * get_physics_process_delta_time())
     velocity_component.set_velocity(halfway * velocity_component.get_current_velocity())