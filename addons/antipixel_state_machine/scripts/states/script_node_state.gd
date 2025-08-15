class_name NodeState extends State

@export var node: Node
@export_group("Advanced")
@export var modify_visibility: bool = true
@export var modify_process: bool = true

func _enter() -> void:
	if "visible" in node and modify_visibility:
		node.visible = true
	if modify_process:
		StateMachine.change_process(node, true)

func _exit() -> void:
	if "visible" in node and modify_visibility:
		node.visible = false
	if modify_process:
		StateMachine.change_process(node, false)
