extends ColorRect

var machine: StateMachine:
	get: return StateMachine.machines["color"]

func _ready() -> void:
	if not StateMachine.machines.has("color"): return
	
	machine.state_entered.connect(_on_color_state_entered)
	
	if machine.current_data:
		color = machine.current_data[1]

func _on_color_state_entered(state: State, data: Array) -> void:
	if data.is_empty(): return
	if data[0] is String: print(data[0])
	color = data[1]
