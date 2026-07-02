extends Control


func _on_x_button_down() -> void:
	# Si hay un timeline activo, le pedimos que termine y esperamos a su señal oficial
	if Dialogic.current_timeline != null:
		Dialogic.end_timeline()
		await Dialogic.timeline_ended
	
	# Una vez cerrado (o si no había ninguno), cambiamos de escena
	GameManager.change_to_start_screen()
