import ddf.minim.*; 
import ddf.minim.signals.*; 

  
Minim minim; 
AudioPlayer groove; 
  
void setup() 
{ 
  size(512, 200, P3D); 
  
  minim = new Minim(this); 
  groove = minim.loadFile("http://m1.liveatc.net/einn_high", 2048); 
  
  println("Connection Successful!"); 
  // see the example Recordable >> addListener for more about this 
} 
  
void draw() 
{ 
  background(0); 
  // see waveform.pde for an explanation of how this works 
} 
  
void keyPressed() 
{ 
  if ( key == 'p' ) groove.play(); 
} 
  
void stop() 
{ 
  // always close Minim audio classes when you are done with them 
  groove.close(); 
  // always stop Minim before exiting. 
  minim.stop(); 
  
  super.stop(); 
}