:- begin_tests(qq_data).

% Archivo principal de lógica
:- [qq_data].

% Test para verificar la existencia de personajes
test(existencia_personajes) :-
    findall(Nombre, personaje(nombre(Nombre), _), Nombres),
    assertion(member('herman', Nombres)),
    assertion(member('maria', Nombres)),
    assertion(member('claire', Nombres)),
    assertion(length(Nombres, 24)).  % Debería haber 24 personajes en total

% Test para verificar las características de un personaje
test(caracteristicas_personaje) :-
    personaje(nombre('herman'), caracteristicas(Caracteristicas)),
    assertion(member(hombre, Caracteristicas)),
    assertion(member(pelirrojo, Caracteristicas)),
    assertion(member(calva, Caracteristicas)),
    assertion(length(Caracteristicas, 6)).

% Seleccionar mejor rasgo
test(seleccion_mejor_rasgo) :-
    findall(personaje(nombre(N), caracteristicas(Caracteristicas)), personaje(nombre(N), caracteristicas(Caracteristicas)), TodosPersonajes),
    findall(Caracteristica, (personaje(_, caracteristicas(Caracteristicas)), member(Caracteristica, Caracteristicas)), TodosRasgos),
    list_to_set(TodosRasgos, RasgosUnicos),
    seleccionar_mejor_rasgo(TodosPersonajes, RasgosUnicos, MejorRasgo),
    assertion(MejorRasgo \= _).  % El mejor rasgo debe ser uno de los rasgos únicos

% Filtro de personajes por rasgo
test(filtrar_personajes) :-
    findall(personaje(nombre(N), caracteristicas(Caracteristicas)), personaje(nombre(N), caracteristicas(Caracteristicas)), TodosPersonajes),
    filtrar_personajes(TodosPersonajes, pelirrojo, s, FiltradosSi),
    filtrar_personajes(TodosPersonajes, pelirrojo, n, FiltradosNo),
    assertion(length(FiltradosSi, 5)),  % Hay 5 personajes pelirrojos
    assertion(length(FiltradosNo, 19)).  % Hay 19 personajes que no son pelirrojos

% Test para verificar la pregunta del rasgo
test(preguntar_rasgo_hombre) :-
    preguntar_rasgo(hombre),
    current_output(Output),
    set_stream(Output, tty(true)),
    with_output_to(string(S), preguntar_rasgo(hombre)),
    assertion(sub_string(S, _, _, _, '¿El personaje parece hombre? (s/n)')).

:- end_tests(personajes).

% Ejecutar los casos de prueba
:- run_tests.