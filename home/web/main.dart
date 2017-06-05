import 'dart:html';

void main() {
  querySelector('#test').text = 'Your Dart app is running.';
  querySelector('#test').classes.add('test');
}
