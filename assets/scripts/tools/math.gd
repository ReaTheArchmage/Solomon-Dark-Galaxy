class_name Math extends Node

## returns a random float between -1 and 1. if signed = true,
## returns it in a range between 0.0 and 1.0.
static func normal_rng(signed: bool = false) -> float:
	if signed: return randf_range(0.0, 1.0)
	return randf_range(-1.0, 1.0)
