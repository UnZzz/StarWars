extends Node3D

@onready var anim = $AnimationPlayer
@onready var mask_gun = $"../MaskGun"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	gun_animation()
	print(mask_gun._can_fire)

func gun_animation():
	if(Input.is_action_pressed("fire")):
		print("firing")
		anim.stop()
		anim.play("HandAction")
