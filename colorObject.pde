class colorObject {

  color cor;
  int tolerancia;
  int currentX, currentY, minimumX, maximumX, minimumY, maximumY, largura, altura, area;
  boolean colorDetected;

  colorObject() {
    cor = color(0);
    tolerancia = 0;
    currentX = -1; //não deteta a cor em x
    currentY = -1; //não deteta a cor em y
    minimumX = 1000000;
    maximumX = -1;
    minimumY = 1000000;
    maximumY = -1;
    area = -1;
    colorDetected = false;
  }

  void setColor(color c) {
    cor = c;
  }

  void setTolerancia(int t) {
    tolerancia = t;
  }



  void detetectColor() {
    // RESET
    currentX = -1; //não deteta a cor em x
    currentY = -1; //não deteta a cor em y
    minimumX = 1000000;
    maximumX = -1;
    minimumY = 1000000;
    maximumY = -1;
    area = -1;
    colorDetected = false;
    
    int pixelCounter = 0;

    for (int x = 0; x < panoramica.width; x++) //Loops through all pixels in the video and checks the color of each one against x
      for (int y = 0; y < panoramica.height; y++) //Loops through all pixels in the video and checks the color of each one against y
      {
        color pixelColor = panoramica.get(x, y); //Gets the current pixel color

        if (red(pixelColor) > red(cor) - tolerancia && red(pixelColor) < red(cor) + tolerancia && green(pixelColor) > green(cor)-tolerancia && green(pixelColor) < green(cor)+tolerancia && blue(pixelColor)>blue(cor)-tolerancia &&  blue(pixelColor)<blue(cor)+tolerancia)
        {
          currentX = currentX + x; //Coordenada x do pixel atual
          currentY = currentY + y; //Coordenada y do pixel atual
          pixelCounter =  pixelCounter + 1; //Contagem dos pixeis
          colorDetected = true; //A cor foi detetada

          if (x > maximumX) maximumX = x;
          else if (x < minimumX) minimumX = x;

          if (y > maximumY) maximumY = y;
          else if (y < minimumY) minimumY = y;
        }
      }

    if (currentX > -1) {
      currentX = currentX / pixelCounter;
      currentY = currentY / pixelCounter;

      largura = maximumX - minimumX;
      altura = maximumY - minimumY;
      area = largura * altura;
    }
  }

  void drawColor() {
    if (currentX > -1) {
      fill(cor);
      circle(currentX, currentY, 30);
      noFill();
      stroke(cor);
      rect(minimumX, minimumY, largura, altura);
    }
  }
}
