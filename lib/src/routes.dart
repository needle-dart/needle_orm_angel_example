import 'dart:async';

import 'package:angel3_framework/angel3_framework.dart';
import 'package:angel3_orm/angel3_orm.dart';
import 'package:angel3_static/angel3_static.dart';
import 'package:file/file.dart';
import 'package:needle_orm/needle_orm.dart';
import 'package:scope/scope.dart';
import 'constants.dart';
import 'domain.dart';

class QueryExecutorDataSource extends DataSource {
  final QueryExecutor queryExecutor;
  QueryExecutorDataSource(this.queryExecutor)
      : super(DatabaseType.PostgreSQL, "10.0");

  @override
  Future<List<List>> execute(
      String tableName, String sql, Map<String, dynamic> substitutionValues,
      [List<String> returningFields = const []]) {
    return queryExecutor.query(
        tableName, sql, substitutionValues, returningFields);
  }

  Future<T> transaction<T>(FutureOr<T> Function(QueryExecutorDataSource) f) {
    return queryExecutor.transaction((p0) => f(this));
  }
}

R runWithDs<R>(RequestContext<dynamic> req, R Function() func) {
  var executor = req.container!.make<QueryExecutor>();
  var ds = QueryExecutorDataSource(executor);
  return (Scope()..value<DataSource>(scopeKeyDataSource, ds)).run(func);
}

/// Put your app routes here!
///
/// See the wiki for information about routing, requests, and responses:
/// * https://angel3-docs.dukefirehawk.com/guides/basic-routing
/// * https://angel3-docs.dukefirehawk.com/guides/requests-and-responses
AngelConfigurer configureServer(FileSystem fileSystem) {
  return (Angel app) async {
    app.post('/books', (req, res) async {
      await req.parseBody();

      var executor = req.container!.make<QueryExecutor>();
      var map = req.bodyAsMap;

      print('need validate map here.');

      var ds = QueryExecutorDataSource(executor);

      // use Scope to inject a QueryExecutor into current context
      var book =
          (Scope()..value<DataSource>(scopeKeyDataSource, ds)).run(() => Book()
            ..loadMap(map)
            ..insert()); // insert will lookup a QueryExecutor

      print('isDartBook? ${book.isDartBook()}');
      return book.toMap();
    });

    app.put('/books/:id', (req, res) async {
      await req.parseBody();

      var id = int.tryParse(req.params['id']);
      var executor = req.container!.make<QueryExecutor>();
      var map = req.bodyAsMap;

      print('need validate map here.');

      var ds = QueryExecutorDataSource(executor);

      // use Scope to inject a QueryExecutor into current context
      var book =
          (Scope()..value<DataSource>(scopeKeyDataSource, ds)).run(() => Book()
            ..loadMap(map)
            ..id = id
            ..update()); // insert will lookup a QueryExecutor

      return book.toMap();
    });

    app.get('/books/:id', (req, res) async {
      var id = int.tryParse(req.params['id'])!;
      var book = await runWithDs(req, () => Book.Query.findById(id));
      var json = book?.toMap()?..removeWhere((key, value) => value == null);
      print('book: $json');
      return json;
    });

    app.get('/books', (req, res) async {
      var books = await runWithDs(req, () {
        return Book.Query.findList();
      });
      return books.map((e) => e.toMap()).toList();
    });

    // Mount static server at web in development.
    // The `CachingVirtualDirectory` variant of `VirtualDirectory` also sends `Cache-Control` headers.
    //
    // In production, however, prefer serving static files through NGINX or a
    // similar reverse proxy.
    //
    // Read the following two sources for documentation:
    // * https://medium.com/the-angel-framework/serving-static-files-with-the-angel-framework-2ddc7a2b84ae
    // * https://pub.dev/packages/angel3_static
    if (!app.environment.isProduction) {
      var vDir = VirtualDirectory(
        app,
        fileSystem,
        source: fileSystem.directory('web'),
      );
      app.fallback(vDir.handleRequest);
    }

    // Throw a 404 if no route matched the request.
    app.fallback((req, res) => throw AngelHttpException.notFound());

    // Set our application up to handle different errors.
    //
    // Read the following for documentation:
    // * https://angel3-docs.dukefirehawk.com/guides/error-handling

    var oldErrorHandler = app.errorHandler;
    app.errorHandler = (e, req, res) async {
      if (req.accepts('text/html', strict: true)) {
        if (e.statusCode == 404 && req.accepts('text/html', strict: true)) {
          await res
              .render('error', {'message': 'No file exists at ${req.uri}.'});
        } else {
          await res.render('error', {'message': e.message});
        }
      } else {
        return await oldErrorHandler(e, req, res);
      }
    };
  };
}
