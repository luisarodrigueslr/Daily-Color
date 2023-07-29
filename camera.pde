import processing.video.*; //Biblioteca de vídeo

Capture cam;
String[ ] listaCameras; //Câmaras disponíveis
PImage panoramica; //Imagem que a câmara transmite
int corAtiva; //Cores nos objetos



colorObject [] detectors = new colorObject[5]; //Detectar cor de 5 objetos


void setupCamera() {
  listaCameras = Capture.list(); //Lista das câmaras disponíveis
  cam = new Capture(this, listaCameras[0]); //Câmera a usar
  cam.start(); //Começar a câmara
  panoramica = new PImage(640, 360, RGB); //dimensões da câmara + indicação para mostrar em cores em vez de preto em branco
  corAtiva = 0;

  // iniciar o relógio
  detectors[0] = new colorObject(); //Objeto
  detectors[0].setColor(color(65, 125, 170)); //cor
  detectors[0].setTolerancia(20); //tolerância

  // iniciar o sapatilhas
  detectors[1] = new colorObject(); //Objeto
  detectors[1].setColor(color(255, 0, 0)); //cor
  detectors[1].setTolerancia(20); //tolerância

  // iniciar o caderno
  detectors[2] = new colorObject(); //Objeto
  detectors[2].setColor(color(0, 255, 0)); //cor
  detectors[2].setTolerancia(20); //tolerância

  // iniciar o colher
  detectors[3] = new colorObject(); //Objeto
  detectors[3].setColor(color(255, 255, 0)); //cor
  detectors[3].setTolerancia(20); //tolerância

  // iniciar o escova de dentes
  detectors[4] = new colorObject(); //Objeto
  detectors[4].setColor(color(255, 0, 255)); //cor
  detectors[4].setTolerancia(20); //tolerância
}

void updateCamera() {
  if (cam.available() == true) { //Confirma que a câmara está disponível
    cam.read(); //Mostra a imagem que a câmara  transmite
  }

  panoramica.copy(cam, 0, 60, 640, 360, 0, 0, 640, 360); //

  // Atualizar a informacao dos detetores
  for (int i = 0; i < detectors.length; i = i +1) {
    detectors[i].detetectColor();
  }
}

void desenhaCamera() {
  background(255, 0, 255); //cor de fundo
  cursor(ARROW); //O rato de computador tem o formato de uma seta
  
      for (int i = 0; i < detectors.length; i = i +1) {
        sounds[i].amp(0); //Som desativado no modo de câmara
      }

  image(panoramica, 10, 10, panoramica.width, panoramica.height); //Posição da imagem da câmara


  // Desenhar informacao dos detetores
  for (int i = 0; i < detectors.length; i = i +1) {
    detectors[i].drawColor();
  }


  // Desenho das cores
  for (int i = 0; i < detectors.length; i = i +1) {
    fill(detectors[i].cor); //Preenche com as cores ativas
    if (i == corAtiva) stroke(255); //Se a cor for correspondente a uma cor ativa o contorno é da cor branca
    else stroke(0); //Se a cor não corresponder a uma cor ativa o contorno é da cor preta
    rect(100 * i, height - 100, 50, 50); //Quadrados que demonstra as cores
    fill(0); //Texto em preto
    text(detectors[i].tolerancia, 100 * i, height - 100); //Tolerância escrita
  }
}
