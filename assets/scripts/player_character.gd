extends CharacterBody3D

@export var data: PlayerData
var jump_timer: float = 0.0
var delta: float = 0.0
var can_fly: bool = true

func _init() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(_delta: float) -> void:
	delta = _delta
	add_gravity()
	jump_player()
	move_player()
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	mouse_rotate_view(event)


func add_gravity():
	if not is_on_floor():
		velocity += get_gravity() * delta


func jump_player():
	if jump_timer >= data.max_air_time:
		fly_cooldown(data.fly_cooldown)

	if Input.is_action_pressed("ui_accept") and can_fly:
		velocity.y = data.jump_velocity
		jump_timer += delta
	else:
		jump_timer = 0.0


func fly_cooldown(duration: float):
	can_fly = false
	await get_tree().create_timer(duration).timeout
	can_fly = true


func move_player():
	var input_dir := Input.get_vector("ship_left", "ship_right", "ship_forward", "ship_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * data.speed
		velocity.z = direction.z * data.speed
	else:
		velocity.x = move_toward(velocity.x, 0, data.speed)
		velocity.z = move_toward(velocity.z, 0, data.speed)
var mouse_delta: Vector2


func mouse_rotate_view(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_delta = event.relative
		global_rotation.y -= mouse_delta.x * data.mouse_sensitivity
		global_rotation.x -= mouse_delta.y * data.mouse_sensitivity
