@tool
extends BTAction

# Task parameters
@export var grow_chance: float = 0.0001
@export var growth_factor: float = 2.0
@export var growth_duration: float = 5.0
@export var max_scale: float = 5.0

var _has_grown: bool = false
var _original_scale: float = 1.0
var _growth_timer: float = 0.0
var _is_growing: bool = false
var _is_shrinking: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _generate_name() -> String:
	return "TemporaryGrowth"

func _setup() -> void:
	_has_grown = false
	_original_scale = 1.0
	_growth_timer = 0.0
	_is_growing = false
	_is_shrinking = false

func _enter() -> void:
	_has_grown = false
	_growth_timer = 0.0
	_is_growing = false
	_is_shrinking = false

func _tick(delta: float) -> Status:
	var enemy = agent as BaseStar
	if not enemy:
		return FAILURE
	
	(agent as CharacterBody3D).velocity /= 2
	
	if _is_growing or _is_shrinking:
		_growth_timer += delta
		
		if _is_growing and _growth_timer >= growth_duration:
			_shrink_back(enemy)
			return SUCCESS
		
		return RUNNING
	
	if not _has_grown:
		if randf() > grow_chance:
			return SUCCESS
		
	_grow_enemy(enemy)
	_has_grown = true
	_is_growing = true
	_growth_timer = 0.0
	return RUNNING

func _grow_enemy(enemy: BaseStar) -> void:
	var star_body = enemy.get_node_or_null("StarBody") as MeshInstance3D
	if not star_body:
		return
	
	_original_scale = star_body.scale.x
	
	var new_scale = min(_original_scale * growth_factor, max_scale)	
	star_body.scale = Vector3.ONE * new_scale
	
	var scary_face = enemy.get_node_or_null("ScaryFace") as MeshInstance3D
	var happy_face = enemy.get_node_or_null("HappyFace") as MeshInstance3D
	
	if scary_face:
		scary_face.scale = Vector3.ONE * new_scale
	if happy_face:
		happy_face.scale = Vector3.ONE * new_scale
	
	var hitbox = enemy.get_node_or_null("Hitbox") as CollisionShape3D
	if hitbox and hitbox.shape is CapsuleShape3D:
		var capsule = hitbox.shape.duplicate() as CapsuleShape3D
		capsule.radius = new_scale
		capsule.height = 2.0 * new_scale
		hitbox.shape = capsule
	
	var nav_agent = enemy.get_node_or_null("NavigationAgent3D") as NavigationAgent3D
	if nav_agent:
		nav_agent.radius = new_scale
	
	var original_mat = star_body.get_active_material(0)
	if original_mat:
		var glow = original_mat.duplicate() as StandardMaterial3D
		glow.albedo_color = Color.RED
		star_body.set_surface_override_material(0, glow)

func _shrink_back(enemy: BaseStar) -> void:
	var star_body = enemy.get_node_or_null("StarBody") as MeshInstance3D
	if not star_body:
		return
	
	star_body.scale = Vector3.ONE * _original_scale
	
	var scary_face = enemy.get_node_or_null("ScaryFace") as MeshInstance3D
	var happy_face = enemy.get_node_or_null("HappyFace") as MeshInstance3D
	
	if scary_face:
		scary_face.scale = Vector3.ONE * _original_scale
	if happy_face:
		happy_face.scale = Vector3.ONE * _original_scale
	
	var hitbox = enemy.get_node_or_null("Hitbox") as CollisionShape3D
	if hitbox and hitbox.shape is CapsuleShape3D:
		var capsule = hitbox.shape.duplicate() as CapsuleShape3D
		capsule.radius = _original_scale
		capsule.height = 2.0 * _original_scale
		hitbox.shape = capsule
	
	var nav_agent = enemy.get_node_or_null("NavigationAgent3D") as NavigationAgent3D
	if nav_agent:
		nav_agent.radius = _original_scale
	
	star_body.set_surface_override_material(0, null)
	
	_is_shrinking = true
	
func _exit() -> void:
	if _is_growing:
		var enemy = agent as BaseStar
		if enemy:
			_shrink_back(enemy)

func _get_configuration_warnings() -> PackedStringArray:
	var warnings := PackedStringArray()	
	return warnings
	
