import 'dart:io';

import 'package:mason/mason.dart';

void run(HookContext context) async {
  final logger = context.logger;
  final directory = Directory.current.path;
  final projectName = context.vars['project_name'] as String;
  late List<String> folders;

  if (Platform.isWindows) {
    folders = directory.split(r'\').toList();
  } else {
    folders = directory.split('/').toList();
  }

  final projectRoot = [...folders, projectName.snakeCase].join('/');

  final isFlutterInstalled = await Flutter.installed(
    logger: logger,
    workingDirectory: projectRoot,
  );

  if (isFlutterInstalled) {
    await Flutter.pubGet(
      logger: logger,
      workingDirectory: projectRoot,
    );
  }

  logger.success('${context.vars['project_name']} generated successfully 🎉');
}

class Flutter {
  static Future<bool> installed({
    String? workingDirectory,
    required Logger logger,
  }) async {
    final progress = logger.progress('Checking if flutter is installed');
    var isFlutterInstalled = false;
    try {
      logger.detail('Running: flutter --version');
      final result = await Process.run(
        'flutter',
        ['--version'],
        workingDirectory: workingDirectory,
        runInShell: true,
      );
      logger
        ..detail('stdout:\n${result.stdout}')
        ..detail('stderr:\n${result.stderr}');
      isFlutterInstalled = true;
    } catch (_) {
      isFlutterInstalled = false;
    } finally {
      progress.complete();
      if (!isFlutterInstalled) {
        logger.alert('Flutter is not installed');
      }
      return isFlutterInstalled;
    }
  }

  static Future<void> pubGet({
    String? workingDirectory,
    required Logger logger,
  }) async {
    final progress =
        logger.progress('Running flutter pub get in $workingDirectory');
    try {
      final result = await Process.run(
        'flutter',
        ['pub', 'get'],
        workingDirectory: workingDirectory,
        runInShell: true,
      );
      logger
        ..detail('stdout:\n${result.stdout}')
        ..detail('stderr:\n${result.stderr}');
      progress.complete();
    } catch (_) {
      logger.alert('Running flutter pub get failed');
    }
  }
}
