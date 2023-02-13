// Test the Projection, Transformation and Line Drawing Routines
void setup() {
  size(750, 750);
  background(255, 255, 255);  // background is white
  stroke(0, 0, 0);            // lines are black
}

void draw() {
}

//  make sure proper error messages get reported when handling key presses
void keyPressed() {
  background (255, 255, 255);
  if (key == '1') {
    ortho_test();
  } else if (key == '2') {
    ortho_test_scale();
  } else if (key == '3') {
    ortho_test_rotate();
  } else if (key == '4') {
    face_test();
  } else if (key == '5') {
    faces();
  } else if (key == '6') {
    ortho_cube();
  } else if (key == '7') {
    ortho_cube2();
  } else if (key == '8') {
    persp_cube();
  } else if (key == '9') {
    persp_multi_cubes();
  } else if (key == '0') {
    draw_yours();
  } else {
    println("Key not recognized: " + key);
  }
}

void draw_yours() {
  // draw your creative design here. The best designs will be used as examples in the next term's class.
  // (TODO)
  gtInitialize();
  println("Please draw your design here!");
  gtOrtho(-100,100,-100,100,-100,00);
  gtBeginShape();
  
  gtVertex(50, 50, 0);
  gtVertex(50,0, 0);
  
  gtVertex(50,0, 0);
  gtVertex(0,20,10);
  
  gtEndShape();
  
  
}


void ortho_test() {
  gtInitialize();
  gtOrtho(-100, 100, -100, 100, -100, 100);
  square();
}

void ortho_test_scale() {
  gtInitialize();
  gtScale(1, 0.5, 1);
  gtOrtho(-100, 100, -100, 100, -100, 100);
  square();
}

void ortho_test_rotate() {
  gtInitialize();
  gtRotateZ(20);
  gtOrtho(-100, 100, -100, 100, -100, 100);
  square();
}

void ortho_cube() {
  gtInitialize();
  gtOrtho(-2, 2, -2, 2, -2, 2);
  gtPushMatrix();
  gtRotateY(17);
  cube();
  gtPopMatrix();
}

void ortho_cube2() {
  gtInitialize();
  gtOrtho(-2, 2, -2, 2, -2, 2);
  gtPushMatrix();
  gtRotateZ(5);
  gtRotateX(25);
  gtRotateY(20);
  cube();
  gtPopMatrix();
}

void persp_cube() {
  gtInitialize();
  gtPerspective(60, 1, 100);
  gtPushMatrix();
  gtTranslate(0, 0, -4);
  cube();
  gtPopMatrix();
}

void persp_multi_cubes() {
  gtInitialize();
  gtPerspective(60, 1, 100);

  gtPushMatrix();
  gtTranslate(0, 0, -20);
  gtRotateZ(5);
  gtRotateX(25);
  gtRotateY(20);

  for (int delta = -12; delta <= 12; delta += 3) {
    gtPushMatrix();
    gtTranslate(delta, 0, 0);
    cube();
    gtPopMatrix();
    gtPushMatrix();
    gtTranslate(0, delta, 0);
    cube();
    gtPopMatrix();
    gtPushMatrix();
    gtTranslate(0, 0, delta);
    cube();
    gtPopMatrix();
  }

  gtPopMatrix();
}

void circle() {
  int steps = 64;
  float xold = 1;
  float yold = 0;
  gtBeginShape();
  for (int i = 0; i <= steps; i++) {
    float theta = 2 * 3.1415926535 * i / (float) steps;
    float x = cos(theta);
    float y = sin(theta);
    gtVertex(xold, yold, 0);
    gtVertex(x, y, 0);
    xold = x;
    yold = y;
  }
  gtEndShape();
}

void square() {
  gtBeginShape();

  gtVertex(-50, -50, 0);
  gtVertex(-50, 50, 0);

  gtVertex(-50, 50, 0);
  gtVertex(50, 50, 0);

  gtVertex(50, 50, 0);
  gtVertex(50, -50, 0);

  gtVertex(50, -50, 0);
  gtVertex(-50, -50, 0);

  gtEndShape();
}


void cube() {
  gtBeginShape();

  // top square

  gtVertex(-1.0, -1.0, 1.0);
  gtVertex(-1.0, 1.0, 1.0);

  gtVertex(-1.0, 1.0, 1.0);
  gtVertex(1.0, 1.0, 1.0);

  gtVertex(1.0, 1.0, 1.0);
  gtVertex(1.0, -1.0, 1.0);

  gtVertex(1.0, -1.0, 1.0);
  gtVertex(-1.0, -1.0, 1.0);

  // bottom square

  gtVertex(-1.0, -1.0, -1.0);
  gtVertex(-1.0, 1.0, -1.0);

  gtVertex(-1.0, 1.0, -1.0);
  gtVertex(1.0, 1.0, -1.0);

  gtVertex(1.0, 1.0, -1.0);
  gtVertex(1.0, -1.0, -1.0);

  gtVertex(1.0, -1.0, -1.0);
  gtVertex(-1.0, -1.0, -1.0);

  // connect the top square to the bottom one

  gtVertex(-1.0, -1.0, -1.0);
  gtVertex(-1.0, -1.0, 1.0);

  gtVertex(-1.0, 1.0, -1.0);
  gtVertex(-1.0, 1.0, 1.0);

  gtVertex(1.0, 1.0, -1.0);
  gtVertex(1.0, 1.0, 1.0);

  gtVertex(1.0, -1.0, -1.0);
  gtVertex(1.0, -1.0, 1.0);

  gtEndShape();
}

void face_test() {
  gtInitialize();
  gtOrtho(0, 1, 0, 1, -1, 1);
  face();
}

void face() {
  // head
  gtPushMatrix();
  gtTranslate(0.5, 0.5, 0);
  gtScale(0.4, 0.4, 1.0);
  circle();
  gtPopMatrix();

  // right eye
  gtPushMatrix();
  gtTranslate(0.7, 0.7, 0.0);
  gtScale(0.1, 0.1, 1.0);
  circle();
  gtPopMatrix();

  // left eye
  gtPushMatrix();
  gtTranslate(0.3, 0.7, 0.0);
  gtScale(0.1, 0.1, 1.0);
  circle();
  gtPopMatrix();

  // nose
  gtPushMatrix();
  gtTranslate(0.5, 0.5, 0.0);
  gtScale(0.07, 0.07, 1.0);
  circle();
  gtPopMatrix();

  // mouth
  gtPushMatrix();
  gtTranslate(0.5, 0.25, 0.0);
  gtScale(0.2, 0.1, 1.0);
  circle();
  gtPopMatrix();
}

// draw four faces
void faces() {
  gtInitialize();

  gtOrtho(0, 1, 0, 1, -1, 1);

  gtPushMatrix();
  gtTranslate(0.75, 0.25, 0.0);
  gtScale(0.5, 0.5, 1.0);
  gtTranslate(-0.5, -0.5, 0.0);
  face();
  gtPopMatrix();

  gtPushMatrix();
  gtTranslate(0.25, 0.25, 0.0);
  gtScale(0.5, 0.5, 1.0);
  gtTranslate(-0.5, -0.5, 0.0);
  face();
  gtPopMatrix();

  gtPushMatrix();
  gtTranslate(0.75, 0.75, 0.0);
  gtScale(0.5, 0.5, 1.0);
  gtTranslate(-0.5, -0.5, 0.0);
  face();
  gtPopMatrix();

  gtPushMatrix();
  gtTranslate(0.25, 0.75, 0.0);
  gtScale(0.5, 0.5, 1.0);
  gtRotateZ(30);
  gtTranslate(-0.5, -0.5, 0.0);
  face();
  gtPopMatrix();
}
