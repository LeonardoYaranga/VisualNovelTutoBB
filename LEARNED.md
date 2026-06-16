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