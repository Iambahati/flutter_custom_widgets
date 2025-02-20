// import 'dart:io';
// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:path/path.dart' as path;

// const _excludedFolders = {'gen', 'core'};

// void main(List<String> args) async {
//   final directory = args.contains('-d') ? args[args.indexOf('-d') + 1] : '../lib';
//   final verbose = args.contains('-v');

//   try {
//     final routes = await _findRoutes(directory, verbose);
//     await _writeRoutes(routes, directory);
//     debugPrint('✅ Generated ${routes.length} routes!');
//   } catch (e) {
//     debugPrint('❌ Error: $e');
//     exit(1);
//   }
// }

// class RouteDefinition {
//   final String className;
//   final String routeName;
//   String? title;
//   final String importPath;

//   var RouteDefinition({
//     required this.className,
//     required this.routeName,
//     required this.title,
//     required this.importPath,
//   });
// }

// Future<List<RouteDefinition>> _findRoutes(String dirPath, bool verbose) async {
//   final dir = Directory(dirPath);
//   if (!dir.existsSync()) throw 'Directory not found: $dirPath';

//   final routes = <RouteDefinition>[];
//   final pageFiles = dir.listSync(recursive: true)
//     .whereType<File>()
//     .where((f) => f.path.endsWith('_page.dart') && !_shouldExclude(f.path));

//   for (final file in pageFiles) {
//     final content = await file.readAsString();
//     final className = _extractClassName(content);
//     final routeName = _extractRouteName(content);
    
//     if (className == null || routeName == null) continue;

//     final importPath = path.relative(file.path, from: dir.parent.path);

//     if (verbose) print('Found route: $className');
    
//     routes.add(RouteDefinition(
//       className: className,
//       routeName: routeName,
//       title: null, // Title will be set in _writeRoutes
//       importPath: importPath,
//     ));
//   }

//   return routes;
// }

// bool _shouldExclude(String filePath) {
//   return path.split(filePath).any(_excludedFolders.contains);
// }

// String? _extractRouteName(String content) {
//   final match = RegExp(r"static const (?:String )?routeName = '(.+)';").firstMatch(content);
//   return match?.group(1);
// }

// String? _extractClassName(String content) {
//   final match = RegExp(r'class\s+(\w+Page)\b').firstMatch(content);
//   return match?.group(1);
// }

// Future<void> _writeRoutes(List<RouteDefinition> routes, String rootDir) async {
//   if (routes.isEmpty) throw 'No routes found';
  
//   final outputFile = File(path.join(rootDir, 'routes', 'routes.dart'));
//   final buffer = StringBuffer();
//   String existingContent = '';
//   final existingRoutes = <String, String>{};

//   if (await outputFile.exists()) {
//     existingContent = await outputFile.readAsString();
//     final titleRegex = RegExp(
//       r"routeName\s*:\s*(\w+)\.routeName\s*,[\s\S]*?title\s*:\s*\'(.*?)\'",
//       multiLine: true,
//     );
    
//     for (final match in titleRegex.allMatches(existingContent)) {
//       existingRoutes[match.group(1)!] = match.group(2)!;
//     }
//   }

//   // Get titles for new routes
//   for (final route in routes) {
//     if (!existingRoutes.containsKey(route.className)) {
//       stdout.write('Enter title for ${route.className} (${route.routeName}): ');
//       final title = stdin.readLineSync(encoding: utf8)?.trim();
//       if (title == null || title.isEmpty) {
//         print('⚠️ Skipping ${route.className} - no title provided');
//         continue;
//       }
//       route.title = title;
//     }
//   }

//   buffer.writeln("// GENERATED FILE - DO NOT EDIT MANUALLY");
//   buffer.writeln("import 'package:flutter/material.dart';");

//   // Add imports
//   final imports = routes.map((r) => 
//     "import '../${r.importPath.replaceAll(r'\', '/').replaceFirst('lib/', '')}';").toSet();
//   buffer.writeAll(imports, '\n');

//   buffer.writeln('\nfinal routes = <PageRoute>[');

//   // Preserve existing routes
//   if (existingContent.isNotEmpty) {
//     final existingRouteBlock = existingContent.substring(
//       existingContent.indexOf('[') + 1,
//       existingContent.lastIndexOf('];'),
//     );
//     buffer.writeln(existingRouteBlock);
//   }

//   // Add new routes
//   for (final route in routes) {
//     if (route.title != null && !existingRoutes.containsKey(route.className)) {
//       buffer.writeln('''  const PageRoute(
//     routeName: ${route.className}.routeName,
//     title: '${route.title!.replaceAll("'", "\\'")}',
//     widget: ${route.className}(),
//   ),''');
//     }
//   }

//   buffer.writeln('];\n');

//   // Preserve existing class definition
//   if (existingContent.contains('class PageRoute {')) {
//     buffer.write(existingContent.substring(existingContent.indexOf('class PageRoute {')));
//   } else {
//     buffer.writeln('''class PageRoute {
//   final String routeName;
//   final String title;
//   final Widget widget;
//   final bool isUnfinished;

//   const PageRoute({
//     required this.routeName,
//     required this.title,
//     required this.widget,
//     this.isUnfinished = false,
//   });
// }''');
//   }

//   outputFile.parent.createSync(recursive: true);
//   await outputFile.writeAsString(buffer.toString());
// }