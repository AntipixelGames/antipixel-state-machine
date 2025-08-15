extends Button

@export var machine_id: String
@export var state_id: String
@export var data: Array

func _ready() -> void:
	pressed.connect(_on_button_pressed)

func _on_button_pressed() -> void:
	if not StateMachine.machines.has(machine_id): return
	StateMachine.machines[machine_id].change(state_id, data)
