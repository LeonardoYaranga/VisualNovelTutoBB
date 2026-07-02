extends Control

@onready var music_btn: Button = $VBoxContainer/MusicBtn
@onready var gallery: Control = $Gallery

func _on_button_button_down() -> void:
	GameManager.change_to_game_scene()


func _on_music_button_down() -> void:
	var bus_idx = AudioServer.get_bus_index("Music")

	var is_muted = AudioServer.is_bus_mute(bus_idx)
	
	if is_muted:
		AudioServer.set_bus_mute(bus_idx, false)
		music_btn.text = "Music On"
	else:
		AudioServer.set_bus_mute(bus_idx, true)
		music_btn.text = "Music Off"


func _on_gallery_btn_button_down() -> void:
	gallery.visible = true


func _on_v_box_container_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MouseButton.MOUSE_BUTTON_LEFT and event.pressed:
		gallery.visible = false
