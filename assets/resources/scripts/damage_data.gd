class_name DamageData extends CharacterData

@export_category("Damage Values")
@export_range(1.0, 9999.0, 1.0)  var  base_damage      : float = 1.0
@export_range(1.0, 9999.0, 1.0)  var  critical_damage  : float = 1.0
@export_range(0.0, 1.0, 0.01)    var  critical_chance  : float = 0.0
@export_range(1.0, 10.0, 0.1)    var  final_multiplier : float = 1.0

@export_category("Status Effects")
enum StatusType {
	NONE, STUN, DOT, DEFECT}
@export var active_status_effects : Dictionary[StatusType, float]
@export_range(0.0, 1.0, 0.01)    var  status_chance    : float = 0.0
@export_range(1.0, 30.0, 0.1)    var  status_duration  : float = 1.0

func damage_instance_constructor() -> DamageInstance:
	var dmg_inst: DamageInstance = DamageInstance.new()
	var dmg = get_damage()
	var status = get_status()
	
	dmg_inst.critical_flag = true if dmg.y == 1 else false
	dmg_inst.status_flag = status[0]
	dmg_inst.status_to_apply = status[1]
	
	dmg_inst.damage_value = dmg.x
	return dmg_inst

## returns in a vector2i damage value as x, crit flag as y (1=crit)
func get_damage() -> Vector2i:
	var crit = get_critical()
	var crit_value = crit.x
	var crit_flag = crit.y
	return Vector2i(
		((base_damage * crit_value) * final_multiplier), crit_flag)


## returns critical as a vector2: x is the crit damage value, y is the crit flag (1=crit, -1=nocrit)
func get_critical() -> Vector2:
	var rng = Math.normal_rng(true)
	if rng  < critical_chance:
		return Vector2((critical_damage * (1 + critical_chance + rng)), 1)
	return Vector2(1, -1)


func get_status() -> Array:
	var status_array = active_status_effects.keys()
	var picked_status = status_array.pick_random()
	
	if  active_status_effects[picked_status] == null:
		push_error("selected status is null!")
		return [false, "Error"]
	
	if Math.normal_rng(true) <= active_status_effects[picked_status]:
		var status = get_status_str_flag(picked_status)
		return status
	return [false, "NONE"]


func get_status_str_flag(status: StatusType) -> Array:
	match status:
		StatusType.DEFECT:  return [true, "DEFECT"]
		StatusType.STUN:    return [true, "STUN"]
		StatusType.DOT:     return [true, "DOT"]
	return [false, "NONE"]
