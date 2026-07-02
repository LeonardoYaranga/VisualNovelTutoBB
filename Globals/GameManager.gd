extends Node

const FADER = preload("uid://b4l1mk7xbirq5")
const GAME = preload("uid://li5k10ewb3ne")
const START_SCREEN = preload("uid://c3d684vyj1hkt")

var fader: Fader = null
var next_scene: PackedScene = null

func _ready() -> void:
	fader = FADER.instantiate()
	add_child(fader)
	
func fade() -> void:
	fader.fade()

func change_to_next_scene() -> void:
	if next_scene:
		get_tree().change_scene_to_packed(next_scene)
		next_scene = null
		
func start_transition(to_scene: PackedScene) -> void:
	next_scene = to_scene
	fader.fade()

func change_to_game_scene() -> void:
	start_transition(GAME)
	
func change_to_start_screen() -> void:
	start_transition(START_SCREEN)
