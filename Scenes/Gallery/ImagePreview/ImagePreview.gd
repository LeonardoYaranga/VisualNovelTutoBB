extends Panel

@export var new_image : Texture = null
@export var title := ""
signal pressed

@onready var image: TextureRect = $Image
@onready var color_rect: ColorRect = $ColorRect
@onready var name_label: Label = $ColorRect/NameLabel

func _ready() -> void:
	image.texture = new_image
	name_label.text = title
	await get_tree().process_frame
	image.pivot_offset = image.size/2
	
	# Conectamos las señales dinámicamente si no estan conectadas
	if not color_rect.mouse_entered.is_connected(_on_color_rect_mouse_entered):
		color_rect.mouse_entered.connect(_on_color_rect_mouse_entered)
	if not color_rect.mouse_exited.is_connected(_on_color_rect_mouse_exited):
		color_rect.mouse_exited.connect(_on_color_rect_mouse_exited)
	if not color_rect.gui_input.is_connected(_on_color_rect_gui_input):
		color_rect.gui_input.connect(_on_color_rect_gui_input)
	if not focus_entered.is_connected(_on_focus_entered):
		focus_entered.connect(_on_focus_entered)
	if not focus_exited.is_connected(_on_focus_exited):
		focus_exited.connect(_on_focus_exited)

func _gui_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		pressed.emit()
		accept_event()

func _on_color_rect_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		pressed.emit()
		accept_event()

func _on_color_rect_mouse_entered() -> void:
	image.pivot_offset = image.size/2
	var tween := create_tween()
	tween.tween_property(image, 'scale', Vector2(1.1, 1.1), 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)

func _on_color_rect_mouse_exited() -> void:
	var tween := create_tween()
	tween.tween_property(image, 'scale', Vector2(1.0, 1.0), 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)

func _on_focus_entered() -> void:
	_on_color_rect_mouse_entered()

func _on_focus_exited() -> void:
	_on_color_rect_mouse_exited()
