import 'package:angel3_framework/angel3_framework.dart';
import 'package:angel3_orm/angel3_orm.dart';
import 'package:angel3_static/angel3_static.dart';
import 'package:file/file.dart';
import 'package:needle_orm/needle_orm.dart';
import 'package:scope/scope.dart';
import '../constants.dart';
import 'controllers/controllers.dart' as controllers;
import '../models/greeting.dart' hide Book;
import '../model2/domain.dart';

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
    // Typically, you want to mount controllers first, after any global middleware.
    await app.configure(controllers.configureServer);

    // Render `views/hello.jl` when a user visits the application root.
    app.get('/', (req, res) => res.render('hello'));

    app.get('/greetings', (req, res) {
      var executor = req.container!.make<QueryExecutor>();
      var query = GreetingQuery();
      return query.get(executor);
    });

/*     app.get('/books', (req, res) {
      var executor = req.container!.make<QueryExecutor>();
      var query = BookQuery();
      return query.get(executor);
    });
 */
    app.post('/greetings', (req, res) async {
      await req.parseBody();

      if (!req.bodyAsMap.containsKey('message')) {
        throw AngelHttpException.badRequest(message: 'Missing "message".');
      } else {
        var executor = req.container!.make<QueryExecutor>();
        var message = req.bodyAsMap['message'].toString();
        var query = GreetingQuery()
          ..values.message = message
          ..values.createdAt =
              null; // createdAt will not be saved without this line.
        var optional = await query.insert(executor);
        return optional.value;
      }
    });

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

    app.get('/books/:id', (req, res) {
      var id = int.tryParse(req.params['id'])!;
      var book = runWithDs(req, () => Book.Query.findById(id));
      return book?.toMap();
    });

    app.get('/books', (req, res) {
      var books = runWithDs(req, () {
        Book.Query.test();
        return Book.Query.findAll();
      });
      return books;
    });

    app.get('/greetings/:message', (req, res) {
      var message = req.params['message'] as String;
      var executor = req.container!.make<QueryExecutor>();
      var query = GreetingQuery()..where!.message.equals(message);
      return query.get(executor);
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
