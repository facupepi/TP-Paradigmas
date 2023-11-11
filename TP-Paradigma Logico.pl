% Hechos de lectores
lector(nombre("Ana", "Garrido", "Aguirre"), mujer, 31).
lector(nombre("Marta", "Cantero", "Lasa"), mujer, 20).
lector(nombre("Rodrigo", "Duque", "Soto"), hombre, 30).

% Regla para comprobar si hay lectores
hay_lectores :- lector(_, _, _).

% Regla para obtener la lista de todos los lectores
quienes_son_lectores(Lectores) :- findall(Nombre, lector(nombre(Nombre, _, _), _, _), Lectores).

% Regla para obtener la lista de lectores mujeres
lectores_mujeres(Lectores) :- findall(Nombre, lector(nombre(Nombre, _, _), mujer, _), Lectores).

% Regla para obtener la lista de lectores hombres
lectores_hombres(Lectores) :- findall(Nombre, lector(nombre(Nombre, _, _), hombre, _), Lectores).

% Regla para comprobar si hay lectores con el mismo nombre y diferentes apellidos
mismo_nombre_dif_apellidos :- lector(nombre(Nombre, Apellido1, _), _, _),
                              lector(nombre(Nombre, Apellido2, _), _, _),
                              Apellido1 \= Apellido2.

% Regla para comprobar si unos apellidos están repetidos
apellidos_repetidos(Apellido) :- findall(Nombre, lector(nombre(Nombre, Apellido, _), _, _), Nombres),
                                 contar_elementos(Nombres, Contador),
                                 Contador > 1.

% Hechos de libros prestados
prestado(libro("Misericordia", autor("Benito", "Pérez", "Galdós"), persona("Almudena", "Alegría", "Sol"))).

% Regla para comprobar si un lector tiene algún libro prestado
lector_con_libro_prestado(Lector) :- lector(nombre(Nombre, Apellido, _), _, _),
                                      prestado(libro(_, _, persona(Nombre, Apellido, _))).

% Regla para comprobar si un libro está prestado a alguien
libro_prestado_a(libro(Titulo, autor(Autor, _, _)), persona(Nombre, Apellido, _)) :- prestado(libro(Titulo, autor(Autor, _, _), persona(Nombre, Apellido, _))).

% Regla para comprobar si una persona es un escritor
es_escritor(Autor) :- autor(_, _, persona(_, _, Autor)).

% Regla para comprobar si un escritor es leído
escritor_leido(Autor) :- autor(_, _, persona(_, _, Autor)),
                        lector_con_libro_prestado(persona(_, _, Autor)).

% Regla para comprobar si existen autores leídos
autores_leidos(Autores) :- findall(Autor, escritor_leido(Autor), Autores).

% Regla para comprobar que un escritor es leído si algún libro suyo está prestado
escritor_leido_si_libro_prestado(Autor) :- autor(_, _, persona(_, _, Autor)),
                                          prestado(libro(_, autor(Autor, _, _), _)).
