% Example of A* Search
% Including data files
:-use_module(inputGraph).

% Declaration of dynamic data
:-dynamic(treeNode/4).
:-dynamic(treeNodeIndex/1).
:-dynamic(priorityQueue/1).
:-dynamic(possiblePath/1).

% Search begins
startAStar:- write('Enter start node:'),read(S),h_fn(S,HV),assert(treeNodeIndex(1)),
	assert(treeNode(S,0,nil,HV)),assert(priorityQueue([node(S,0,'nil',HV)])),
	assert(possiblePath([])), generate, findPathLength(L), displayResult(L).

% Generating the solution
generate:-priorityQueue([H|_]),H=node(N,I,_,_),h_fn(G,0),N=G, updatePP(N,I),!.
generate:-priorityQueue([H|_]),H=node(N,I,_,_),updateWith(N,I), generate.

% Updating data according to selected node.
updateWith(N,I):-updatePQandTree(N,I), updatePP(N,I).

% Updating Priority Queue and Tree
updatePQandTree(N,I):-priorityQueue(Lst), delFirstElement(Lst,Lst1),
	retract(priorityQueue(_)), assert(priorityQueue(Lst1)), addChildren(N,I).

delFirstElement(Lst,Lst1):-Lst = [_|Lst1].

addChildren(N,I):- neighbor(N,X,D), treeNodeIndex(I1), treeNode(_,I,_,V),
	h_fn(N,V1), h_fn(X,V2),	FNV is V+D-V1+V2,
	insertToPQ(X,I1,I,FNV), assert(treeNode(X,I1,I,FNV)),
	increaseIndex, fail.
addChildren(_,_).

insertToPQ(X,I1,I,FNV):- priorityQueue(Lst),insert12PQ(node(X,I1,I,FNV),Lst,Lst1),
	retract(priorityQueue(_)),assert(priorityQueue(Lst1)).

insert12PQ(El,[], [El]):-!.
insert12PQ(El, L1, L2):-L1=[H|_], El=node(_,_,_,V1), H=node(_,_,_,V2),
       not(V1 > V2), L2 = [El|L1], !.
insert12PQ(El, L1, L2):-L1=[H|T], insert12PQ(El, T, Lx), L2 = [H|Lx].


increaseIndex:-  treeNodeIndex(X), Y is X+1, retract(treeNodeIndex(X)),
	assert(treeNodeIndex(Y)).

% Updating Possible Path
updatePP(N,I):- retract(possiblePath(_)), assert(possiblePath([])), renewPP(N,I).
renewPP(N,I):-treeNode(N,I,nil,_), possiblePath(X), append([N],X,X1),
	retract(possiblePath(_)), assert(possiblePath(X1)), !.
renewPP(N,I):- possiblePath(X), append([N],X,X1), retract(possiblePath(_)),
	assert(possiblePath(X1)),treeNode(N,I,I1,_),treeNode(N1,I1,_,_), renewPP(N1,I1).

% Finding the path length when the optimal solution is found
findPathLength(L):-priorityQueue([H|_]),H=node(_,_,_,L).

% Displaying shortest path and its length
displayResult(L):- possiblePath(Lst), write('Solution:'), write(Lst),nl,
	write('Length:'), write(L).

% Utilities

% List dynamic data
listRecordsAStar:-listing(treeNode), listing(priorityQueue), listing(possiblePath),
	listing(treeNodeIndex).

% Save modified records in place of old ones.
saveRecordsAStar:-tell('AStarDB.pl'), listing(treeNode), listing(priorityQueue),
	listing(possiblePath),told.

%Clear the database
clearDatabaseAStar:-retractall(treeNode(_,_,_,_)), retract(possiblePath(_)),
	retract(priorityQueue(_)),retract(treeNodeIndex(_)).


% Arrange a menu of actions
start:- repeat,
write('\n1. Clear database'),
write('\n2. Execute AStar'),
write('\n3. Display database'),
write('\n4. Save database'),
write('\n5. Exit'),
write('\n\nEnter your choice: '),
read(N), N >0, N < 6,
do(N), N=5,!.

do(1):- clearDatabaseAStar, write('\nDone 1\n').
do(2):- startAStar, write('\nDone 2\n').
do(3):- listRecordsAStar, write('\nDone 3\n').
do(4):- saveRecordsAStar, write('\nDone 4\n').
do(5):- abort.


