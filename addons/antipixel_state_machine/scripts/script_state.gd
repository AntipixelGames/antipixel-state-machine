@icon("res://addons/antipixel_state_machine/icons/icon_antipixel_state.svg")
class_name State extends Node

@export var id: String
@export_group("Advanced")
@export var is_initial: bool
@export var allow_self_transition: bool = true

var machine: StateMachine
var components: Array[StateComponent]

func _enter() -> void:
	pass

func _exit() -> void:
	pass

func get_initial() -> bool:
	return is_initial

func can_change() -> bool:
	return allow_self_transition \
	if machine.current and machine.current.id == id \
	else true

func get_components(id: String) -> Array[StateComponent]:
	var output: Array[StateComponent]
	for component: StateComponent in components:
		if component.id == id:
			output.append(component)
	return output

func add_component(component: StateComponent) -> bool:
	if components.has(component): return false
	component.tree_exiting.connect(remove_component.bind(component))
	components.append(component)
	
	component.state = self
	if component.id.is_empty():
		component.id = StateMachine.name_to_id(component)
	
	return true

func remove_component(component: StateComponent) -> bool:
	if not components.has(component): return false
	component.tree_exiting.disconnect(remove_component)
	components.erase(component)
	return true
