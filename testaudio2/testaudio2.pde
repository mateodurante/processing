import ddf.minim.*;
Minim minim;
 
//this is the object that plays your file
AudioPlayer player;
 
void setup()
{
  size(300, 300);
 
  //initialize minim
  minim = new Minim(this);
 
  // loadFile will look in all the same places as loadImage does.
  // this means you can find files that are in the data folder and the 
  // sketch folder. you can also pass an absolute path, or a URL.
  // mp3, wav, ogg should all work
  player = minim.loadFile("output.wav");
 
  // play the file
  player.play();
}
 
void draw()
{
 background(0);
 
  //check if the reproduction is in process
  if ( player.isPlaying() )
  {
    text("The player is playing.", 5, 15);
  }
  else
  {
    text("The player is not playing.", 5, 15);
  }
}
 
//replay the file if the mouse is pressed
void mousePressed()
{
  //it's weird but you have to rewind a file to play it
  player.rewind();
  player.play();
}
 
//stop is called when you hit stop on processing. Just leave this here
void stop()
{
  player.close();
  minim.stop();
  super.stop();
}