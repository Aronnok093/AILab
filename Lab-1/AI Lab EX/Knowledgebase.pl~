parent('Hasib' , 'Rakib').
parent('Rakib' , 'Sohel').
parent('Rakib' , 'Rebeka').
parent('Rashid' , 'Hasib').
grandparent(X, Z) :- parent(X, Y), parent(Y, Z).
grandchild(Gc, X) :- grandparent(X, Gc).

findGp :- write(' Grandchild: '), read(Gc), write('Grandparent: '),
grandchild(Gc, Gp), write(Gp), tab(5), fail.
findGp.
