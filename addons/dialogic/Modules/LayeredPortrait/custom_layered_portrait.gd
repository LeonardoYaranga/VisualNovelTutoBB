@tool
extends "res://addons/dialogic/Modules/LayeredPortrait/layered_portrait.gd"

func _set_extra_data(data: String) -> void:
	var commands = _parse_input_to_layer_commands(data)

	for _command in commands:
		var target_node = get_node_or_null(_command._path)
		
		# 1. Arreglamos que SET_LAYER no oculta los AnimatedSprite2D por defecto
		if _command._type == LayerCommand.CommandType.SET_LAYER and target_node:
			var parent = target_node.get_parent()
			for child in parent.get_children():
				if child is AnimatedSprite2D:
					child.hide()
					child.stop()

		# Ejecutamos la lógica original de Dialogic (que maneja Sprite2D)
		_command._execute(self)

		# 2. Le damos "play()" si estamos mostrando un AnimatedSprite2D
		if _command._type == LayerCommand.CommandType.SHOW_LAYER or _command._type == LayerCommand.CommandType.SET_LAYER:
			if target_node is AnimatedSprite2D:
				target_node.play()
		
		# 3. Lo detenemos si lo estamos ocultando
		elif _command._type == LayerCommand.CommandType.HIDE_LAYER:
			if target_node is AnimatedSprite2D:
				target_node.stop()
