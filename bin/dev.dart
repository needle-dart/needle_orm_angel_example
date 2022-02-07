import 'dart:async';
import 'dart:io';
import 'package:angel_app1/angel_app1.dart';
import 'package:belatuk_pretty_logging/belatuk_pretty_logging.dart';
import 'package:angel3_container/mirrors.dart';
import 'package:angel3_framework/angel3_framework.dart';
import 'package:angel3_hot/angel3_hot.dart';
import 'package:logging/logging.dart';

void main() async {
  test();
  // Watch the config/ and web/ directories for changes, and hot-reload the server.
  hierarchicalLoggingEnabled = true;

  var hot = HotReloader(() async {
    var logger = Logger.detached('angel_app1')
      ..level = Level.ALL
      ..onRecord.listen(prettyLog);
    var app = Angel(logger: logger, reflector: MirrorsReflector());
    await app.configure(configureServer);
    return app;
  }, [
    Directory('config'),
    Directory('lib'),
  ]);

  var server = await hot.startServer('127.0.0.1', 3000);
  print(
      'angel_app1 server listening at http://${server.address.address}:${server.port}');
}

void test() {
  final spec = ZoneSpecification(
    print: (self, parent, zone, line) =>
        parent.print(zone, '[${DateTime.now()}] MyApp: $line'),
  );
  runZoned(() {
    print("hello");
  }, zoneSpecification: spec);
}
