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

## returns a constructed damage instance, with all the data needed to process any
## unique damage event occuring in the scene.
func damage_instance_constructor() -> DamageInstance:
	var dmg_inst: DamageInstance = DamageInstance.new()
	var dmg = Math.DmgCalc.get_damage(
		base_damage, critical_chance,
		critical_damage, final_multiplier)
	var status = Math.DmgCalc.get_status(active_status_effects)
	
	dmg_inst.critical_flag = true if dmg.y == 1 else false
	dmg_inst.status_flag = status[0]
	dmg_inst.status_to_apply = status[1]
	dmg_inst.damage_value = dmg.x
	
	return dmg_inst

## TEST THIS MODULE FROM ANYWHERE WITH THIS TEMPLATE:
#func _ready() -> void:
	#var x = DamageData.new()
	#x.base_damage = 10
	#x.critical_chance = 0.7
	#x.critical_damage = 2.2
	#x.active_status_effects.assign({1:0.3})
	#x.final_multiplier = 1.1
#
	#for i in 10:
		#var y = x.damage_instance_constructor()
		#print(y.damage_value, "  :  ", y.critical_flag, "  :  ", y.status_flag, "  :  ", y.status_to_apply)
