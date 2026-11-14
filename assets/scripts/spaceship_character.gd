class_name SpaceShipCharacter extends VehicleController

var spaceship_acceleration: float = 0.0
var acceleration_bonus: float = 0.0
var speed_multiplier: float = 1.0

func _process(delta: float) -> void:
	accelerate(delta, data.max_acceleration + acceleration_bonus)
	boost(Input.is_action_pressed("ship_boost"), data.max_accel_bonus)
	print(spaceship_acceleration)

func _physics_process(_delta: float) -> void:
	move_vehicle()
	move_and_slide()


func move_vehicle(acceleration = spaceship_acceleration):
	var input_dir := Input.get_vector(
		"ship_left", "ship_right", "ship_forward", "ship_backward")
	var i_thrust_dir := Input.get_axis("ship_thrusters_down", "ship_thrusters_up")

	var tmp_dir:= Vector3(0.0, i_thrust_dir, input_dir.y if input_dir.y == -1.0 else -1.0)
	var direction := (transform.basis * tmp_dir).normalized()

	if direction:
		velocity.x = direction.x * (data.speed * (speed_multiplier * acceleration))
		velocity.y = direction.y * (data.speed * (speed_multiplier * acceleration))
		velocity.z = direction.z * (data.speed * (speed_multiplier * acceleration))
	else:
		velocity.x = move_toward(velocity.x, 0, (data.speed * data.inertia))
		velocity.y = move_toward(velocity.y, 0, (data.speed * data.inertia))
		velocity.z = move_toward(velocity.z, 0, (data.speed * data.inertia))


func accelerate(delta, max_acceleration):
	if Input.is_action_pressed(
		"ship_forward") and spaceship_acceleration <= max_acceleration:
		spaceship_acceleration += delta
	elif not Input.is_action_pressed(
		"ship_forward") and spaceship_acceleration >= 0.0:
		spaceship_acceleration -= delta


func boost(state: bool, bonus: float):
	if state:
		acceleration_bonus = bonus
	else:
		acceleration_bonus = 0.0
