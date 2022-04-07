import 'package:needle_orm_angel_example/src/config/plugins/orm.dart';
import 'package:needle_orm_angel_example/src/domain.dart';
import 'package:angel3_configuration/angel3_configuration.dart';
import 'package:angel3_migration_runner/angel3_migration_runner.dart';
import 'package:angel3_migration_runner/postgres.dart';
import 'package:file/local.dart';
import 'package:logging/logging.dart';

void main(List<String> args) async {
  // Enable the logging
  Logger.root.level = Level.INFO;
  Logger.root.onRecord.listen((rec) {
    print('${rec.time}: ${rec.level.name}: ${rec.loggerName}: ${rec.message}');

    if (rec.error != null) {
      print(rec.error);
      print(rec.stackTrace);
    }
  });

  var fs = LocalFileSystem();
  var configuration = await loadStandaloneConfiguration(fs);
  var connection = await connectToPostgres(configuration);
  var migrationRunner = PostgresMigrationRunner(connection, migrations: [
    BookMigration(),
    UserMigration(),
  ]);
  await runMigrations(migrationRunner, args);
}
