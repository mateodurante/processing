import ddf.minim.*;
import ddf.minim.analysis.*;
import processing.serial.*;

AudioInput input;
 
Minim minim;
AudioPlayer sample;
FFT fftLog;

Serial myPort;
String[] ports=Serial.list();
String leds="0.0.0\n";
int value=0;
float avg = 0.0;
 
void setup(){
  size(500,500,P3D);
  minim=new Minim(this);
  //sample=minim.loadFile("output.wav",1024); 
   
  //sample.play();
  input = minim.getLineIn(minim.MONO, 2048);
   
  fftLog=new FFT(input.bufferSize(),input.sampleRate()); 
  //fftLog.logAverages(1,1);
  fftLog.logAverages(22,1);
  for (int i=0;i<ports.length;i++)
    print(ports[i]);
  myPort = new Serial(this, ports[0], 9600);
  //esperamos a que el arduino inicie y se sincronice el serial
  delay(1000);
}

void draw(){
  background(0);
  fftLog.forward(input.mix);
  camera(300,-300,300,0,0,0,0,1,0);
  avg = fftLog.getAvg(0);
  box(40,avg*10,40);
  value = constrain(int(avg * 30), 0, 255);
  leds="r"+value+"g"+value+"b"+value+".";
  //println(fftLog.getAvg(0));
  //println(leds);
  myPort.write(leds);
  
//  String s = myPort.readString();
//  println(s);
   
}