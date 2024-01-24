import 'package:encrypt/encrypt.dart';

String encrypt(String plaintext) {
  final key = Key.fromUtf8('7jKjRG4h8Uzt9AmA0PGip3xucxudrAxX');
  final iv = IV.fromLength(16);

  final encrypter = Encrypter(AES(key));

  final encrypted = encrypter.encrypt(plaintext, iv: iv);

  return encrypted.base64;
}
