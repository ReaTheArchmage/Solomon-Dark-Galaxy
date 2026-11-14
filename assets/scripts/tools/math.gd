## Class that contains all static methods for in-game math algorithms.
class_name Math extends Node

## returns a random float between -1 and 1. if signed = true, returns it in a
## range between 0.0 and 1.0.
static func normal_rng(signed: bool = false) -> float:
	if signed: return randf_range(0.0, 1.0)
	return randf_range(-1.0, 1.0)

## Class used to statically calculate damage. Contains damage instance
## calculators.
class DmgCalc:
	## returns in a vector2i damage value as x, crit flag as y (1=crit)
	static func get_damage(bd, cc, cd, fm) -> Vector2i:
		var crit = Math.DmgCalc.get_crit_value_flag(cc, cd)
		var crit_value = crit.x
		var crit_flag = crit.y
		return Vector2i(
			((bd * crit_value) * fm), crit_flag)
	
	## returns critical as a vector2: x is the crit damage value, y is the crit
	##  flag (1=crit, -1=nocrit)
	static func get_crit_value_flag(cc: float, cd: float) -> Vector2:
		var rng = Math.normal_rng(true)
		if rng  < cc:
			return Vector2((cd * (1 + cc + rng)), 1)
		return Vector2(1, -1)
	
	## picks a random active status, check if its chance triggers a status event,
	## if so, returns the status and a flag.
	static func get_status(active_status: Dictionary) -> Array:
		var status_array = active_status.keys()
		var picked_status = status_array.pick_random()
		
		if  active_status[picked_status] == null:
			push_error("selected status is null!")
			return [false, "Error"]
		
		if Math.normal_rng(true) <= active_status[picked_status]:
			var status = get_status_str_flag(picked_status)
			return status
		return [false, "NONE"]
	
	## converts status enum entry to string, enum entry is treated as an integer:
	## 0 = .NONE, 1 = .STUN, 2 = .DOT, 3 = .DEFECT
	static func get_status_str_flag(status: Variant) -> Array:
		match status:
			1:  return [true, "STUN"]
			2:    return [true, "DOT"]
			3:     return [true, "DEFECT"]
		return [false, "NONE"]
