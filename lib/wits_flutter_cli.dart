import 'dart:developer';

import 'package:args/args.dart';
import 'package:process_run/process_run.dart';

void runModule(List<String> arguments) async {
  final parser = ArgParser()
    ..addMultiOption('module',
        abbr: 'm', help: 'Name of Flutter Module to Run');

  final results = parser.parse(arguments);
  final module = results['module'][0];

  if (module.isEmpty) {
    log("Please provide module name to run");
    return;
  }
  // await run("cd $module");
  await run("flutter run -t lib/main.dart");
}
