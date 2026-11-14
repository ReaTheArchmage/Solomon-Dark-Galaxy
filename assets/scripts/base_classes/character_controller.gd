@abstract class_name CharacterController extends CharacterBody3D
@abstract func move_character(acceleration: float)

@export var data: CharacterData
var mouse_delta: Vector2

func _init() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent) -> void:
	mouse_rotate_view(event)

func mouse_rotate_view(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_delta = event.relative
		global_rotation.y -= mouse_delta.x * data.mouse_sensitivity
		global_rotation.x -= mouse_delta.y * data.mouse_sensitivity
