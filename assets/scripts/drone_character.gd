class_name DroneMovement extends VehicleController

func _init() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent) -> void:
	mouse_rotate_view(event)

func _physics_process(_delta: float) -> void:
	move_ship()
	move_and_slide()
