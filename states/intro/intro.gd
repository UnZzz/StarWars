extends LimboState

@export var intro_scene_root : IntroScene

## Called once, when state is initialized.
func _setup() -> void:
	pass

## Called when state is entered.
func _enter() -> void:
	intro_scene_root.show()
	pass

## Called when state is exited.
func _exit() -> void:
	intro_scene_root.hide()
	pass

## Called each frame when this state is active.
func _update(delta: float) -> void:
	pass
	
func on_intro_play_finished() -> void:
	dispatch(EVENT_FINISHED)
