import processing.net.*;
import processing.serial.*;

Serial myPort;
String[] ports=Serial.list();

String HTTP_GET_REQUEST = "GET /";
String HTTP_HEADER = "HTTP/1.0 200 OK\r\nContent-Type: text/html\r\n\r\n";

Server s;
Client c;
String request;
String all_data[];
int r;
int g;
int b;
int redPos;
int greenPos;
int bluePos;
String leds = "r0g0b0.";

void setup() 
{
  s = new Server(this, 8080); // start server on http-alt
  myPort = new Serial(this, ports[0], 9600);
  //esperamos a que el arduino inicie y se sincronice el serial
  delay(1000);
}

void draw() 
{
  // Receive data from client
  c = s.available();
  if (c != null) {
    try{
      request = c.readString(); 
      request = request.substring(0, request.indexOf("\n"));  // Only up to the newline
      redPos = request.indexOf("red=");
      greenPos = request.indexOf("green=");
      bluePos = request.indexOf("blue=");
      print(bluePos);
      print(request.length());
      r = int(request.substring(redPos+4, greenPos-1));
      g = int(request.substring(greenPos+6, bluePos-1));
      b = int(request.substring(bluePos+5, request.length()));
      println(request);
      print(r);
      print(g);
      print(b);
      
      leds = "r"+r+"g"+g+"b"+b+".";
      myPort.write(leds);
      
      c.write(HTTP_HEADER);  // answer that we're ok with the request and are gonna send html
      s.disconnect(c);
      c=null;
    } catch (Exception e) {
      println("nadie vio nada eh");
    }
  }
}