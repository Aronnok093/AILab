% Example of Greedy Best First Search
% Including data files
:-use_module(inputGraph).

% Declaration of dynamic data
:-dynamic(treeNode/2).
:-dynamic(priorityQueue/1).
:-dynamic(possiblePath/1).


% Search begins
startGBF:-write('Enter start node:'), read(S), h_fn(S,HV),
	assert(treeNode(S, 'nil')),assert(priorityQueue([node(S,HV)])),
	assert(possiblePath([])), generate, findPathLength(L), displayResult(L).

% Generating the solution
generate:-priorityQueue([H|_]), H=node(N,_), N=g, addToPP(g),!.
generate:-priorityQueue([H|_]), H=node(N,_), updateWith(N), generate.

% Adding a node to possible path
addToPP(N):-possiblePath(Lst), append(Lst,[N],Lst1), retract(possiblePath(_)),
	assert(possiblePath(Lst1)).

% Updating data according to selected node.
updateWith(N):-updatePQandTree(N), updatePP(N).

% Updating Priority Queue and Tree
updatePQandTree(N):-priorityQueue(Lst), delFirstElement(Lst,Lst1),
	retract(priorityQueue(_)), assert(priorityQueue(Lst1)), addChildren(N).

delFirstElement(Lst,Lst1):-Lst = [_|Lst1].

addChildren(N):- neighbor(N,X,_), not(treeNode(X,_)), insertToPQ(X),
	assert(treeNode(X,N)),fail.
addChildren(_).

% Inserting node to Priority Queue
insertToPQ(X):- priorityQueue(Lst), h_fn(X,V), insert12PQ(node(X,V),Lst,Lst1),
	retract(priorityQueue(_)), assert(priorityQueue(Lst1)).

insert12PQ(El,[], [El]):-!.
insert12PQ(El, L1, L2):-L1=[H|_], El=node(_,V1), H=node(_,V2),
	not(V1 > V2), L2 = [El|L1], !.
insert12PQ(El, L1, L2):-L1=[H|T], insert12PQ(El, T, Lx), L2 = [H|Lx].

% Updating Possible Path
updatePP(N):- retract(possiblePath(_)), assert(possiblePath([])), renewPP(N).
renewPP(N):-treeNode(N,nil), possiblePath(X), append([N],X,X1),
	retract(possiblePath(_)), assert(possiblePath(X1)), !.
renewPP(N):- possiblePath(X), append([N],X,X1), retract(possiblePath(_)),
	assert(possiblePath(X1)), treeNode(N,N1), renewPP(N1).

% Finding 'shortest' path length
findPathLength(L):-possiblePath(Lst),pathLength(Lst,L).
pathLength(Lst,0):- Lst=[g|_],!.
pathLength(Lst,L):-Lst=[N|T],T=[N1|_], neighbor(N,N1,D), pathLength(T,L1),L is L1+D.

% Displaying 'shortest' path and its length
displayResult(L):- possiblePath(Lst), write('Solution:'), write(Lst),nl,
	write('Length:'), write(L).


% Utilities

% List dynamic data
listRecordsGBF:-listing(treeNode), listing(priorityQueue), listing(possiblePath).

% Save modified records in place of old ones.
saveRecordsGBF:-tell('gbfs_db.pl'), listing(treeNode), listing(priorityQueue),
	listing(possiblePath),told.

%Clear the database
clrDatabaseGBF:-retractall(treeNode(_,_)), retractall(possiblePath(_)),
	retractall(priorityQueue(_)).


% Arrange a menu of actions
start:- repeat,
write('\n1. Clear database'),
write('\n2. Execute GBFS'),
write('\n3. Display database'),
write('\n4. Save database'),
write('\n5. Exit'),
write('\n\nEnter your choice: '),
read(N), N >0, N < 6,
do(N), N=5,!.

do(1):- clrDatabaseGBF, write('\nDone 1\n').
do(2):- startGBF, write('\nDone 2\n').
do(3):- listRecordsGBF, write('\nDone 3\n').
do(4):- saveRecordsGBF, write('\nDone 4\n').
do(5):- abort.
