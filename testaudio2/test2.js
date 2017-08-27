var engine = coreAudio.createNewAudioEngine();
 
// Grab a buffer 
var buffer = engine.read();
 
// Silence the 0th channel 
for( var iSample=0; iSample<inputBuffer[0].length; ++iSample )
    buffer[0][iSample] = 0.0;
 
// Send the buffer back to the sound card 
engine.write( buffer );
