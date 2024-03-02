import 'package:image_picker/image_picker.dart';

Future<bool> validFileSize({required XFile filepath}) async {
  // Calcula o tamanho do arquivo
  int bytes = await filepath.length();

  // Valida o arquivo invalido
  if (bytes <= 0) return false;

  // Verifica o tamanho
  double image = bytes / (1024 * 1024);

  // Arquivo maior que o permitido que é 2mb
  if (image >= 2) return false;

  return true;
}
