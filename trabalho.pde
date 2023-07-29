import processing.sound.*; //Biblioteca de Som
import processing.video.*; //Biblioteca de Vídeo

Movie[] videos = new Movie[5];
SoundFile[] sounds = new SoundFile[5];
float [] opacities = new float[5]; 
float [] jumpTime = new float[5];

void setupTrabalho() {
  for (int i = 0; i < 5; i++) //Loop to view and initialize the files and configure them to start from the beginning
  {
    videos[i] = new Movie(this, "video" + i + ".mp4"); //Ficheiros de som
    videos[i].loop(); //Video começa
    sounds[i] = new SoundFile(this, "sound" + i + ".mp3"); //Ficheiros de som
    sounds[i].loop();
    sounds[i].amp(0);
  }
}


void desenhaTrabalho() {
  background(0, 0, 0); //Fundo
  noCursor(); //Remove o cursor do Output

  for (int i = 0; i < 5; i++) //Loop to view and initialize the files and configure them to start from the beginning
  {
    if (videos[i].available() == true) { //Se vídeo estiver disponível
      videos[i].read(); //Mostra vídeo
    }
    jumpTime[i] = map(detectors[i].currentX, 0, panoramica.width, 0, videos[i].duration()); //Conforme o movimento em X o vídeo avança ou recua
    videos[i].jump(jumpTime[i]);


    opacities[i] = map(detectors[i].currentY, 0, panoramica.height, 0, 255); //Conforme o movimento em Y o vídeo muda a opacidade do filtro
    tint(255, 255, 255, opacities[0]);
    image(videos[i], 0, 0);
    noTint();

    float playbackSpeed = map(detectors[i].currentY, 0, panoramica.height, 0.5, 4.0);


    float amplitude = map(detectors[i].area, 0, panoramica.width*panoramica.height/16, 0, 1.0);
    sounds[i].amp(amplitude);
  }


  // Desenhar informacao dos detetores
  for (int i = 0; i < detectors.length; i = i +1) {
    detectors[i].drawColor();
  }
}
