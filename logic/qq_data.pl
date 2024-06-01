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

% Verifica si un pj tiene un rasgo en concreto
pj_tiene_rasgos(nombre, rasgo) :-
    pj(nombre, Rasgos), member(rasgo, Rasgos).
