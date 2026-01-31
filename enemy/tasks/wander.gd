@tool
extends BTAction

# Task parameters.
@export var wander_radius: float = 10.0
@export var movement_speed: float = 2.0

func _generate_name() -> String:
	return "WanderRandomly"

func _setup() -> void:
	# Nothing to setup for wandering
	pass


# Called when the task is entered.
func _enter() -> void:
	pass


# Called when the task is exited.
func _exit() -> void:
	pass


# Called each time this task is ticked (aka executed).
func _tick(delta: float) -> Status:
	var blackboard: Blackboard = get_blackboard()
	var enemy = get_agent() as CharacterBody3D
	
	if not enemy or not blackboard:
		return FAILURE
	
	# Generate random position around current position
	var current_pos = enemy.global_position
	var random_offset = Vector3(
		randf_range(-wander_radius, wander_radius),
		0,
		randf_range(-wander_radius, wander_radius)
	)

	blackboard.set_var("target_global_position", current_pos + random_offset)
	
	return SUCCESS
