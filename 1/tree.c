/* Kavya Sharma | CSEN 171 | Assignment 1 */

/*
 * Reads a list of integers from standard input and inserts them into
 * a binary search tree.  Then, reads a list of integers from standard
 * input and checks if each integer is present in the tree.  Both
 * lists are terminated by -1.
 */

#include <stdio.h>
#include <stdlib.h>

typedef struct node *tree;

struct node
{
  int data;
  tree left;
  tree right;
};

/*
 * Inserts an integer into the specified binary search tree.  If the
 * integer is already present in the tree, then the tree is unchanged.
 * If the tree is NULL, then a single node is created as the tree.
 * Otherwise, a new node is created at the appropriate place in the
 * tree.  The root of the subtree is returned.
 */

tree insert(tree root, int value)
{
  if (root == NULL)
  {
    root = malloc(sizeof(struct node));
    root->left = NULL;
    root->right = NULL;
    root->data = value;
  }
  else if (value < root->data)
  {
    root->left = insert(root->left, value);
  }
  else if (value > root->data)
  {
    root->right = insert(root->right, value);
  }

  return root;
}

/*
 * Returns nonzero if the value is found in the specified binary
 * search tree.  If the value is not found then zero is returned.
 */

int member(tree root, int value)
{
  if (root == NULL)
    return 0;

  if (value < root->data)
    return member(root->left, value);

  if (value > root->data)
    return member(root->right, value);

  return 1;
}

int maximum(tree root)
{
  while (root->right != NULL)
    root = root->right;

  return root->data;
}

void deallocate(tree root)
{
  if (root == NULL)
    return;

  deallocate(root->left);
  deallocate(root->right);
  free(root);
}

int main(void)
{
  tree t;
  int x;

  t = NULL;
  scanf("%d", &x);

  while (x != -1)
  {
    t = insert(t, x);
    scanf("%d", &x);
  }

  scanf("%d", &x);

  while (x != -1)
  {
    printf("%s\n", member(t, x) ? "TRUE" : "FALSE");
    scanf("%d", &x);
  }

  printf("Maximum value: %d\n", maximum(t));
  deallocate(t);

  return 0;
}
