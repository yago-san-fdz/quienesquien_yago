% Definición de cada pj con sus rasgos
pj(herman, [hombre, cabello_rojo, calvo, nariz_grande, ojos_marrones, cejas_gruesas]).
pj(maria, [mujer, cabello_largo, sombrero, pendientes, cabello_castaño, ojos_marrones, boca_pequeña, cejas_delgadas, nariz_pequeña]).
pj(claire, [mujer, gafas, sombrero, cabello_rojo, ojos_marrones, boca_pequeña, nariz_pequeña]).
pj(charles, [hombre, bigote, rubio, ojos_marrones, labios_gruesos, boca_grande, orejas_grandes, patillas, nariz_pequeña]).
pj(richard, [hombre, calvo, barba, ojos_marrones, orejas_grandes, bigote, rostro_largo, nariz_pequeña]).
pj(eric, [hombre, rubio, gorra, sombrero, ojos_marrones, boca_grande, nariz_pequeña]).
pj(alex, [hombre, bigote, cabello_negro, ojos_marrones, boca_grande, labios_gruesos, orejas_grandes, cabello_corto, nariz_pequeña]).
pj(peter, [hombre, cabello_gris, cabello_blanco, nariz_grande, ojos_azules, cejas_gruesas, labios_gruesos, boca_grande, patillas]).
pj(philip, [hombre, barba, cabello_negro, ojos_marrones, orejas_grandes, mejillas, mejillas_rosadas, cejas_delgadas, cabello_corto, nariz_pequeña]).
pj(joe, [hombre, gafas, rubio, ojos_marrones, boca_pequeña, cabello_corto, nariz_pequeña]).
pj(paul, [hombre, gafas, cabello_blanco, cabello_gris, ojos_marrones, boca_pequeña, orejas_grandes, cejas_gruesas, patillas, nariz_pequeña]).
pj(david, [hombre, barba, rubio, ojos_marrones, orejas_grandes, patillas, nariz_pequeña]).
pj(george, [hombre, rostro_triste, sombrero, cabello_blanco, cabello_gris, ojos_marrones, boca_grande, nariz_pequeña]).
pj(frans, [hombre, cabello_corto, cejas_gruesas, cabello_rojo, ojos_marrones, boca_pequeña, nariz_pequeña]).
pj(alfred, [hombre, bigote, barba, cabello_rojo, ojos_azules, boca_pequeña, orejas_grandes, cabello_largo, cabello_medio, nariz_pequeña]).
pj(bernard, [hombre, cabello_castaño, sombrero, ojos_marrones, boca_pequeña, cejas_delgadas, nariz_grande]).
pj(bill, [hombre, barba, cabello_rojo, ojos_marrones, orejas_grandes, mejillas, mejillas_rosadas, calvo, boca_pequeña, nariz_pequeña]).
pj(anita, [mujer, cabello_largo, rubio, ojos_marrones, boca_pequeña, mejillas, mejillas_rosadas, cabello_medio, nariz_pequeña]).
pj(robert, [hombre, rostro_triste, cabello_castaño, ojos_azules, orejas_grandes, nariz_grande, patillas, rostro_largo, mejillas, mejillas_rosadas]).
pj(anne, [mujer, cabello_corto, pendientes, cabello_negro, ojos_marrones, boca_pequeña, nariz_grande]).
pj(sam, [hombre, gafas, calvo, cabello_blanco, cabello_gris, ojos_marrones, boca_pequeña, nariz_pequeña]).
pj(tom, [hombre, gafas, calvo, cabello_negro, ojos_azules, boca_pequeña, rostro_largo, nariz_pequeña]).
pj(susan, [mujer, cabello_largo, cabello_blanco, cabello_gris, ojos_marrones, labios_gruesos, mejillas, mejillas_rosadas, nariz_pequeña, patillas]).
pj(max, [hombre, bigote, cabello_negro, ojos_marrones, boca_grande, labios_gruesos, nariz_grande, orejas_grandes, cabello_corto]).


% Verifica si un personaje tiene un rasgo en concreto
pj_tiene_rasgo(Nombre, Rasgo) :-
    pj(Nombre, Rasgos),
    member(Rasgo, Rasgos).

% Calcular la frecuencia de cada rasgo en una lista de personajes
frecuencia_rasgos([], []).
frecuencia_rasgos([H|T], Frecuencias) :-
    frecuencia_rasgos(T, FrecT),
    pj(H, Rasgos),
    contar_rasgos(Rasgos, FrecT, Frecuencias).

contar_rasgos([], Frecuencias, Frecuencias).
contar_rasgos([R|RT], Frecuencias, Resultado) :-
    incrementar_frecuencia(R, Frecuencias, FrecTemp),
    contar_rasgos(RT, FrecTemp, Resultado).

incrementar_frecuencia(R, [], [(R, 1)]).
incrementar_frecuencia(R, [(R, N)|T], [(R, N1)|T]) :-
    N1 is N + 1.
incrementar_frecuencia(R, [H|T], [H|T1]) :-
    H \= (R, _),
    incrementar_frecuencia(R, T, T1).

% Seleccionar el mejor rasgo (excluyendo el género en la primera pregunta)
mejor_rasgo([Rasgo], Rasgo, _).
mejor_rasgo([R|T], MejorRasgo, Primera) :-
    mejor_rasgo(T, MejorR, Primera),
    pj_tiene_rasgo_count(R, CountR),
    pj_tiene_rasgo_count(MejorR, CountMejor),
    (Primera, (R == hombre; R == mujer) -> MejorRasgo = MejorR
    ; abs(CountR - 50) < abs(CountMejor - 50) -> MejorRasgo = R
    ; MejorRasgo = MejorR).

pj_tiene_rasgo_count(Rasgo, Count) :-
    findall(Nombre, pj_tiene_rasgo(Nombre, Rasgo), Lista),
    length(Lista, Count).

% Iniciar el juego
iniciar_juego :-
    write('Piensa en un personaje y presiona enter cuando estés listo.'), nl,
    read_line_to_string(user_input, _),
    pj_list(Personajes),
    hacer_preguntas(Personajes, true).

% Hacer preguntas al usuario
hacer_preguntas(Personajes, Primera) :-
    frecuencia_rasgos(Personajes, Frecuencias),
    mejores_preguntas(Frecuencias, MejoresRasgos),
    mejor_rasgo(MejoresRasgos, MejorRasgo, Primera),
    preguntar(MejorRasgo, Personajes, Primera).

preguntar(Rasgo, Personajes, Primera) :-
    format('¿El personaje tiene el rasgo ~w? (s/n)', [Rasgo]), nl,
    read_line_to_string(user_input, Respuesta),
    ( Respuesta = "s" -> incluir_rasgo(Personajes, Rasgo, NuevosPersonajes) ; excluir_rasgo(Personajes, Rasgo, NuevosPersonajes) ),
    ( NuevosPersonajes = [Unico] -> write('Tu personaje es: '), write(Unico), nl
    ; hacer_preguntas(NuevosPersonajes, false) ).

incluir_rasgo(Personajes, Rasgo, NuevosPersonajes) :-
    findall(Nombre, (member(Nombre, Personajes), pj_tiene_rasgo(Nombre, Rasgo)), NuevosPersonajes).

excluir_rasgo(Personajes, Rasgo, NuevosPersonajes) :-
    findall(Nombre, (member(Nombre, Personajes), \+ pj_tiene_rasgo(Nombre, Rasgo)), NuevosPersonajes).

pj_list(Lista) :- findall(Nombre, pj(Nombre, _), Lista).