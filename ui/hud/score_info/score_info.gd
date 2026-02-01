extends Control

@onready
var score : Label = $MarginContainer/VBoxContainer/HBoxContainer/Score

var now_score : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	now_score = lerp(now_score, WaveManager.now_total_score, 0.01)
	score.text = format_grouped_number(now_score)
	pass

func format_grouped_number(n: int, total_digits := 9, group_size := 3, sep := "'") -> String:
	var s := str(n).pad_zeros(total_digits)

	var result := ""
	var count := 0

	for i in range(s.length() - 1, -1, -1):
		result = s[i] + result
		count += 1
		if count == group_size and i != 0:
			result = sep + result
			count = 0

	return result
