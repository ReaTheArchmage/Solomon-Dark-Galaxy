class_name DamageInstance extends CharacterData

@export var damage_value: int = -1
@export var critical_flag: bool = false
@export var status_flag: bool = false
@export var status_to_apply: String = ""

func set_instance(
	value: int, crit_flag: bool, stat_flag: bool, status: String):
	damage_value = value
	critical_flag = crit_flag
	status_flag = stat_flag
	status_to_apply = status
