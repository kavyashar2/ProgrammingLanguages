#ifndef QUEENS_H
#define QUEENS_H
#include <cmath>

// An abstract chess piece that cannot be instantiated.
class Piece
{
protected:
  int _row, _column;

public:
  virtual ~Piece() {}
  int row() const { return _row; }
  int column() const { return _column; }

  virtual void place(int row, int column)
  {
    _row = row;
    _column = column;
  }

  virtual bool menaces(const Piece *p) const = 0;
};

// A knight can move two squares perpendicularly and one in the other direction.
class Knight
{
public:
  static bool menaces(int row1, int col1, const Piece *p)
  {
    int rows = std::abs(row1 - p->row());
    int cols = std::abs(col1 - p->column());
    return (rows == 2 && cols == 1) || (rows == 1 && cols == 2);
  }
};

// A rook can move any number of spaces horizontally or vertically.
class Rook
{
public:
  static bool menaces(int row1, int col1, const Piece *p)
  {
    int rows = std::abs(row1 - p->row());
    int cols = std::abs(col1 - p->column());
    return rows == 0 || cols == 0;
  }
};

// A bishop can move any number of squares diagonally.
class Bishop
{
public:
  static bool menaces(int row1, int col1, const Piece *p)
  {
    int rows = std::abs(row1 - p->row());
    int cols = std::abs(col1 - p->column());
    return rows == cols;
  }
};

// A queen can move as a rook or as a bishop.
class Queen : public Piece
{
  Rook r;
  Bishop b;

public:
  void place(int row, int column) override
  {
    _row = row;
    _column = column;
  }

  bool menaces(const Piece *p) const override
  {
    return Rook::menaces(_row, _column, p) || Bishop::menaces(_row, _column, p);
  }
};

// An amazon can move as a knight or as a queen.
class Amazon : public Piece
{
  Knight k;
  Queen q;

public:
  void place(int row, int column) override
  {
    _row = row;
    _column = column;
    q.place(row, column);
  }

  bool menaces(const Piece *p) const override
  {
    return Knight::menaces(_row, _column, p) || q.menaces(p);
  }
};

#endif /* QUEENS_H */