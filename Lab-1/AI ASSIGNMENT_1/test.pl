
parent(adam, eve).
parent(adam, cain).
parent(eve, abel).
parent(eve, seth).
parent(cain, enoch).
parent(cain, irad).
parent(seth, noah).
parent(seth, shem).
parent(seth, ham).

male(adam).
male(cain).
male(abel).
male(seth).
male(enoch).
male(irad).
male(noah).
male(shem).
male(ham).

female(eve).
female(seth).

% Rules to define family relationships
sibling(X, Y) :- parent(Z, X), parent(Z, Y), X \= Y.

brother(X, Y) :- sibling(X, Y), male(X).

sister(X, Y) :- sibling(X, Y), female(X).

uncle(X, Y) :- parent(Z, Y), brother(X, Z).

aunt(X, Y) :- parent(Z, Y), sister(X, Z).

grandparent(X, Z) :- parent(X, Y), parent(Y, Z).

findGp :- write(' Grandchild To Grandparent: '), read(X), write('Grandparent: '),
grandparent(Gc,X),write(Gc),tab(5),fail.
findGp.
