/* Kavya Sharma | CSEN 171 | Assignment 1 */

#include <stdio.h>
#define HIGH 8

typedef int numbers[HIGH];
numbers a;

/* type declaration for the comparison function: */
typedef int (*comparator)(int x, int y);

/* only used in main() */
static void readarray(void)
{
  int i;
  for (i = 0; i < HIGH; i++)
    scanf("%d", &a[i]);
}

/* only used in main() */
static void writearray(void)
{
  int i;
  for (i = 0; i < HIGH; i++)
    printf("%d\n", a[i]);
}

/* used only by partition, so should be static */
static void exchange(int *a, int *b)
{
  int t;
  t = *a;
  *a = *b;
  *b = t;
}

/* used only by quicksort, so should be static */
static int partition(numbers a, int y, int z, comparator cmp)
{
  int i, j, x;

  x = a[y];
  i = y - 1;
  j = z + 1;

  while (i < j)
  {
    do
      j = j - 1;
    while (cmp(a[j], x) > 0);

    do
      i = i + 1;
    while (cmp(a[j], x) < 0);

    if (i < j)
      exchange(&a[i], &a[j]);
  }

  return j;
}

/* modify the quicksort function to accept a comparison function as an additional parameter and use the comparison function when comparing two values in the array */
void quicksort(numbers a, int m, int n, comparator cmp)
{
  int i;

  if (n > m)
  {
    i = partition(a, m, n, cmp);
    quicksort(a, m, i, cmp);
    quicksort(a, i + 1, n, cmp);
  }
}

/* comparison function */
static int ascending(int x, int y)
{
  return x - y;
}

int main(void)
{
  readarray();
  quicksort(a, 0, HIGH - 1, ascending);
  writearray();
  return 0;
}
