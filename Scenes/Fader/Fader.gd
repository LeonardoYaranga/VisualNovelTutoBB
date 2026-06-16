class_name Fader
extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func fade() -> void:
	animation_player.play("fade")
