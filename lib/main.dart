// import 'package:flutter/material.dart';
// import 'package:get/get_navigation/src/root/get_material_app.dart';
// import 'package:hive_experiment/images%20storing%20and%20retriving/image_input_page.dart';

// import 'package:hive_flutter/adapters.dart';
// import 'package:path_provider/path_provider.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   final appDocumentDir = await getApplicationDocumentsDirectory();
//   await Hive.initFlutter(appDocumentDir.path);
//   await Hive.openBox('images');
//   await Hive.openBox('audios');

//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       home: ImageInputPage(),
//     );
//   }
// }
//------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_experiment/2nd%20try/ui.dart';
import 'package:hive_experiment/all_input.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDirectory.path);
  await Hive.openBox('mediaBox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: MediaInputPage(),
    );
  }
}
