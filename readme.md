# ¿Quién es quién?

## Instalación
Antes de nada necesitaremos:
- Python 3.10
- Conda (para los requirements!)
- Prolog

### Entorno
```sh
$ conda create -n qqyago python=3.10
$ conda activate qqyago
```
### Requisitos
```sh
$ pip install -r requirements.txt
```
### ¿Cómo jugar?
1- Ejecutar el programa en el intérprete de prolog (usando iniciar_juego)
2- Presionar [↵] para comenzar el juego
3- Responder "s" para Sí y "n" para No según las preguntas del intérprete

## Preguntas pre-desarrollo

### 1. Optimización vs Búsquedas

Justifica por qué este juego puede considerarse un problema de optimización. Consulta la bibliografía recomendada.

#### Encaja en esta categoría porque buscamos encontrar el orden de preguntas que nos ayuda a minimizar los pasos necesarios para encontrar al personaje del adversario.

### 2. Entorno del agente

| Entorno de tareas | Completamente / parcialmente Observable | Agentes | Determinista / Estocástico | Episódico / Secuencial | Estático / Dinámico | Discreto / Continuo |
|-------------------|----------------------------------------|---------|----------------------------|------------------------|---------------------|---------------------|
| Quién es Quién    | Parcialmente Observable               | > 1       | Estocástico               | Secuencial             | Estático            | Discreto            |

### 3. Algoritmo

Usando programación en prolog iremos seleccionando posibles características que posee el personaje del rival. Optimizando nuestra secuencia de preguntas para ir reduciendo la muestra hasta poder acertar el personaje y ganar la partida.

Usando prolog para nuestro algoritmo podremos expresar este problema lógico de manera natural y eficiente.

### 4. Estructura del agente

Utilizaremos el correspondiente a un "Agente reactivo basado en modelos"

![Diagrama del Agente](img/diagrama.png)

### 5. Programación lógica

Considerando que hacemos uso de reglas y restricciones, podemos aprovechar la lógica declarativa para resolver el problema de manera eficiente y clara.
El motor de inferencia de prolog es muy útil al lidiar con estos problemas de búsqueda y optimización, y por ende el paradigma de programación lógica.

### 6. Base de datos de Prolog

Cada personaje (sea rival o propio) del juego se trata de una instancia con características/variables (nombre + resto de características)
Esto nos ayuda a descomponer la consulta de objetivo de la lista de atributos que vamos a focalizar en nuestras preguntas a la hora de averiguar el resultado.

### BIBLIOGRAFÍA
- Inspiración para la frecuencia:
https://stackoverflow.com/questions/24101926/prolog-getting-frequency-of-list

- Estructura y ejemplos:
https://github.com/dfleta/quienesquien

