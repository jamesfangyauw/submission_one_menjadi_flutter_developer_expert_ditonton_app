import 'dart:io';

String jsonReader(String fileName) {
  var directory = Directory.current.path;
  var test = '/test';
  var replc = '';
  if (directory.endsWith(test)) {
    directory = directory.replaceAll(test, replc);
  }
  return File('$directory/test/$fileName').readAsStringSync();
}
