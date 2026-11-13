extends CharacterBody3D
@export var p_data: PlayerData

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

func _physics_process(delta: float) -> void:
	add_gravity(delta)
	jump_player()
	move_player()
	move_and_slide()


func _init() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _unhandled_input(event: InputEvent) -> void:
	mouse_rotate_view(event)


func add_gravity(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta


func jump_player():
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY


func move_player():
	var input_dir := Input.get_vector("ship_left", "ship_right", "ship_forward", "ship_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
var mouse_delta: Vector2


func mouse_rotate_view(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_delta = event.relative
		global_rotation.y -= mouse_delta.x * p_data.drone_mouse_sensitivity
		global_rotation.x -= mouse_delta.y * p_data.drone_mouse_sensitivity
