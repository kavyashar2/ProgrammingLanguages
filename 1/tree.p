(*
  Kavya Sharma | CSEN 171 | Assignment 1
*)

(*
    Reads a list of integers from standard input and inserts them into
    a binary search tree.  Then, reads a list of integers from standard
    input and checks if each integer is present in the tree.  Both
    lists are terminated by -1.
*)
program BinarySearchTree(input, output);
  type
    tree = ^node;
    node = record
      data : integer;
      left : tree;
      right : tree
    end;

  (*
Inserts an integer into the specified binary search tree.  If the
integer is already present in the tree, then the tree is unchanged.
If the tree is nil, then a single node is created as the tree.
Otherwise, a new node is created at the appropriate place in the
tree.
  *)
  procedure insert(var root : tree; value : integer);
    begin

      { create a new tree with a single node }
      if root = nil then
        begin
          new(root);
          root^.left := nil;
          root^.right := nil;
          root^.data := value;
        end

      { check if the value lies to the left of the current root }
      else if value < root^.data then
        insert(root^.left, value)

      { check if the value lies to the right of the current root }
      else if value > root^.data then
        insert(root^.right, value)
    end;


  (*
    Returns true if the value is found in the specified binary
search tree.  If the value is not found then false is
returned.
  *)
  function member(root : tree; value : integer) : boolean;
    begin
      { the subtree is empty, so the value was not found }
      if root = nil then
        member := false

      { the value may be in the left subtree }
      else if value < root^.data then
        member := member(root^.left, value)

      { the value may be in the right subtree }
      else if value > root^.data then
        member := member(root^.right, value)

      { the value was found }
      else
        member := true
    end;

  function maximum(root : tree) : integer;
    begin
      if root = nil then
        halt(1);

      while root^.right <> nil do
        root := root^.right;

      maximum := root^.data;
    end;

  procedure deallocate(var root : tree);
    begin
      if root <> nil then
        begin
          deallocate(root^.left);
          deallocate(root^.right);
          dispose(root);
          root := nil;
        end;
    end;

  var t : tree;
  var x : integer;

  begin
    t := nil;
    readln(x);

    while x <> -1 do begin
      insert(t, x);
      read(x)
    end;

    readln(x);
    while x <> -1 do begin
      writeln(member (t, x));
      read(x)
    end

    writeln('Maximum value: ', maximum(t));
    deallocate(t);
  end.
