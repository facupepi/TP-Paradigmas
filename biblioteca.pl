% Hechos de lectores
lector("Ana", 31, mujer).
lector("Marta", 20, mujer).
lector("Rodrigo", 30, hombre).

% Hechos de libros
libro("El principito", "Antoine").
libro("Introduccion a la Programacion", "Omega").
libro("Fisica Universitaria", "Sears").

% Hechos de prestamos
prestamo("Ana", "El principito").
prestamo("Rodrigo", "Introduccion a la Programacion").

% Predicados de interfaz
menu_principal :-
    repeat,
    write('--- Menu Principal ---\n'),
    write('1. Mostrar todos los lectores\n'),
    write('2. Mostrar lectores mujeres\n'),
    write('3. Mostrar lectores hombres\n'),
    write('4. Mostrar lectores con prestamos vigentes\n'),
    write('5. Mostrar libros en prestamo\n'),
    write('Seleccione una opcion: '),
    read(Opcion),
    ejecutar_opcion(Opcion),
    (Opcion = 6; Opcion = 0), !.

ejecutar_opcion(1) :- quienes_son_lectores(Lectores), mostrar_lista(Lectores).
ejecutar_opcion(2) :- lectores_por_genero(mujer, Lectores), mostrar_lista(Lectores).
ejecutar_opcion(3) :- lectores_por_genero(hombre, Lectores), mostrar_lista(Lectores).
ejecutar_opcion(4) :- lector_con_libro_prestado(Lector), writeln(Lector).
ejecutar_opcion(5) :- libros_prestados(Libros), mostrar_lista(Libros).

mostrar_lista([]) :- writeln('No hay elementos en la lista.').
mostrar_lista(Lista) :- imprimir_lista(Lista).
imprimir_lista([]).
imprimir_lista([H|T]) :- writeln(H), imprimir_lista(T).

quienes_son_lectores(Lectores) :- findall(Nombre, lector(Nombre, _, _), Lectores).

lectores_por_genero(Genero, Lectores) :- findall(Nombre, lector(Nombre, _, Genero), Lectores).

lector_con_libro_prestado(Lector) :- prestamo(Lector, _).

libros_prestados(Libros) :- findall(Libro, prestamo(_, Libro), Libros).

% Inicia el programa
:- menu_principal.

