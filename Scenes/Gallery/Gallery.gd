extends Control

const IMAGE_PREVIEW_SCENE = preload("res://Scenes/Gallery/ImagePreview/ImagePreview.tscn")
const CHARACTERS_DIR = "res://Assets/Characters/"


@onready var option_button: OptionButton = $VBoxContainer/HBoxContainer/BannerImage/OptionButton
@onready var banner_image: TextureRect = $VBoxContainer/HBoxContainer/BannerImage
@onready var grid_container: GridContainer = $VBoxContainer/ScrollContainer/GridContainer

var character_names := []
# Nodos dinámicos para el Visor a pantalla completa
var fullscreen_visor: CanvasLayer
var fullscreen_image: TextureRect

func _ready() -> void:
	# Construimos el Visor por código para que no tengas que hacerlo a mano!
	_setup_fullscreen_visor()
	
	_load_character_list()
	
	# Cargamos las fotos del primer personaje de la lista automáticamente
	if character_names.size() > 0:
		_load_character_images(character_names[0])
		
	# Conectamos cuando eliges un personaje diferente en el OptionButton
	option_button.item_selected.connect(_on_character_selected)

func _setup_fullscreen_visor() -> void:
	fullscreen_visor = CanvasLayer.new()
	fullscreen_visor.layer = 100 # Encima de toda la UI
	fullscreen_visor.hide()
	add_child(fullscreen_visor)
	
	# El fondo oscuro clickeable
	var bg = ColorRect.new()
	bg.color = Color(0, 0, 0, 0.9) # Fondo negro semi-transparente
	bg.set_anchors_preset(PRESET_FULL_RECT)
	bg.gui_input.connect(_on_fullscreen_bg_gui_input) # Cerrar al dar clic
	fullscreen_visor.add_child(bg)
	
	# El visor de la imagen grande
	fullscreen_image = TextureRect.new()
	fullscreen_image.set_anchors_preset(PRESET_FULL_RECT)
	fullscreen_image.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	fullscreen_image.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	fullscreen_image.mouse_filter = Control.MOUSE_FILTER_IGNORE
	fullscreen_visor.add_child(fullscreen_image)

func _load_character_list() -> void:
	character_names.clear()
	option_button.clear()
	
	var dir = DirAccess.open(CHARACTERS_DIR)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir() and not file_name.begins_with("."):
				
				# Construimos el nombre de la variable dinámicamente (ej: "Meets.MeetGumpo")
				var variable_dialogic = "IsMeet." + file_name
				
				# Obtenemos el valor de Dialogic. Si no existe la variable, por defecto asume false.
				var isMeet = Dialogic.VAR.get_variable(variable_dialogic, false)
				var meetGumpo = Dialogic.VAR.IsMeet.Gumpo
				print("meetGumpo: " , meetGumpo)
				print("isMeet ", isMeet , "file: ", file_name )
				if isMeet:
					character_names.append(file_name)
					option_button.add_item(file_name.capitalize())
					
			file_name = dir.get_next()
	else:
		print("Error al abrir la carpeta de personajes: ", CHARACTERS_DIR)

func _on_character_selected(index: int) -> void:
	var char_name = character_names[index]
	_load_character_images(char_name)

func _load_character_images(char_name: String) -> void:
	# Limpiamos todo lo anterior
	for child in grid_container.get_children():
		child.queue_free()
	
	var path = CHARACTERS_DIR + char_name + "/"
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		
		while file_name != "":
			# Si es una imagen (.png o .jpg)
			if not dir.current_is_dir() and (file_name.ends_with(".png") or file_name.ends_with(".jpg")):
				var tex_path = path + file_name
				var texture = load(tex_path)
				
				# Si la imagen se llama "banner.png" o "Banner.jpg", la usamos de banner
				if file_name.get_basename().to_lower() == "banner":
					banner_image.texture = texture
				else:
					# Creamos y configuramos el cuadradito ImagePreview
					var preview = IMAGE_PREVIEW_SCENE.instantiate()
					preview.new_image = texture
					preview.title = file_name.get_basename() # El nombre del archivo sin extensión
					
					# Conectamos la señal para abrir la imagen grande
					preview.pressed.connect(_on_image_selected.bind(texture))
					
					grid_container.add_child(preview)
				
			file_name = dir.get_next()
	else:
		print("No se encontró la carpeta del personaje: ", path)

func _on_image_selected(textura: Texture2D) -> void:
	fullscreen_image.texture = textura
	fullscreen_visor.show()

func _on_fullscreen_bg_gui_input(event: InputEvent) -> void:
	# Si das clic izquierdo en el fondo oscuro, se oculta el visor
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		fullscreen_visor.hide()
