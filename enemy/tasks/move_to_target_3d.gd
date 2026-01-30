@tool
extends BTAction

# Task parameters.
@export var movement_speed: float = 4.0

## Note: Each method declaration is optional.
## At minimum, you only need to define the "_tick" method.
var _navigation_agent : NavigationAgent3D
var _now_velocity : Vector3

# Called to generate a display name for the task (requires @tool).
func _generate_name() -> String:
	return "MoveToTarget3D"


# Called to initialize the task.
func _setup() -> void:
	var agent_node = blackboard.get_var("navigation_agent_node")
	_navigation_agent = agent_node
	_navigation_agent.velocity_computed.connect(Callable(_on_velocity_computed))
	pass


# Called when the task is entered.
func _enter() -> void:
	pass


# Called when the task is exited.
func _exit() -> void:
	pass


# Called each time this task is ticked (aka executed).
func _tick(delta: float) -> Status:
	var target_global_position : Vector3 = blackboard.get_var("target_global_position")
	_navigation_agent.target_position = target_global_position
	(agent as CharacterBody3D).velocity = _now_velocity
	
	
	# Do not query when the map has never synchronized and is empty.
	if NavigationServer3D.map_get_iteration_id(_navigation_agent.get_navigation_map()) == 0:
		return RUNNING
	if _navigation_agent.is_navigation_finished():
		return SUCCESS

	var next_path_position: Vector3 = _navigation_agent.get_next_path_position()
	var new_velocity: Vector3 = (agent as CharacterBody3D).global_position.direction_to(next_path_position) * movement_speed
	if _navigation_agent.avoidance_enabled:
		_navigation_agent.set_velocity(new_velocity)
	else:
		_on_velocity_computed(new_velocity)
	return RUNNING


# Strings returned from this method are displayed as warnings in the editor.
func _get_configuration_warnings() -> PackedStringArray:
	var warnings := PackedStringArray()
	return warnings
	
func _on_velocity_computed(safe_velocity: Vector3) -> void:
	(agent as CharacterBody3D).velocity = safe_velocity
	return
