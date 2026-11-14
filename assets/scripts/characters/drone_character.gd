class_name DroneMovement extends CharacterController

var speed_multiplier: float = 1.0

func _unhandled_input(event: InputEvent) -> void:
	mouse_rotate_view(event)

func _physics_process(_delta: float) -> void:
	move_character()
	move_and_slide()

func move_character(acceleration = 1.0):
	var input_dir := Input.get_vector(
		"ship_left", "ship_right", "ship_forward", "ship_backward")
	var i_thrust_dir := Input.get_axis(
		"ship_thrusters_down", "ship_thrusters_up")

	var tmp_dir:= Vector3(input_dir.x, i_thrust_dir, input_dir.y)
	var direction := (transform.basis * tmp_dir).normalized()

	if direction:
		velocity.x = direction.x * (data.speed * (speed_multiplier * acceleration))
		velocity.y = direction.y * (data.speed * (speed_multiplier * acceleration))
		velocity.z = direction.z * (data.speed * (speed_multiplier * acceleration))
	else:
		velocity.x = move_toward(velocity.x, 0, (data.speed * data.inertia))
		velocity.y = move_toward(velocity.y, 0, (data.speed * data.inertia))
		velocity.z = move_toward(velocity.z, 0, (data.speed * data.inertia))
