class_name SpaceShipCharacter extends VehicleController

func _init() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent) -> void:
	mouse_rotate_view(event)

func _physics_process(_delta: float) -> void:
	print(speed_multiplier)
	accelerate(_delta, max_accel)
	move_ship(acceleration)
	move_and_slide()

var acceleration: float = 0.0
var max_accel: float = 5.0

func accelerate(delta, max_acceleration):
	if Input.is_action_pressed("ship_forward") and acceleration <= max_acceleration:
		acceleration += delta
	elif not Input.is_action_pressed("ship_forward") and acceleration >= 0.0:
		acceleration -= delta
