extends Node

var _plugin: EditorPlugin

func setup(plugin: EditorPlugin) -> void:
	_plugin = plugin

func create_action(request_id: int, do_methods: Array, undo_methods: Array) -> void:
	var undo_redo = _plugin.get_undo_redo()
	undo_redo.create_action("MCP: op_%d" % request_id)
	for m in do_methods:
		_add_method_call(undo_redo, "do", m)
	for m in undo_methods:
		_add_method_call(undo_redo, "undo", m)
	undo_redo.commit_action()


func _add_method_call(undo_redo: UndoRedo, mode: String, m: Dictionary) -> void:
	var args: Array = m.get("args", [])
	var target: Object = m.target
	var method: String = m.method
	# Godot 4.4+: add_do_method / add_undo_method only accept a single Callable
	var callable := Callable(target, method).bindv(args)
	if mode == "do":
		undo_redo.add_do_method(callable)
	else:
		undo_redo.add_undo_method(callable)
