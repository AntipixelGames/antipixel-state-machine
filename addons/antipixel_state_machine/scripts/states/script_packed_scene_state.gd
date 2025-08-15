class_name PackedSceneState extends State

@export var parent: Node
@export var scene: PackedScene

var instance: Node

func _enter() -> void:
	instance = scene.instantiate()
	parent.call_deferred("add_child", instance)

func _exit() -> void:
	instance.queue_free()
