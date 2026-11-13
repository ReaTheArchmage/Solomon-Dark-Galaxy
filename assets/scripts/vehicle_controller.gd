class_name VehicleController extends CharacterBody3D
@export var data: VehicleData
var speed_multiplier: float = 1.0
var mouse_delta: Vector2

func move_ship(accel: float = 1.0):
	var input_dir := Input.get_vector(
		"ship_left", "ship_right", "ship_forward", "ship_backward")
	var i_thrust_dir := Input.get_axis("ship_thrusters_down", "ship_thrusters_up")

	var tmp_dir:= Vector3(input_dir.x, i_thrust_dir, input_dir.y)
	var direction := (transform.basis * tmp_dir).normalized()

	if direction:
		velocity.x = direction.x * (data.speed * speed_multiplier * accel)
		velocity.y = direction.y * (data.speed * speed_multiplier * accel)
		velocity.z = direction.z * (data.speed * speed_multiplier * accel)
	else:
		velocity.x = move_toward(velocity.x, 0, (data.speed * speed_multiplier))
		velocity.y = move_toward(velocity.y, 0, (data.speed * speed_multiplier))
		velocity.z = move_toward(velocity.z, 0, (data.speed * speed_multiplier))


func mouse_rotate_view(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_delta = event.relative
		global_rotation.y -= mouse_delta.x * data.mouse_sensitivity
		global_rotation.x -= mouse_delta.y * data.mouse_sensitivity
