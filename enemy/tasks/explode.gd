@tool
extends Area3D

func get_other_exploded_stars() -> Array:
	var stars = []
	var overlapping = get_overlapping_bodies()
	for body in overlapping:
		if body.is_in_group("enemies") and body != get_parent():
			stars.append(body)
	return stars
