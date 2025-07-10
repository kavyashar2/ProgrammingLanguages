(* a tree is either empty or is a node consisting of
   a left subtree, a value, and a right subtree *)
   
datatype 'a tree = empty | node of ('a tree * 'a * 'a tree);


(* member = fn : int tree -> int -> bool
   Returns true if an integer is in the specified tree and false otherwise *)

fun member empty x = false
  | member (node(l, d, r)) x =
	if x < d then
	    member l x
	else if x > d then
	    member r x
  else
      true;


(* insert = fn : int tree -> int -> int tree
   Returns a tree that is the result of inserting an integer into a tree *)

fun insert empty x = node (empty, x, empty)
  | insert (t as node(l, d, r)) x =
	if x < d then
	    node(insert l x, d, r)
	else if x > d then
	    node(l, d, insert r x)
  else
      t;


(* build = fn : int list -> int tree
   Returns a tree that is result of inserting all integers in the given list *)

val build = foldl (fn (v,t) => insert t v) empty;


(* inorder = fn : 'a tree -> 'a list
   Returns a list that contains all values in the tree in order *)

fun inorder empty = []
  | inorder (node(l, d, r)) = inorder l @ d :: inorder r;

exception Empty

fun maximum Empty = raise Empty
  | maximum (Node (v, _, Empty)) = v
  | maximum (Node (_, _, right)) = maximum right