class_name DroneMovement extends CharacterBody3D
@export var p_data: PlayerData

var speed_multiplier: float = 1.0
var mouse_delta: Vector2

func _init() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent) -> void:
	mouse_rotate_view(event)

func _physics_process(_delta: float) -> void:

	var input_dir := Input.get_vector(
		"ship_left", "ship_right", "ship_forward", "ship_backward")
	var i_thrust_dir := Input.get_axis("ship_thrusters_down", "ship_thrusters_up")

	var tmp_dir:= Vector3(input_dir.x, i_thrust_dir, input_dir.y)
	var direction := (transform.basis * tmp_dir).normalized()

	if direction:
		speed_multiplier = 1.0
		velocity.x = direction.x * (p_data.DRONE_SPEED * speed_multiplier)
		velocity.y = direction.y * (p_data.DRONE_SPEED * speed_multiplier)
		velocity.z = direction.z * (p_data.DRONE_SPEED * speed_multiplier)
	else:
		tmp_dir.y = 0.0
		speed_multiplier = p_data.drone_inertia
		velocity.x = move_toward(velocity.x, 0, (p_data.DRONE_SPEED * speed_multiplier))
		velocity.y = move_toward(velocity.y, 0, (p_data.DRONE_SPEED * speed_multiplier))
		velocity.z = move_toward(velocity.z, 0, (p_data.DRONE_SPEED * speed_multiplier))

	move_and_slide()

func mouse_rotate_view(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_delta = event.relative
		global_rotation.y -= mouse_delta.x * p_data.drone_mouse_sensitivity
		global_rotation.x -= mouse_delta.y * p_data.drone_mouse_sensitivity
