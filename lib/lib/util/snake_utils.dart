import 'package:path_provider/path_provider.dart';

class SnakeUtils {
  static Future<String> getFileUrl(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    return "${directory.path}/$fileName";
  }
}
