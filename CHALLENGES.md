Cosas que mas me costo hacer o no sabia como hacer al principio pero se encontro
 una solucion
---

# Sincronización de cambio de escena con Dialogic
**El Reto:** No sabíamos cómo trabajar con Dialogic para cambiar de escena al interrumpir un diálogo (como al pulsar un botón "X" para salir al menú). Si cambiábamos de escena justo después de llamar a `Dialogic.end_timeline()`, el cambio era abrupto y se veía muy raro porque no esperábamos a que terminara la animación de cierre del cuadro de texto.

**Intento inicial:** Pensamos que la única forma de solucionarlo era crear un `Timer` y esperar a que el tiempo pasara para entonces cambiar de escena. Aunque funcionaba, sentíamos que era un código "sucio".

**Solución final:** Descubrimos que en lugar de usar un timer fijo, era mucho mejor usar la funcionalidad de señales de Godot combinada con `await`. Implementamos `await Dialogic.timeline_ended` justo después de terminar el timeline. Esto pausa la ejecución exactamente hasta que la animación de cierre acaba, resultando en un código muy limpio y una transición perfecta entre escenas.
