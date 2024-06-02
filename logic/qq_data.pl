% Definicion de personajes con nombre y caracteristicas

personaje(nombre('herman'), caracteristicas([hombre, pelirrojo, calva, nariz_grande, ojos_marrones, cejas_gruesas])).
personaje(nombre('maria'), caracteristicas([mujer, pelo_largo, sombrero, pendientes, pelo_castano, ojos_marrones, boca_pequena, cejas_finas, nariz_pequena])).
personaje(nombre('claire'), caracteristicas([mujer, gafas, sombrero, pelirrojo, ojos_marrones, boca_pequena, nariz_pequena])).
personaje(nombre('charles'), caracteristicas([hombre, bigote, pelo_rubio, ojos_marrones, labios_gruesos, boca_grande, orejas_grandes, raya_al_lado, nariz_pequena])).
personaje(nombre('richard'), caracteristicas([hombre, calva, barba, ojos_marrones, orejas_grandes, bigote, cara_alargada, nariz_pequena])).
personaje(nombre('eric'), caracteristicas([hombre, pelo_rubio, gorra, sombrero, ojos_marrones, boca_grande, nariz_pequena])).
personaje(nombre('alex'), caracteristicas([hombre, bigote, pelo_negro, ojos_marrones, boca_grande, labios_gruesos, orejas_grandes, pelo_corto, nariz_pequena])).
personaje(nombre('peter'), caracteristicas([hombre, canas, pelo_blanco, nariz_grande, ojos_azules, cejas_gruesas, labios_gruesos, boca_grande, raya_al_lado])).
personaje(nombre('philip'), caracteristicas([hombre, barba, pelo_negro, ojos_marrones, orejas_grandes, mofletes, mejillas_sonrosadas, cejas_finas, pelo_corto, nariz_pequena])).
personaje(nombre('joe'), caracteristicas([hombre, gafas, pelo_rubio, ojos_marrones, boca_pequena, pelo_corto, nariz_pequena])).
personaje(nombre('paul'), caracteristicas([hombre, gafas, pelo_blanco, canas, ojos_marrones, boca_pequena, orejas_grandes, cejas_gruesas, raya_al_lado, nariz_pequena])).
personaje(nombre('david'), caracteristicas([hombre, barba, pelo_rubio, ojos_marrones, orejas_grandes, raya_al_lado, nariz_pequena])).
personaje(nombre('george'), caracteristicas([hombre, cara_triste, sombrero, pelo_blanco, canas, ojos_marrones, boca_grande, nariz_pequena])).
personaje(nombre('frans'), caracteristicas([hombre, pelo_corto, cejas_gruesas, pelirrojo, ojos_marrones, boca_pequena, nariz_pequena])).
personaje(nombre('alfred'), caracteristicas([hombre, bigote, barba, pelirrojo, ojos_azules, boca_pequena, orejas_grandes, pelo_largo, raya_al_medio, nariz_pequena])).
personaje(nombre('bernard'), caracteristicas([hombre, pelo_castano, sombrero, ojos_marrones, boca_pequena, cejas_finas, nariz_grande])).
personaje(nombre('bill'), caracteristicas([hombre, barba, pelirrojo, ojos_marrones, orejas_grandes, mofletes, mejillas_sonrosadas, calva, boca_pequena, nariz_pequena])).
personaje(nombre('anita'), caracteristicas([mujer, pelo_largo, pelo_rubio, ojos_marrones, boca_pequena, mofletes, mejillas_sonrosadas, raya_al_medio, nariz_pequena])).
personaje(nombre('robert'), caracteristicas([hombre, cara_triste, pelo_castano, ojos_azules, orejas_grandes, nariz_grande, raya_al_lado, cara_alargada, mofletes, mejillas_sonrosadas])).
personaje(nombre('anne'), caracteristicas([mujer, pelo_corto, pendientes, pelo_negro, ojos_marrones, boca_pequena, nariz_grande])).
personaje(nombre('sam'), caracteristicas([hombre, gafas, calva, pelo_blanco, canas, ojos_marrones, boca_pequena, nariz_pequena])).
personaje(nombre('tom'), caracteristicas([hombre, gafas, calva, pelo_negro, ojos_azules, boca_pequena, cara_alargada, nariz_pequena])).
personaje(nombre('susan'), caracteristicas([mujer, pelo_largo, pelo_blanco, canas, ojos_marrones, labios_gruesos, mofletes, mejillas_sonrosadas, nariz_pequena, raya_al_lado])).
personaje(nombre('max'), caracteristicas([hombre, bigote, pelo_negro, ojos_marrones, boca_grande, labios_gruesos, nariz_grande, orejas_grandes, pelo_corto])).

% Iniciar juego automaticamente al cargar el archivo
:- initialization(iniciar_juego).

% Predicado principal para jugar
iniciar_juego :-
    writeln('¿Quieres jugar? (s/n)'),
    read_line_to_string(user_input, Respuesta),
    (Respuesta == "s" -> jugar; writeln('¡Hasta luego!')).

% Juego de preguntas
jugar :-
    findall(personaje(nombre(N), caracteristicas(Caracteristicas)), personaje(nombre(N), caracteristicas(Caracteristicas)), TodosPersonajes),
    findall(Caracteristica, (personaje(_, caracteristicas(Caracteristicas)), member(Caracteristica, Caracteristicas)), TodosRasgos),
    list_to_set(TodosRasgos, RasgosUnicos),
    hacer_pregunta(TodosPersonajes, RasgosUnicos).

hacer_pregunta([personaje(nombre(N), _)], _) :-
    format('El personaje es: ~w~n', [N]).
hacer_pregunta(Personajes, Rasgos) :-
    seleccionar_mejor_rasgo(Personajes, Rasgos, MejorRasgo),
    format('¿El personaje tiene ~w? (s/n)~n', [MejorRasgo]),
    read_line_to_string(user_input, Respuesta),
    (Respuesta == "s" -> Resp = s; Resp = n),
    filtrar_personajes(Personajes, MejorRasgo, Resp, NuevosPersonajes),
    delete(Rasgos, MejorRasgo, NuevosRasgos),
    hacer_pregunta(NuevosPersonajes, NuevosRasgos).

% Seleccionar el mejor rasgo (el mas discriminante)
seleccionar_mejor_rasgo(Personajes, Rasgos, MejorRasgo) :-
    maplist(contar_rasgo(Personajes), Rasgos, Contajes),
    min_member(rasco_conteo(_, MejorRasgo), Contajes).

contar_rasgo(Personajes, Rasgo, rasco_conteo(Diferencia, Rasgo)) :-
    include(tiene_rasgo(Rasgo), Personajes, ConRasgo),
    exclude(tiene_rasgo(Rasgo), Personajes, SinRasgo),
    length(ConRasgo, ConCount),
    length(SinRasgo, SinCount),
    Diferencia is abs(ConCount - SinCount).

tiene_rasgo(Rasgo, personaje(_, caracteristicas(Caracteristicas))) :-
    member(Rasgo, Caracteristicas).

% Filtrar personajes por respuesta a un rasgo
filtrar_personajes(Personajes, Rasgo, s, NuevosPersonajes) :-
    include(tiene_rasgo(Rasgo), Personajes, NuevosPersonajes).
filtrar_personajes(Personajes, Rasgo, n, NuevosPersonajes) :-
    exclude(tiene_rasgo(Rasgo), Personajes, NuevosPersonajes).

% Preguntar rasgo género (por cohesión)
preguntar_rasgo(MejorRasgo) :-
    (MejorRasgo == 'masculino' ; MejorRasgo == 'femenino')
    -> format('¿El personaje parece ~w? (s/n)~n', [MejorRasgo])
    ; format('¿El personaje tiene ~w? (s/n)~n', [MejorRasgo]).