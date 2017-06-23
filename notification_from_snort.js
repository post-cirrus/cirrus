var Tail = require('always-tail');
var fs = require('fs');
var filename = "/var/log/snort/alert";
var file = "/tmp/notified"
var apiKey = 'gOFtbLCyflctFI3rcpaXQah37jULAwfA72TX6zkMbn_'
var IFTTTMaker = require('iftttmaker')(apiKey);


if (!fs.existsSync(filename)) fs.writeFileSync(filename, "");
 
var tail = new Tail(filename, '\n');
 
tail.on('line', function(data) {
  // console.log("got line:", data);
  if (data.indexOf("Facebook") > -1 || data.indexOf("Twitter") > -1) {
  //  if (!fs.existsSync(file)) {
  //     fs.openSync(file, 'w');
       IFTTTMaker.send('cirrus', data).then(function () {
         console.log('Request was sent:', data);
       }).catch(function (error) {
         console.log('The request could not be sent:', error);
       });
  //  }
  }
});
 
tail.on('error', function(data) {
  console.log("error:", data);
});
 
tail.watch();
console.log("Starting tailing file ", filename);
