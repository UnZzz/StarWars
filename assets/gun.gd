extends Node3D

@onready var anim = $AnimationPlayer
@onready var mask_gun = $".."


@onready var particle1: GPUParticles3D = $particle/particlelargflash
@onready var particle2: GPUParticles3D = $particle/particlecone
@onready var particle3: GPUParticles3D = $particle/particleflash

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Input.is_action_pressed("fire")):
		gun_animation()
		play_particles()

func gun_animation():
	anim.stop()
	anim.play("HandAction")

func play_particles():
	particle1.restart()
	particle2.restart()
	particle3.restart()
	particle1.emitting = true
	particle2.emitting = true
	particle3.emitting = true
	
	await get_tree().create_timer(0.2).timeout
	particle1.emitting = false
	particle2.emitting = false
	particle3.emitting = false
