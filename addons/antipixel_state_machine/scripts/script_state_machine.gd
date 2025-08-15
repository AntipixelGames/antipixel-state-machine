@icon("res://addons/antipixel_state_machine/icons/icon_antipixel_state_machine.svg")
class_name StateMachine extends Node

signal state_entering(state: State, data: Array[Variant])
signal state_entered(state: State, data: Array[Variant])
signal state_exiting(state: State, data: Array[Variant])
signal state_exited(state: State, data: Array[Variant])
signal initialized(state_machine: StateMachine)

static var machines: Dictionary[String, StateMachine]

@export var id: String
@export_group("Advanced")
@export var autoinit: bool = true

var states: Dictionary[String, State]
var current: State
var previous: State
var next: State
var current_data: Array[Variant]
var previous_data: Array[Variant]
var next_data: Array[Variant]
var is_initialized: bool

func _ready() -> void:
	var state: State
	for child: Node in get_children():
		state = child as State
		
		if not state: continue
		
		if state.id.is_empty():
			state.id = name_to_id(state)
		
		for component: Node in state.get_children():
			if component is StateComponent:
				state.add_component(component)
		
		state.machine = self
		add_state(state)
		change_process(state, false)
		
		if autoinit and state.get_initial():
			change(state.id)
	
	if autoinit and not is_initialized:
		change(states.keys()[0])

func _enter_tree() -> void:
	if id.is_empty(): id = name_to_id(self)
	machines[id] = self

func _exit_tree() -> void:
	if machines[id] and machines[id] == self:
		machines.erase(id)

func change(id: String, data: Array[Variant] = []) -> bool:
	next = states.get(id)
	next_data = data
	
	if not next.can_change():
		next = null
		next_data = []
		return false
	
	if current:
		state_exiting.emit(current, current_data)
		current._exit()
		state_exited.emit(current, current_data)
		change_process(current, false)
		
		for component: StateComponent in current.components:
			component._exit()
	else:
		is_initialized = true
		initialized.emit(self)
	
	previous = current
	previous_data = current_data
	
	current = next
	current_data = next_data
	
	next = null
	next_data = []
	
	state_entering.emit(current, current_data)
	current._enter()
	state_entered.emit(current, current_data)
	change_process(current, true)
	
	for component: StateComponent in current.components:
		component._enter()
	
	return true

func add_state(state: State) -> bool:
	if states.has(state.id): return false
	state.tree_exited.connect(remove_state.bind(state))
	states[state.id] = state
	return true

func remove_state(state: State) -> bool:
	if not states.has(state.id) or states[state.id] != state: return false
	states[state.id].tree_exited.disconnect(remove_state)
	states.erase(state.id)
	return true

static func change_process(node: Node, value: bool) -> void:
	node.set_process(value)
	node.set_process_input(value)
	node.set_process_internal(value)
	node.set_process_shortcut_input(value)
	node.set_process_unhandled_input(value)
	node.set_process_unhandled_key_input(value)
	node.set_physics_process(value)
	node.set_physics_process_internal(value)
	
	for child: Node in node.get_children():
		change_process(child, value)

static func name_to_id(node: Node) -> String:
	return node.name.capitalize().to_lower().replace(" ", "_")
