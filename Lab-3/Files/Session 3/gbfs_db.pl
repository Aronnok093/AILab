:- dynamic treeNode/2.

treeNode(i, nil).
treeNode(a, i).
treeNode(b, i).
treeNode(d, b).
treeNode(e, b).
treeNode(f, b).
treeNode(g, e).

:- dynamic priorityQueue/1.

priorityQueue([node(g, 0), node(d, 25), node(a, 55)]).

:- dynamic possiblePath/1.

possiblePath([i, b, e, g]).

