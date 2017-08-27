import ddf.minim.analysis.*;
import ddf.minim.*;
import processing.serial.*;

Serial myPort;
Minim minim;
AudioInput input;
FFT fft;
String windowName;

char val2;
char val5;
char val8;

void setup()
{
  frameRate(60);
  size(512, 200, P3D);
  //textMode(SCREEN);
  //myPort = new Serial(this, Serial.list()[1], 38400);
  minim = new Minim(this);
 
  input = minim.getLineIn(minim.MONO, 2048);
 
  // create an FFT object that has a time-domain buffer
  // the same size as jingle's sample buffer
  // note that this needs to be a power of two
  // and that it means the size of the spectrum
  // will be 512. see the online tutorial for more info.
  fft = new FFT(input.bufferSize(), input.sampleRate());
 
  textFont(createFont("Arial", 16));
 
  windowName = "None";
}

void set_fan_led(int addr, int led, char val)
{
  char serial_cmd[] = {0x00,(char)led,(char)addr,val,0xFF};
  for(int i = 0; i < 5; i++)
  {
    //myPort.write(serial_cmd[i]);
  }
}

void fan_update_leds(int addr)
{
  final char serial_cmd[] = {0x00,0x0C,(char)addr,0x01,0xFF};
  for(int i = 0; i < 5; i++)
  {
    //myPort.write(serial_cmd[i]);
  }
}

void draw()
{
  background(0);
  stroke(255);
  // perform a forward FFT on the samples in jingle's left buffer
  // note that if jingle were a MONO file,
  // this would be the same as using jingle.right or jingle.left
  fft.forward(input.mix);
 
  val2 = (char)(exp(fft.getBand(150))-1);
  val5 = (char)(exp(fft.getBand(160))-1);
  val8 = (char)(exp(fft.getBand(170))-1);
 
  set_fan_led(0x10, 0x10, val2);
  set_fan_led(0x10, 0x11, val5);
  set_fan_led(0x10, 0x12, val8);
 
  set_fan_led(0x10, 0x13, val2);
  set_fan_led(0x10, 0x14, val5);
  set_fan_led(0x10, 0x15, val8);
 
  set_fan_led(0x10, 0x16, val2);
  set_fan_led(0x10, 0x17, val5);
  set_fan_led(0x10, 0x18, val8);
 
  set_fan_led(0x10, 0x19, val2);
  set_fan_led(0x10, 0x1A, val5);
  set_fan_led(0x10, 0x1B, val8);
 
  set_fan_led(0x11, 0x10, val2);
  set_fan_led(0x11, 0x11, val5);
  set_fan_led(0x11, 0x12, val8);
 
  set_fan_led(0x11, 0x13, val2);
  set_fan_led(0x11, 0x14, val5);
  set_fan_led(0x11, 0x15, val8);
 
  set_fan_led(0x11, 0x16, val2);
  set_fan_led(0x11, 0x17, val5);
  set_fan_led(0x11, 0x18, val8);
 
  set_fan_led(0x11, 0x19, val2);
  set_fan_led(0x11, 0x1A, val5);
  set_fan_led(0x11, 0x1B, val8);
  
  set_fan_led(0x12, 0x10, val2);
  set_fan_led(0x12, 0x11, val5);
  set_fan_led(0x12, 0x12, val8);
 
  set_fan_led(0x12, 0x13, val2);
  set_fan_led(0x12, 0x14, val5);
  set_fan_led(0x12, 0x15, val8);
 
  set_fan_led(0x12, 0x16, val2);
  set_fan_led(0x12, 0x17, val5);
  set_fan_led(0x12, 0x18, val8);
 
  set_fan_led(0x12, 0x19, val2);
  set_fan_led(0x12, 0x1A, val5);
  set_fan_led(0x12, 0x1B, val8);
 
  fan_update_leds(0x10);
  fan_update_leds(0x11);
  fan_update_leds(0x12);
  //for(int i = 0; i < fft.specSize(); i++)
  //{
     //draw the line for frequency band i, scaling it by 4 so we can see it a bit better
  //  line(i, height, i, height - fft.getBand(i)*4);
  //  print(fft.getBand(i));
  //}
  fill(255);
  // keep us informed about the window being used
  //text("The window being used is: " + windowName, 5, 20);
}
 
void keyReleased()
{
  if ( key == 'w' )
  {
    // a Hamming window can be used to shape the sample buffer that is passed to the FFT
    // this can reduce the amount of noise in the spectrum
    fft.window(FFT.HAMMING);
    windowName = "Hamming";
  }
 
  if ( key == 'e' )
  {
    fft.window(FFT.NONE);
    windowName = "None";
  }
}
 
void stop()
{
  // always close Minim audio classes when you finish with them
  input.close();
  minim.stop();
 
  super.stop();
}