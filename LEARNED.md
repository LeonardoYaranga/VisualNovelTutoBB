Conceptos, mecanicas que aprendi
---

# Manejar timelines basicas
Como crear, insertar personajes, actualizarlos activando o desactivando capas, o ya sea cambiando de Portrait.

# Crear personajes

Como manejar varios personajes con diferentes protraits que serian ya distintas poses, pueden tener ya emociones, aun asi se puede mejorar su manejo con animacion, cambiando la escena default a una Layered Portrait
## Manejar Layered Portrait
Se puede colocar Sprite2D para las partes que no se mueven, pero mas para lo que seria la boca y los ojos y dar un efecto de pestaneo o de hablar se usaria mejor un AnimatedSpirte2D


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
Entc el GameManager cargara y la colocara en el arbol a una escena llamada Fade que es un canvas Layer siempre visible Layer2 que Ignora los clicks y tiene una animacion de "fade" osea que sea transaparente, oscuro y transaperente su ColorRect

# Insercion de audios y voces
Ademas se puede modificar los buses de audio que se utilizan para los canales de audio en dialogic.
Se puede crear en la parte inferior de godot mas buses de audio, ademas del master como Music, SFX, luego en dialogic a los channels que hay se les selecciona q salgan por su respectivo bus.
Asi en distintas momentos si colocamos musica en el mismo canal la sobreescribimos.
O podemos crear mas canales para que ambas musicas suenen a la vez.

![[AudioConfigVisualNovel.png]]

Los tipo Voice en Dialogic se pone despues de el evento de texto siguiente.

# Sonidos de tipeo
Estos se pueden modificar para cada personaje y asignarse para cada Portrait, puede haber varios typing sounds, con la estrellita seleccionas el default de lo tipyng sounds en su seccion.
![[PortraitTypingSoundsManage.png]]
# Efectos en los Text
Se le puede dar mas dramatismo con pausas entre las palabras, en una misma linea como el uso de [input] o para que apareza el texto en otro en un nuevo cuadro con [n].
Mas info https://docs.dialogic.pro/text-effects.html