extends Node

@onready
var state_machine : LimboHSM = $LimboHSM
@onready
var intro_state : LimboState = $LimboHSM/Intro
@onready
var playing_state : LimboState = $LimboHSM/Playing
@onready
var result_state : LimboState = $LimboHSM/Result

func _ready() -> void:
	_init_state_machine()
	pass
	
func _init_state_machine():
	state_machine.add_transition(intro_state, playing_state, intro_state.EVENT_FINISHED)
	state_machine.add_transition(playing_state, result_state, playing_state.EVENT_FINISHED)
	state_machine.add_transition(result_state, playing_state, result_state.EVENT_FINISHED)
	
	state_machine.initialize(self)
	state_machine.set_active(true)
	AudioManager.bgm_player.play()
	pass
