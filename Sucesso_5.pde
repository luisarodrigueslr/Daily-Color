boolean showCamera; //Mostrar câmera ou vídeo
PFont minhaFont; //Fonte

void setup() {
  size(1280, 720); //Tamanho da janela
  fullScreen();
  showCamera = true; //Câmara ativa
  setupCamera(); //Input
  setupTrabalho(); //Output

  minhaFont = loadFont("ArialMT-24.vlw"); //Fonte da Tolerância
  textFont(minhaFont, 24); //Tamanho da Fonte
}

void draw() {

  updateCamera(); //Atualiza o que é demonstardo pela câmara

  if (showCamera == true) desenhaCamera(); //Se câmara estiver ativa mostra Input
  else desenhaTrabalho(); //Se câmara estiver ativa mostra Output
}

void keyPressed() {
  if (key == ' ') showCamera = !showCamera; //Altera os valores da câmara
  if (keyCode == RIGHT) corAtiva = corAtiva  + 1; //Definir a posição da cor
  if (keyCode == LEFT) corAtiva = corAtiva -  1; //Definir a posição da cor
  corAtiva = constrain(corAtiva, 0, detectors.length-1); //Quantidade de quadrados das cores ativas

  if (keyCode == UP) detectors[corAtiva].tolerancia = detectors[corAtiva].tolerancia + 1; //Aumenta a tolerância da cor
  if (keyCode == DOWN) detectors[corAtiva].tolerancia = detectors[corAtiva].tolerancia -  1; //Diminui a tolerância da cor
  detectors[corAtiva].tolerancia = constrain( detectors[corAtiva].tolerancia, 0, 100); //Valor mínimo (0) e Valor máximo (100) tolerância
}

void mousePressed() {
  detectors[corAtiva].cor = get(mouseX, mouseY); //Seleciona as cores a detectar
}
