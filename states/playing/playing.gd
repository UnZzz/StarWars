extends LimboState

@export var map_manager : MapManager

## Called once, when state is initialized.
func _setup() -> void:
	PlayerManager.player_is_dead.connect(on_player_is_dead)
	pass

## Called when state is entered.
func _enter() -> void:
	map_manager.switch_to(map_manager.init_map)
	pass

## Called when state is exited.
func _exit() -> void:
	pass

## Called each frame when this state is active.
func _update(delta: float) -> void:
	pass
	
func on_player_is_dead() -> void:
	dispatch(EVENT_FINISHED)
