var SoxCommand = require('sox-audio');
var fs = require('fs');
var inputStream = fs.createReadStream('output.wav');
var command = SoxCommand();
command.input(inputStream)
  .inputSampleRate(44100)
  .inputEncoding('signed')
  .inputBits(16)
  .inputChannels(1)
  .inputFileType('raw');

