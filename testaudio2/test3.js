var SoxCommand = require('sox-audio');
var fs = require('fs');
var command2 = SoxCommand()
  .input('|pacat --record -d alsa_output.pci-0000_00_14.2.analog-stereo.monitor ')
  .output(fs.createWriteStream('utterance_2.wav'))
  .output('-p')
  .outputFileType('wav');
