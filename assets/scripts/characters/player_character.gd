class_name PlayerCharacter extends CharacterController

var jump_timer: float = 0.0
var sprint_timer: float = 0.0
var can_sprint: bool = true
var can_fly: bool = true

var speed_multiplier: float = 1.0
var delta: float = 0.0

func _physics_process(_delta: float) -> void:
	delta = _delta

	add_gravity()
	jump_player()
	sprint_player()

	move_character()
	move_and_slide()


func move_character(_acceleration = 1.0):
	var input_dir := Input.get_vector("ship_left", "ship_right", "ship_forward", "ship_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * (data.speed * speed_multiplier)
		velocity.z = direction.z * (data.speed * speed_multiplier)
	else:
		velocity.x = move_toward(velocity.x, 0, data.speed)
		velocity.z = move_toward(velocity.z, 0, data.speed)


func add_gravity():
	if not is_on_floor():
		velocity += get_gravity() * delta


func jump_player():
	if jump_timer >= data.max_air_time:
		jump_cooldown(data.fly_cooldown)

	if Input.is_action_pressed("ship_thrusters_up") and can_fly:
		velocity.y = data.jump_velocity
		jump_timer += delta
	else:
		jump_timer = 0.0

func jump_cooldown(duration: float):
	can_fly = false
	await get_tree().create_timer(duration).timeout
	can_fly = true


func sprint_player():
	if sprint_timer >= data.max_sprint_time:
		sprint_cooldown(data.sprint_cooldown)
	
	if Input.is_action_pressed("ship_boost") and can_sprint:
		speed_multiplier = data.sprint_speed
		sprint_timer += delta
	else:
		speed_multiplier = 1.0
		sprint_timer = 0.0


func sprint_cooldown(duration: float):
	can_sprint = false
	print("cooldown")
	await get_tree().create_timer(duration).timeout
	print("ok")
	can_sprint = true


func _ready() -> void:
	var x = DamageData.new()
	x.base_damage = 10
	x.critical_chance = 0.7
	x.critical_damage = 2.2
	x.active_status_effects.assign({1:0.3})
	x.final_multiplier = 1.1

	for i in 10:
		var y = x.damage_instance_constructor()
		print(y.damage_value, "  :  ", y.critical_flag, "  :  ", y.status_flag, "  :  ", y.status_to_apply)
