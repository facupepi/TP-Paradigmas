%:- use_module('menu.pl', [menu_principal/0, ejecutar_opcion/1, mostrar_lista/1, imprimir_lista/1]). % Carga el módulo del menú y sus predicados
% Predicados de interfaz
menu_principal :-
    repeat,
    write('--- Menu Principal ---\n'),
    write('1. Mostrar todos los lectores\n'),
    write('2. Mostrar lectores mujeres\n'),
    write('3. Mostrar lectores hombres\n'),
    write('4. Comprobar si hay lectores con el mismo nombre y diferentes apellidos\n'),
    write('5. Comprobar si unos apellidos están repetidos\n'),
    write('6. Mostrar lectores con libros prestados\n'),
    write('7. Mostrar libros prestados\n'),
    write('8. Comprobar si un escritor es leído\n'),
    write('9. Mostrar autores leidos\n'),
    write('10. Comprobar si un escritor es leido si algun libro suyo esta prestado\n'),
    write('11. Salir\n'),
    write('Seleccione una opcion: '),
    read(Opcion),
    ejecutar_opcion(Opcion),
    (Opcion = 11; Opcion = -1), !.



ejecutar_opcion(1) :- quienes_son_lectores(Lectores), mostrar_lista(Lectores).
ejecutar_opcion(2) :- lectores_mujeres(Lectores), mostrar_lista(Lectores).
ejecutar_opcion(3) :- lectores_hombres(Lectores), mostrar_lista(Lectores).
ejecutar_opcion(4) :- mismo_nombre_dif_apellidos, writeln('Sí hay lectores con el mismo nombre y diferentes apellidos').
ejecutar_opcion(5) :- write('Ingrese apellidos a verificar: '), read(Apellidos), apellidos_repetidos(Apellidos), writeln('Sí hay apellidos repetidos').
ejecutar_opcion(6) :- lector_con_libro_prestado(Lector), writeln(Lector).
ejecutar_opcion(7) :- findall(Libro, prestado(Libro), Libros), mostrar_lista(Libros).
ejecutar_opcion(8) :- write('Ingrese el nombre del escritor: '), read(Autor), escritor_leido(Autor), writeln('Sí es leído').
ejecutar_opcion(9) :- autores_leidos(Autores), mostrar_lista(Autores).
ejecutar_opcion(10) :- write('Ingrese el nombre del escritor: '), read(Autor), escritor_leido_si_libro_prestado(Autor), writeln('Sí es leído si algún libro suyo está prestado').
ejecutar_opcion(11) :- writeln('Saliendo del programa').
%ejecutar_opcion(_) :- writeln('Opción no válida. Intente de nuevo.').

mostrar_lista([]) :- writeln('No hay elementos en la lista.').
mostrar_lista(Lista) :- writeln('Elementos en la lista:'), imprimir_lista(Lista).

imprimir_lista([]).
imprimir_lista([H|T]) :- writeln(H), imprimir_lista(T).



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

% Inicia el programa
:- menu_principal.
