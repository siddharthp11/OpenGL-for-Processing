// Matrix Stack Library

// You should modify the routines below to complete the assignment.
// Feel free to define any classes, global variables, and helper routines that you need.

ArrayList<Matrix> mat_stack; // https://docs.oracle.com/javase/8/docs/api/java/util/ArrayList.html

class Matrix {
  int numrows;
  int numcols;
  float[][] values;  // first subscript is row, second subscript is column
  
  // initialize the matrix as the identity
  Matrix() {
    numrows = 4;
    numcols = 4;
    values = new float[4][4];
    for (int i = 0; i < 4; i++)
      for (int j = 0; j < 4; j++)
        if (i == j)
          values[i][j] = 1.0;
        else
          values[i][j] = 0.0;
  }
  
  // initialize the matrix as the zero matrix with the given size
  Matrix(int _numrows, int _numcols) {
    numrows = _numrows;
    numcols = _numcols;
    values = new float[numrows][numcols];
    for (int i = 0; i < numrows; i++) {
      for (int j = 0; j < numcols; j++) {
        values[i][j] = 0.0;
      }
    }
  }
}

Matrix mat_copy(Matrix m) {
  Matrix mat_new = new Matrix(m.numrows, m.numcols);
  
  for (int i = 0; i < m.numrows; i++) {
    for (int j = 0; j < m.numcols; j++) {
      mat_new.values[i][j] = m.values[i][j];
    }
  }

  return mat_new;
}

Matrix mat_multiply(Matrix a, Matrix b) {
  if (a.numcols != b.numrows) {
    println("Invalid matrix sizes. A.numcols = " + a.numcols + " and B.numrows = " + b.numrows);
  }
  Matrix mat_new = new Matrix(a.numrows, b.numcols);
  
  for (int i = 0; i < a.numrows; i++) {
    for (int j = 0; j < b.numcols; j++) {
      mat_new.values[i][j] = 0.0;
      for (int k = 0; k < a.numcols; k++) {
        mat_new.values[i][j] += a.values[i][k] * b.values[k][j]; 
      }
    }
  }  
  return mat_new;
}

Matrix get_ctm() {
  return mat_stack.get(mat_stack.size() - 1);
}

void print_mat(Matrix m) {
  for (int i = 0; i < m.numrows; i++) {
    for (int j = 0; j < m.numcols; j++) {
      print(m.values[i][j] + " ");
    }
    println();
  }
  println();  
}

void print_ctm() {
  Matrix m = mat_stack.get(mat_stack.size() - 1);
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 4; j++) {
      print(m.values[i][j] + " ");
    }
    println();
  }
  println();
}

void print_stack() {
  println("==== Top of Stack ====");
  for (int k = mat_stack.size() - 1; k >= 0; k--) {
    Matrix m = mat_stack.get(k);
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        print(m.values[i][j] + " ");
      }
      println();
    }
    if (k > 0) {
      println();    
    }
  }
  println("======================");
  println();
  
}

void gtInitialize() {
  // Initialize mat_stack and add one matrix After this command is called, the only matrix on the stack should be the 4x4 identity matrix.
  // We will treat the last (= at size() - 1) matrix at the current transformation matrix. 
  mat_stack = new ArrayList<Matrix>();
  mat_stack.add(new Matrix());
}

void gtPopMatrix() {
  // Remove the last element from the matrix stack. Generate the error message "cannot pop the matrix stack" if there is only one matrix in the stack.
  if (mat_stack.size() <= 1) {
    println("cannot pop the matrix stack");
  } else {
    mat_stack.remove(mat_stack.size() - 1);
  }
}

void updateTopMatrix(Matrix m) {
  // Update the top matrix in the stack.
  // Let ctm = the last element in the matrix stack. Then this function should do: new_ctm = old_ctm * matrix_m
  // Hint: useful functions: mat_stack.get, mat_stack.set, mat_multiply
  Matrix mat = mat_stack.get(mat_stack.size() - 1);
  Matrix new_mat = mat_multiply(mat, m);
  mat_stack.set(mat_stack.size() - 1, new_mat);  
}

void gtPushMatrix() {
  // Get the last element from the matrix stack, clone it, and add it to the last position of the stack.
  Matrix mat = mat_stack.get(mat_stack.size() - 1);
  mat_stack.add(mat_copy(mat));
}

void gtTranslate(float x, float y, float z) {
  // Create a translate matrix and update the ctm.
  Matrix m = new Matrix();
  m.values[0][3] = x;
  m.values[1][3] = y;
  m.values[2][3] = z;

  updateTopMatrix(m);
}

void gtScale(float x, float y, float z) {
  // Create a scale matrix and update the ctm.
  Matrix m = new Matrix();
  m.values[0][0] = x;
  m.values[1][1] = y;
  m.values[2][2] = z;  
  
  updateTopMatrix(m);
}

void gtRotateX(float theta) {
  // Create a rotateX matrix and update the ctm. Note that theta is given in degree.
  Matrix m = new Matrix();
  
  theta = theta * PI / 180.0;
  float c = cos(theta);
  float s = sin(theta);
 
  m.values[1][1] = c;
  m.values[1][2] = -s;
  m.values[2][1] = s;
  m.values[2][2] = c;

  updateTopMatrix(m);
}

void gtRotateY(float theta) {
  // Create a rotateY matrix and update the ctm. Note that theta is given in degree.
  Matrix m = new Matrix();
  
  theta = theta * PI / 180.0;
  float c = cos(theta);
  float s = sin(theta);
 
  m.values[0][0] = c;
  m.values[0][2] = s;
  m.values[2][0] = -s;
  m.values[2][2] = c;

  updateTopMatrix(m);
}

void gtRotateZ(float theta) {
  // Create a rotateZ matrix and update the ctm. Note that theta is given in degree.
  Matrix m = new Matrix();
  
  theta = theta * PI / 180.0;
  float c = cos(theta);
  float s = sin(theta);
 
  m.values[0][0] = c;
  m.values[0][1] = -s;
  m.values[1][0] = s;
  m.values[1][1] = c;

  updateTopMatrix(m);
}
