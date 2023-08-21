import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';

// void runModule(List<String> arguments) async {
//   final parser = ArgParser()
//     ..addMultiOption('module',
//         abbr: 'm', help: 'Name of Flutter Module to Run');
// /*
//   final results = parser.parse(arguments);
//   final module = results['module'][0];

//   if (module.isEmpty) {
//     log("Please provide module name to run");
//     return;
//   }
//   // await run("cd $module");
//   await run("flutter run -t lib/main.dart");
//   */

//   createConfig(arguments);
// }

void createConfig(List<String> arguments) {
  final parser = ArgParser()
    ..addMultiOption('module',
        abbr: 'm', help: 'Name of Flutter Module to Run');
  final results = parser.parse(arguments);

  if (results['module'].isEmpty) {
    print('\x1B[33mPlease provide module name to run\x1B[0m');
    return;
  }

  final module = results['module'][0];
  // Path to the VS Code workspace settings file
  final workspacePath = Directory.current.path;
  final settingsFilePath = '$workspacePath/.vscode/launch.json';

  // Check if the .vscode directory exists, create it if not
  final vscodeDir = Directory('$workspacePath/.vscode');
  if (!vscodeDir.existsSync()) {
    vscodeDir.createSync();
  }

  // Check if launch.json file exists, create it if not
  final settingsFile = File(settingsFilePath);
  if (!settingsFile.existsSync()) {
    settingsFile.createSync();
    settingsFile
        .writeAsStringSync('{ "version": "0.2.0", "configurations": [] }');
  }

  // Read existing configurations
  final settingsContent = settingsFile.readAsStringSync();
  final Map<String, dynamic> launchConfig =
      Map.from(json.decode(settingsContent));
  final List<dynamic> configurations = launchConfig['configurations'];

  // Check if Flutter run configuration already exists
  final existingConfigIndex =
      configurations.indexWhere((config) => config['name'] == 'Flutter');
  if (existingConfigIndex != -1) {
    print('Flutter run configuration already exists.');
    return;
  }

  // Create a new Flutter run configuration
  final newConfig = {
    "name": "$module",
    "request": "launch",
    "type": "dart",
    // "program": "lib/main.dart",
    // "args": [],
    // "flutterMode": "run",
    // "cwd": "\${workspaceFolder}",
    // "env": {
    //   "FLUTTER_HOME": "/path/to/flutter"
    // }, // Replace with actual Flutter SDK path
    // "deviceId": "",
  };

  configurations.add(newConfig);

  // Write the updated configurations back to launch.json
  settingsFile.writeAsStringSync(json.encode(launchConfig));
  print('Flutter run configuration added.');
}
