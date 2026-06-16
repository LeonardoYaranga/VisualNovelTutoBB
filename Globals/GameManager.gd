extends Node

const FADER = preload("uid://b4l1mk7xbirq5")

var fader : Fader = null

func _ready() -> void:
	fader = FADER.instantiate()
	add_child(fader)
	
func fade() -> void:
	fader.fade()
	
