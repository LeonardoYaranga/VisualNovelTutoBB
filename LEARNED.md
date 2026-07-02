Conceptos, mecanicas que aprendi
---

# Manejar timelines basicas
Como crear, insertar personajes, actualizarlos activando o desactivando capas, o
 ya sea cambiando de Portrait.

# Crear personajes

Como manejar varios personajes con diferentes protraits que serian ya distintas
poses, pueden tener ya emociones, aun asi se puede mejorar su manejo con animaci
on, cambiando la escena default a una Layered Portrait
## Manejar Layered Portrait
Se puede colocar Sprite2D para las partes que no se mueven, pero mas para lo que
 seria la boca y los ojos y dar un efecto de pestaneo o de hablar se usaria mejo
r un AnimatedSpirte2D


# Dicccionarios y variables

Se puede crear variables dentro de Dialogic
Desde el codigo de esta manera:
"Dialogic.VAR.nombreVariable" se puede acceder a las variables
Con esto se puede manejar la logica de los distintos caminos y finales.

# Transiciones al iniciar y terminal el timeline

Con la funcion Dialogic.timeline_started.connect(on_timeline_started)
se puede conectar para que siempre al iniciar un timeline pase algo
Digamos que la funcion conectada podrai tener esto:
func on_timeline_started() -> void:
        GameManager.fade()
Entc el GameManager cargara y la colocara en el arbol a una escena llamada Fade
que es un canvas Layer siempre visible Layer2 que Ignora los clicks y tiene una
animacion de "fade" osea que sea transaparente, oscuro y transaperente su ColorR
ect

# Insercion de audios y voces
Ademas se puede modificar los buses de audio que se utilizan para los canales de
 audio en dialogic.
Se puede crear en la parte inferior de godot mas buses de audio, ademas del mast
er como Music, SFX, luego en dialogic a los channels que hay se les selecciona q
 salgan por su respectivo bus.
Asi en distintas momentos si colocamos musica en el mismo canal la sobreescribim
os.
O podemos crear mas canales para que ambas musicas suenen a la vez.

![[AudioConfigVisualNovel.png]]

Los tipo Voice en Dialogic se pone despues de el evento de texto siguiente.

# Sonidos de tipeo
Estos se pueden modificar para cada personaje y asignarse para cada Portrait, puede haber varios typing sounds, con la estrellita seleccionas el default de lo tipyng sounds en su seccion.
![[PortraitTypingSoundsManage.png]]
# Efectos en los Text
Se le puede dar mas dramatismo con pausas entre las palabras, en una misma linea como el uso de [input] o para que apareza el texto en otro en un nuevo cuadro con [n].
Mas info https://docs.dialogic.pro/text-effects.html

# UI Personalizada sobre Dialogic (GameUi)
Aprendí a crear mi propia interfaz de juego (GameUi) con un nodo `Control` y un botón "X" para regresar al menú principal, posicionándola por encima de Dialogic.
Para que funcione correctamente:
1. **CanvasLayer:** La escena `GameUi` debe instanciarse dentro de la escena principal (en este caso el `Game`) y colocarse dentro de un nodo `CanvasLayer` con una capa (layer) alta para asegurarnos de que siempre se dibuje por encima del timeline de Dialogic.
2. **Mouse Filter en Ignore:** Es CRUCIAL poner el `Mouse Filter` del `MarginContainer` de la GameUi en `Ignore`. Si no se hace, el contenedor de la interfaz bloquea los clics e impide seguir interactuando (avanzando los textos) en el timeline de Dialogic.
3. **Salir al Menú Principal:** Para salir del juego y volver al menú, creamos una función que cierra el diálogo con `Dialogic.end_timeline()` y usamos la señal de cierre para que quede limpio: `await Dialogic.timeline_ended`, y una vez que termina la animación, cambiamos la escena.

# Galería Dinámica
Aprendi a construir una galería de imágenes dinámica:
1. **Foto de galeria(`ImagePreview`):** Se creo una escena base que es un cuadro pequeño (`TextureRect` + `ColorRect` oscurecedor). Tiene lógica propia para reaccionar al ratón (Tweens para agrandarse al pasar el cursor) y emite una señal personalizada (`pressed`) cuando se le hace clic.
2. **Generación Automática:** La galería principal (`Gallery.tscn`) lee de la carpeta de personajes, en este caso (`res://Assets/Characters/`). Para el personaje seleccionado, el script instancia múltiples escenas `ImagePreview` en un `GridContainer`, uno por cada foto encontrada.
3. **Imagen de Pantalla Completa:** El script  de la galería crea el visor por código instanciando un `CanvasLayer` y un `TextureRect`. 
4. **Reusabilidad:** Al unificar el comportamiento en la escena `ImagePreview` y conectar sus señales a funciones más grandes en la galería, logramos un código más comprensible y reutilizable para otras pantallas.
5. **Uso de .bind():** Comprendi el uso la funcion .bind para pasar argumentos  a funciones que lo requieren, pero cuya activacion de la senial no lo hace. Ej: preview.pressed.connect(_on_image_selected.bind(texture))
En este caso preview es una instancia de la escena ImagePreview pero la activacion de la senial no pasa la textura que se necesita, por eso, como se usa un WHILE para cada escena que se instancia se le pasa como parametro una textura diferente, de esta manera la function on_image_selected puede cargar una imagen diferente sin problema.
6. **Variable isMeet:** Se maneja variables booleanas en Dialogic para marcar que personaje han sido conocidos, asi en la galeria solo se carga la galeria de aquellos conocidos.

![[GalleryButtonSelector.png|350]]![[FullScreenPhotoGallery.png|344]]
![[ExpandedPhotoGalleryMouseHover.png]]