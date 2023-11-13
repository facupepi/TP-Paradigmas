%Usuarios(nombre-apellido, DNI)
usuario("Ana Maria", 123).
usuario("Hernesto Gutierrez", 456).
usuario("Federido Alabasta",789).

%Autor
autor("Gustov pulisqui").
autor("Puluszi Zostroski").
autor("Prestikov Slok").

%Libros(Nombre,autor)
libro("El principito", "Gustov pulisqui").
libro("Romeo y julieta", "Puluszi Zostroski").
libro("Don quijote", "Prestikov Slok").

%Temas
tema("El principito", aventura).
tema("Romeo y julieta", romance).
tema("Romeo y julieta", tragedia).
tema("Romeo y julieta", drama).
tema("Don quijote", aventura).
tema("Don quijote", comedia).


%prestamos
prestamo("Ana Maria", "El principito").
prestamo("Ana Maria", "Romeo y julieta").

%reglas

%Mostrar prestamos actuales
librosEnPrestamo(Libro):-
    prestamo(_,Libro), libro(Libro,_).

%Mostrar Usuarios con prestamo
usuariosConPrestamos(Usuario,Libro):-
    usuario(Usuario,_), prestamo(Usuario,Libro).

%Filtrar libros por Tema
librosPorTema(Tema, Libro):-
    tema(Libro,Tema), libro(Libro, _).

%Filtrar libros por autor
librosPorAutor(Autor,Libro):-
    autor(Autor), libro(Libro,Autor). 



%¿Funciones?
mostrar_todos_usuarios :-
    usuario(Nombre, DNI), %Regla que usaremos
    format('Usuario: ~w, DNI: ~w~n', [Nombre, DNI]),nl, %Dar formato al texto impreso
    %[~w se usa para referenciar una "variable" en el texto, esta luego se referencia entre corchetes]
    fail. % Forzar el backtracking para encontrar más soluciones
mostrar_todos_usuarios.

libros_en_prestamo:-
    librosEnPrestamo(Libro),
    format('Libro: ~w',[Libro]),nl,
    fail.
libros_en_prestamo.

usuarios_con_prestamo(Usuario):-
    usuariosConPrestamos(Usuario, Libro),
    format('Usuario: ~w Libro: ~w~n',[Usuario,Libro]),nl,
    fail.
usuarios_con_prestamo(_).

filtrar_por_tema(Tema):-
    librosPorTema(Tema,Libro),
    format('Libro: ~w',[Libro]),nl,
    fail.
filtrar_por_tema(_).

filtrar_por_autor(Autor):-
    librosPorAutor(Autor,Libro),
    format('Libro: ~w',[Libro]),nl,
    fail.
filtrar_por_autor(_).


%:- menu_principal.
menu :-
    repeat,
    write("----------------------------------------------------"),nl,
    write('1- Mostrar Usuarios'), nl,
    write('3- Mostrar Autores'), nl,
    write('4- Mostrar temas'), nl,
    write('5- Consultar usuarios con prestamos'), nl,
    write('6- Consultar coleccion por tema'), nl,
    write('7- Consultar coleccion por Autor'), nl,
    write('8- Consultar libros no prestamos'), nl,
    write('0- Salir'), nl,
    write("----------------------------------------------------"),nl,
    write('Ingrese su eleccion: '),
    read(Opcion),nl,
    procesar_opcion(Opcion),
    Opcion == 0, !.

%Mostrar usuarios
procesar_opcion(1) :-
    write("----------------------------------------------------"),nl,
    mostrar_todos_usuarios,nl,
    write("----------------------------------------------------"),nl,
    write("Pulse una tecla para continuar"),
    read(_).
%Mostrar prestamos actuales
procesar_opcion(2) :-
    write("----------------------------------------------------"),nl,
    libros_en_prestamo, nl,
    write("----------------------------------------------------"),nl,
    write("Pulse una tecla para continuar"),
    read(_).
%Consultar por prestamos
procesar_opcion(3) :-
    write("----------------------------------------------------"),nl,
    write("Ingrese el usuario entre comillas para una consulta concreta, sino ingrese X"),
    read(Usuario),nl,
    usuarios_con_prestamo(Usuario), nl,
    write("----------------------------------------------------"),nl,
    write("Pulse una tecla para continuar"),
    read(_).
%Consultar libros por tema
procesar_opcion(4) :-
    write("----------------------------------------------------"),nl,
    write("Ingrese un tema, para ver la coleccion de libros"),
    read(Tema),nl,
    filtrar_por_tema(Tema), nl,
    write("----------------------------------------------------"),nl,
    write("Pulse una tecla para continuar"),
    read(_).
%Consultar libros por autor
procesar_opcion(5) :-
    write("----------------------------------------------------"),nl,
    write("Ingrese un Autor entre comillas, para ver sus obras"),
    read(Autor),nl,
    filtrar_por_autor(Autor), nl,
    write("----------------------------------------------------"),nl,
    write("Pulse una tecla para continuar"),
    read(_).
procesar_opcion(0) :-
    write('Saliendo del menú.'), nl.

:- menu().