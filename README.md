# VisualNovelTutoBB

# Resources

## Characters

https://picrew.me/en/image_maker/2265668

## Music

https://clement-panchout.itch.io/yet-another-free-music-pack


# SFX
https://dillonbecker.itch.io/sdap

https://filmcow.itch.io/filmcow-sfx-4

# Dialogic

## Repo
https://github.com/dialogic-godot/dialogic.git

## Docs dialogic
https://docs.dialogic.pro/text-effects.html

# Possible Improvements

## Sistema de Desbloqueo de CGs (Galería)
Actualmente, los personajes aparecen en la galería dependiendo de una variable booleana individual de Dialogic (ej: `IsMeet.NombrePersonaje`). 

**Mejora futura:** En lugar de crear una variable booleana por cada emoción o foto específica de cada personaje (ej: `IsMeet.GumpoHappy`), lo ideal es implementar un **Arreglo (Array)** o **Diccionario** global (por ejemplo, `UnlockedPictures = []`) que se guarde en el sistema de guardado del juego. 

- Cada vez que el jugador ve una imagen nueva (CG) durante la historia, el código la agregará a esa lista (ej: `UnlockedPictures.append("Gumpo_happy")`).
- En la Galería, al cargar las miniaturas (`ImagePreview`), el código verificará si el nombre de la foto actual está dentro de ese arreglo.
- **Si está en la lista:** Carga la textura de la imagen normalmente para que se pueda ver y hacer clic.
- **Si no está:** Reemplaza la textura por una silueta negra o un ícono de candado, bloqueando el clic. Esto incita al jugador a seguir jugando y tomando diferentes rutas para completar la galería.