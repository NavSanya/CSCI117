deal([],[],[]).
deal([X|Xs],[X|Ys], Z):-
    deal(Xs,Z,Ys).

merg([],Ys,Ys).
merg(Xs,[],Xs).
merg([X|Xs],[Y|Ys],[X|Zs]):- X=<Y,merg(Xs,[Y|Ys],Zs).
merg([X|Xs],[Y|Ys],[X|Zs]):- X>Y, merg([X|Xs],Ys,Zs).

ms([], []).
ms(X, X).
ms(Xs, YS):-deal(Xs,N,M), merg(MN,MM,YS), ms(N,MN), ms(M,MM).

% mode (+,+,-)
% ?- snoc([1,2,3],5,X) // X = [1,2,3,5]
% mode (+,-,+)
% ?- snoc([1,2,3],X,[1,2,3,5]) // X = 5
% mode (-,+,+)
% ?- snoc(X,5,[1,2,3,5]) // X = [1,2,3]
% mode (-,-,+)
% ?- snoc(X,Y,[1,2,3,5]) // X = [1, 2, 3], Y = 5
snoc([],X,X).
snoc([Y|Ys], X, [Y|Z]) :- snoc(Ys,X,Z).

% mode (+,+,-)
% ?- cons(snoc(snoc(nil,3),4),5,X) // X = snoc(snoc(snoc(nil, 5), 3), 4)
% mode (+,-,+)
% ?- cons(snoc(snoc(nil,3),4),X,snoc(snoc(snoc(nil, 5), 3), 4)) // X = 5
% mode(-,+,+)
% ?- cons(X,5,snoc(snoc(snoc(nil, 5), 3), 4)) // X = snoc(snoc(nil, 3), 4)
% mode (-,-,+)
% ?- cons(X,Y,snoc(snoc(snoc(nil, 5), 3), 4)) // X = snoc(snoc(nil, 3), 4), // Y = 5
% mode (-,+,-)
cons(E, nil, snoc(nil,E)).
cons(E, snoc(BL,N), snoc(EBL,N)) :- cons(E, BL, EBL).

% mode (+,-)
% ?- toBList([5,6,7],X) // X = snoc(snoc(snoc(nil, 5), 6), 7)
toBList([],nil).
toBList([X|Xs],Z) :- toBList(Xs,BL), cons(X,BL,Z).

% mode (+,-)
% ?- fromBList(snoc(snoc(snoc(nil, 5), 6), 7),X) // X = [5,6,7]
fromBList(nil, []).
fromBList(snoc(X,Y), Zs) :- fromBList(X,Xs), snoc(Xs, Y, Zs).

% mode (+,-)
% ?- num_emp(node(4,empty, empty),X). // X = 2
num_emp(empty, 1).
num_emp(node(_,L,R), N) :- num_emp(L,NL), num_emp(R,NR), N is NL + NR.

% mode (+,+,-)
% ?- insert_left(node(4,empty,empty),6,X) // X = node(4, node(6, empty, empty), empty)
% mode (+,-,+)
% ?- insert_left(node(4,empty,empty),X,node(4, node(6, empty, empty), empty)) // X = 6
% mode (-,+,+)
% ?- insert_left(X,6,node(4, node(6, empty, empty), empty)) // X = node(4, empty, empty)
% mode (-,-,+)
% ?- insert_left(X,Y,node(4, node(6, empty, empty), empty)) // X = node(4,empty,empty), Y = 6
insert_left(NN, empty, (node(NN,empty,empty))).
insert_left(NN, (node(BT, L, R)), (node(BT, IL, R))):- insert_left(NN, L, IL).

% mode (+,+,-)
% ?- insert_right(node(4,empty,empty),6,X) // X = node(4, empty, node(6, empty, empty))
% mode (+,-,+)
% insert_right(node(4,empty,empty),X,node(4, empty, node(6, empty, empty))) // X = 6
% mode (-,+,+)
% insert_right(X,6,node(4, empty, node(6, empty, empty))) // X = node(4, empty, empty)
% mode (-,-,+)
% insert_right(X,Y,node(4, empty, node(6, empty, empty))) // X = node(4, empty, empty), Y = 6
insert_right(NN, empty, (node(NN, empty, empty))).
insert_right(NN, (node(BT, L, R)), (node(BL, L, IR))):-insert_right(NN, R, IR).


% mode (+,-)
% ?- sum_nodes(node(4,(node(3, empty, empty)),empty),X) // X = 7
sum_nodes(empty,0).
sum_nodes(node(A,L,R), N) :- sum_nodes(L,NL),sum_nodes(R, NR), N is NL + NR + A. 

% mode (+,-)
% ?- inorder(node(4, empty, node(6, empty, empty)),X) // X = [4,6]
% mode (-,+)
% ?- inorder(X, [4, 6]) // X = node(4, empty, node(6, empty, empty))
inorder(empty, []).
inorder(node(BT,L,R), ([[INL|BT]|INR])):-inorder(L,INL), inorder(R,INR).

% mode(+,-)
% num_elts(node2(9,leaf(2),leaf(4)),X)
num_elts(empty,0).
num_elts(node(_,L,R),N):- num_elts(L,NL), num_elts(R,NR), N is NL + NR + 1.

% mode (+,-)
% ?- sum_nodes2(node2(1,leaf(5),leaf(3)),X) // X = 9
sum_nodes2(leaf(E),E).
sum_nodes2(node2(A,L,R),S):- sum_nodes2(L,NL),sum_nodes2(R,NR), S is A + NL + NR.

% mode (+,-)
% inorder2((node2(3,leaf(5),leaf(6))),Out) // Out = [5, 3, 6]
% mode (-,+)
% inorder2(Out,[5, 3, 6]) // Out = node2(3, leaf(5), leaf(6))
inorder2(leaf(X), [X]).
inorder2((node2(BT,L,R)),([[IN2L|BT]|IN2R])):-inorder2(L,IN2L), inorder2(R,IN2R).

% mode (-,+)
% conv21(X, node(3, node(5, empty, empty), node(6, empty, empty))) // X = node2(3,leaf(5),leaf(6))
% mode (+,-)
% conv21(node2(3,leaf(5),leaf(6)),X) // X = node(3, node(5, empty, empty), node(6, empty, empty))
conv21((left(X)),(node(X,empty,empty))).
conv21((node(BT,L,R)),(node(BT,CL,CR))):-conv21(L,CL),conv21(R,CR).

% mode (+,-)
% ?- num_nodes(node(4,(node(3, empty, empty)),empty),X) // X = 2
num_nodes(leaf(N), 0).  
num_nodes(node2(N,L,R),S) :- num_nodes(L,NL), num_nodes(R,NR), S is 1 + NL + NR. 


num_leaves(leaf(N), 1).  
num_leaves(node2(N,L,R),S) :- num_leaves(L,NL), num_leaves(R,NR), S is NL + NR. 

% mode (+,-)
% ?- toBList_it([5,6,7],X) // X = snoc(snoc(snoc(nil, 5), 6), 7)
toBList_it(T, N) :- toBList_help([T], nil, N).
toBList_help([], A, A).
toBList_help([T|Ts], A, snoc(A,T)) :- toBList_help(Ts, A, N).

% mode (+,-)
% ?- fromBList_it(snoc(snoc(snoc(nil, 5), 6), 7),X) // X = [5,6,7]
fromBList_it(B, N):- fromBList_help(B,[],N).
fromBList_help(nil, A,A).
fromBList_help(snoc(X,Y),A,N):- fromBList_help(X,[Y|A],N).

% mode (+,-)
% ?- sum_nodes_it(node(4,(node(3, empty, empty)),empty),X) // X = 7
sum_nodes_it(T, N) :- sum_help([T], 0, N).
sum_help([], A, A).
sum_help([empty|Ts], A, N) :- sum_help(Ts, A, N).
sum_help([node(E,L,R)|Ts], A, N) :- AE is A + E, sum_help([L,R|Ts], AE, N).

% mode (+,-)
% ?- num_empties_it(node(4,empty, empty),X) // X = 2
num_empties_it(T, N) :- num_empties_help([T], 0, N).
num_empties_help([], A, A).
num_empties_help([empty|Ts], A, N) :- AE is A + 1, num_empties_help(Ts, AE, N).
num_empties_help([node(E,L,R)|Ts], A, N) :- num_empties_help([L,R|Ts], A, N).	

%  mode (+,-)
% ?- num_nodes_it(node(4,(node(3, empty, empty)),empty),X) // X = 2
num_nodes_it(T, N) :- num_nodes_help([T], 0, N).
num_nodes_help([], A, A).
num_nodes_help([empty|Ts], A, N) :- num_nodes_help(Ts, A, N).
num_nodes_help([node(E,L,R)|Ts], A, N) :- AE is A + 1, num_nodes_help([L,R|Ts], AE, N).

% mode (+,-)
% ?- sum_nodes2_it((node2(3,leaf(5),leaf(6))),Out) // X = 14
sum_nodes2_it(T, N) :- sum2_help([T], 0, N).
sum2_help([], A, A).
sum2_help([leaf(T)|Ts], A, N) :- AE is A + T,  sum2_help(Ts, AE, N).
sum2_help([node2(E,L,R)|Ts], A, N) :- AE is A + E, sum2_help([L,R|Ts], AE, N).

 mode (+,-)
% bst(node(10,node(8,empty,node(9,empty,empty)), node(11,empty,node(12,empty,empty))),X) // X = true
comp(neginf, fin(_)).
comp(fin(_),posinf).
comp(fin(X),fin(Z)):- X<Z.

bst(empty,true).
bst(T, B):- bst_help(T, neginf, posinf, B).
bst_help(empty,_,_,B).
bst_help(node(V,L,R),Lo,Hi,B):-comp(Lo,fin(V)),comp(fin(V),Hi),bst_help(L,Lo,fin(V),B),bst_help(R,fin(V),Hi,B).

 mode (+,-)
% bst2(node2(10,node2(8,empty,node2(9,empty,empty)), node2(11,empty,node(12,empty,empty))),X) // X = false
comp2(neginf, fin()). 
comp2(fin(),posinf). 
comp2(fin(X),fin(Z)) :- X<Z.

bst2(T, B):- bst2_help(T, neginf, posinf, B).
bst2_help(leaf(V),Lo,Hi,B) :- comp2(Lo,fin(V)), comp2(fin(V),Hi).
bst2_help((node2(V,L,R)),Lo,Hi,B):-comp2(Lo,fin(V)), comp2(fin(V),Hi),bst2_help(L,Lo,fin(V),B),bst2_help(R,fin(V),Hi,B).