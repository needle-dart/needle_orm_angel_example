// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'domain.dart';

// **************************************************************************
// NeedleOrmMetaInfoGenerator
// **************************************************************************

abstract class __Model extends Model {
  // abstract begin

  String get __tableName;
  String? get __idFieldName;

  dynamic __getField(String fieldName, {errorOnNonExistField: true});
  void __setField(String fieldName, dynamic value,
      {errorOnNonExistField: true});

  Map<String, dynamic> toMap();

  // abstract end

  // mark whether this instance is loaded from db.
  bool __isLoadedFromDb = false;

  // mark all modified fields after loaded
  final __dirtyFields = <String>{};

  void loadMap(Map<String, dynamic> m, {errorOnNonExistField: false}) {
    m.forEach((key, value) {
      __setField(key, value, errorOnNonExistField: errorOnNonExistField);
    });
  }

  void __markDirty(String fieldName) {
    __dirtyFields.add(fieldName);
  }

  void __cleanDirty() {
    __dirtyFields.clear();
  }

  String __dirtyValues() {
    return __dirtyFields
        .map((e) => "${e.toLowerCase()} : ${__getField(e)}")
        .join(", ");
  }

  void insert() {
    __prePersist();
    sqlExecutor.insert(this);
    __postPersist();
  }

  void update() {
    __preUpdate();
    sqlExecutor.update(this);
    __postUpdate();
  }

  void save() {
    if (__idFieldName == null) throw 'no @ID field';

    if (__getField(__idFieldName!) != null) {
      update();
    } else {
      insert();
    }
  }

  void delete() {
    __preRemove();
    sqlExecutor.delete(this);
    __postRemove();
  }

  void deletePermanent() {
    __preRemovePermanent();
    sqlExecutor.deletePermanent(this);
    __postRemovePermanent();
  }

  void __prePersist() {}
  void __preUpdate() {}
  void __preRemove() {}
  void __preRemovePermanent() {}
  void __postPersist() {}
  void __postUpdate() {}
  void __postRemove() {}
  void __postRemovePermanent() {}
  void __postLoad() {}
}

abstract class _BaseModelQuery<T extends __Model, D>
    extends BaseModelQuery<T, D> {
  _BaseModelQuery() : super(sqlExecutor);
}

class _ModelInspector extends ModelInspector<__Model> {
  @override
  String getClassName(__Model obj) {
    if (obj is Book) return 'Book';
    if (obj is User) return 'User';
    if (obj is Job) return 'Job';
    throw 'unknown entity : $obj';
  }

  @override
  get allOrmMetaClasses => _allOrmClasses;

  @override
  OrmMetaClass? meta(String className) {
    var list =
        _allOrmClasses.where((element) => element.name == className).toList();
    if (list.isNotEmpty) {
      return list.first;
    }
    return null;
  }

  @override
  dynamic getFieldValue(__Model obj, String fieldName) {
    return obj.__getField(fieldName);
  }

  @override
  void setFieldValue(__Model obj, String fieldName, dynamic value) {
    obj.__setField(fieldName, value);
  }

  @override
  Map<String, dynamic> getDirtyFields(__Model model) {
    var map = <String, dynamic>{};
    model.__dirtyFields.forEach((name) {
      map[name] = model.__getField(name);
    });
    return map;
  }

  @override
  void loadModel(__Model model, Map<String, dynamic> m,
      {errorOnNonExistField: false}) {
    model.loadMap(m, errorOnNonExistField: false);
    model.__isLoadedFromDb = true;
    model.__cleanDirty();
  }

  @override
  __Model newInstance(String className) {
    switch (className) {
      case 'Book':
        return Book();
      case 'User':
        return User();
      case 'Job':
        return Job();
      default:
        throw 'unknown class : $className';
    }
  }
}

final _ModelInspector _modelInspector = _ModelInspector();

class _SqlExecutor extends SqlExecutor<__Model> {
  _SqlExecutor() : super(_ModelInspector());

  @override
  Future<List<List>> query(
      String tableName, String query, Map<String, dynamic> substitutionValues,
      [List<String> returningFields = const []]) {
    DataSource ds = use(
        scopeKeyDefaultDs); // get a DataSource from Scope , see routes.dart #post(Book)
    return ds.execute(tableName, query, substitutionValues, returningFields);
  }
}

final sqlExecutor = _SqlExecutor();

class OrmMetaInfoBaseModel extends OrmMetaClass {
  OrmMetaInfoBaseModel()
      : super('BaseModel', _modelInspector,
            isAbstract: true,
            superClassName: 'Object',
            ormAnnotations: [
              Entity(),
            ],
            fields: [
              OrmMetaField('id', 'int?', ormAnnotations: [
                ID(),
              ]),
              OrmMetaField('version', 'int?', ormAnnotations: [
                Version(),
              ]),
              OrmMetaField('deleted', 'bool?', ormAnnotations: [
                SoftDelete(),
              ]),
              OrmMetaField('createdAt', 'DateTime?', ormAnnotations: [
                WhenCreated(),
              ]),
              OrmMetaField('updatedAt', 'DateTime?', ormAnnotations: [
                WhenModified(),
              ]),
              OrmMetaField('createdBy', 'String?', ormAnnotations: [
                WhoCreated(),
              ]),
              OrmMetaField('lastUpdatedBy', 'String?', ormAnnotations: [
                WhoModified(),
              ]),
              OrmMetaField('remark', 'String?', ormAnnotations: [
                Column(),
              ]),
            ]);
}

class OrmMetaInfoBook extends OrmMetaClass {
  OrmMetaInfoBook()
      : super('Book', _modelInspector,
            isAbstract: false,
            superClassName: 'BaseModel',
            ormAnnotations: [
              Entity(prePersist: 'beforeInsert', postPersist: 'afterInsert'),
            ],
            fields: [
              OrmMetaField('name', 'String?', ormAnnotations: [
                Column(),
              ]),
              OrmMetaField('price', 'double?', ormAnnotations: [
                Column(),
              ]),
              OrmMetaField('author', 'User?', ormAnnotations: [
                ManyToOne(),
              ]),
            ]);
}

class OrmMetaInfoUser extends OrmMetaClass {
  OrmMetaInfoUser()
      : super('User', _modelInspector,
            isAbstract: false,
            superClassName: 'BaseModel',
            ormAnnotations: [
              Entity(),
            ],
            fields: [
              OrmMetaField('name', 'String?', ormAnnotations: [
                Column(),
              ]),
              OrmMetaField('loginName', 'String?', ormAnnotations: [
                Column(),
              ]),
              OrmMetaField('address', 'String?', ormAnnotations: [
                Column(),
              ]),
              OrmMetaField('age', 'int?', ormAnnotations: [
                Column(),
              ]),
            ]);
}

class OrmMetaInfoJob extends OrmMetaClass {
  OrmMetaInfoJob()
      : super('Job', _modelInspector,
            isAbstract: false,
            superClassName: 'BaseModel',
            ormAnnotations: [
              Entity(),
            ],
            fields: [
              OrmMetaField('name', 'String?', ormAnnotations: [
                Column(),
              ]),
            ]);
}

final _allOrmClasses = [
  OrmMetaInfoBaseModel(),
  OrmMetaInfoBook(),
  OrmMetaInfoUser(),
  OrmMetaInfoJob()
];

// **************************************************************************
// NeedleOrmModelGenerator
// **************************************************************************

class BaseModelModelQuery extends _BaseModelQuery<BaseModel, int> {
  @override
  String get className => 'BaseModel';
}

abstract class BaseModel extends __Model {
  int? _id;
  int? get id => _id;
  set id(int? v) {
    _id = v;
    __markDirty('id');
  }

  int? _version;
  int? get version => _version;
  set version(int? v) {
    _version = v;
    __markDirty('version');
  }

  bool? _deleted;
  bool? get deleted => _deleted;
  set deleted(bool? v) {
    _deleted = v;
    __markDirty('deleted');
  }

  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  set createdAt(DateTime? v) {
    _createdAt = v;
    __markDirty('createdAt');
  }

  DateTime? _updatedAt;
  DateTime? get updatedAt => _updatedAt;
  set updatedAt(DateTime? v) {
    _updatedAt = v;
    __markDirty('updatedAt');
  }

  String? _createdBy;
  String? get createdBy => _createdBy;
  set createdBy(String? v) {
    _createdBy = v;
    __markDirty('createdBy');
  }

  String? _lastUpdatedBy;
  String? get lastUpdatedBy => _lastUpdatedBy;
  set lastUpdatedBy(String? v) {
    _lastUpdatedBy = v;
    __markDirty('lastUpdatedBy');
  }

  String? _remark;
  String? get remark => _remark;
  set remark(String? v) {
    _remark = v;
    __markDirty('remark');
  }

  BaseModel();

  static BaseModelModelQuery get Query => BaseModelModelQuery();

  @override
  dynamic __getField(String fieldName, {errorOnNonExistField: true}) {
    switch (fieldName) {
      case "id":
        return _id;
      case "version":
        return _version;
      case "deleted":
        return _deleted;
      case "createdAt":
        return _createdAt;
      case "updatedAt":
        return _updatedAt;
      case "createdBy":
        return _createdBy;
      case "lastUpdatedBy":
        return _lastUpdatedBy;
      case "remark":
        return _remark;
      default:
        if (errorOnNonExistField) {
          throw 'class _BaseModel has now such field: $fieldName';
        }
    }
  }

  @override
  void __setField(String fieldName, dynamic value,
      {errorOnNonExistField: true}) {
    switch (fieldName) {
      case "id":
        id = value;
        break;
      case "version":
        version = value;
        break;
      case "deleted":
        deleted = value;
        break;
      case "createdAt":
        createdAt = value;
        break;
      case "updatedAt":
        updatedAt = value;
        break;
      case "createdBy":
        createdBy = value;
        break;
      case "lastUpdatedBy":
        lastUpdatedBy = value;
        break;
      case "remark":
        remark = value;
        break;
      default:
        if (errorOnNonExistField) {
          throw 'class _BaseModel has now such field: $fieldName';
        }
    }
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "id": _id,
      "version": _version,
      "deleted": _deleted,
      "createdAt": _createdAt?.toIso8601String(),
      "updatedAt": _updatedAt?.toIso8601String(),
      "createdBy": _createdBy,
      "lastUpdatedBy": _lastUpdatedBy,
      "remark": _remark,
    };
  }

  @override
  String get __tableName {
    return "basemodel";
  }

  @override
  String? get __idFieldName {
    return "id";
  }
}

class BookModelQuery extends _BaseModelQuery<Book, int> {
  @override
  String get className => 'Book';
}

class Book extends BaseModel {
  String? _name;
  String? get name => _name;
  set name(String? v) {
    _name = v;
    __markDirty('name');
  }

  double? _price;
  double? get price => _price;
  set price(double? v) {
    _price = v;
    __markDirty('price');
  }

  User? _author;
  User? get author => _author;
  set author(User? v) {
    _author = v;
    __markDirty('author');
  }

  Book();

  static BookModelQuery get Query => BookModelQuery();

  @override
  dynamic __getField(String fieldName, {errorOnNonExistField: true}) {
    switch (fieldName) {
      case "name":
        return _name;
      case "price":
        return _price;
      case "author":
        return _author;
      default:
        return super
            .__getField(fieldName, errorOnNonExistField: errorOnNonExistField);
    }
  }

  @override
  void __setField(String fieldName, dynamic value,
      {errorOnNonExistField: true}) {
    switch (fieldName) {
      case "name":
        name = value;
        break;
      case "price":
        price = value;
        break;
      case "author":
        author = value;
        break;
      default:
        super.__setField(fieldName, value,
            errorOnNonExistField: errorOnNonExistField);
    }
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "name": _name,
      "price": _price,
      "author": _author,
      ...super.toMap(),
    };
  }

  @override
  String get __tableName {
    return "book";
  }

  @override
  String? get __idFieldName {
    return "id";
  }

  @override
  void __prePersist() {
    beforeInsert();
  }

  @override
  void __postPersist() {
    afterInsert();
  }
}

class UserModelQuery extends _BaseModelQuery<User, int> {
  @override
  String get className => 'User';
}

class User extends BaseModel {
  String? _name;
  String? get name => _name;
  set name(String? v) {
    _name = v;
    __markDirty('name');
  }

  String? _loginName;
  String? get loginName => _loginName;
  set loginName(String? v) {
    _loginName = v;
    __markDirty('loginName');
  }

  String? _address;
  String? get address => _address;
  set address(String? v) {
    _address = v;
    __markDirty('address');
  }

  int? _age;
  int? get age => _age;
  set age(int? v) {
    _age = v;
    __markDirty('age');
  }

  User();

  static UserModelQuery get Query => UserModelQuery();

  @override
  dynamic __getField(String fieldName, {errorOnNonExistField: true}) {
    switch (fieldName) {
      case "name":
        return _name;
      case "loginName":
        return _loginName;
      case "address":
        return _address;
      case "age":
        return _age;
      default:
        return super
            .__getField(fieldName, errorOnNonExistField: errorOnNonExistField);
    }
  }

  @override
  void __setField(String fieldName, dynamic value,
      {errorOnNonExistField: true}) {
    switch (fieldName) {
      case "name":
        name = value;
        break;
      case "loginName":
        loginName = value;
        break;
      case "address":
        address = value;
        break;
      case "age":
        age = value;
        break;
      default:
        super.__setField(fieldName, value,
            errorOnNonExistField: errorOnNonExistField);
    }
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "name": _name,
      "loginName": _loginName,
      "address": _address,
      "age": _age,
      ...super.toMap(),
    };
  }

  @override
  String get __tableName {
    return "user";
  }

  @override
  String? get __idFieldName {
    return "id";
  }
}

class JobModelQuery extends _BaseModelQuery<Job, int> {
  @override
  String get className => 'Job';
}

class Job extends BaseModel {
  String? _name;
  String? get name => _name;
  set name(String? v) {
    _name = v;
    __markDirty('name');
  }

  Job();

  static JobModelQuery get Query => JobModelQuery();

  @override
  dynamic __getField(String fieldName, {errorOnNonExistField: true}) {
    switch (fieldName) {
      case "name":
        return _name;
      default:
        return super
            .__getField(fieldName, errorOnNonExistField: errorOnNonExistField);
    }
  }

  @override
  void __setField(String fieldName, dynamic value,
      {errorOnNonExistField: true}) {
    switch (fieldName) {
      case "name":
        name = value;
        break;
      default:
        super.__setField(fieldName, value,
            errorOnNonExistField: errorOnNonExistField);
    }
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "name": _name,
      ...super.toMap(),
    };
  }

  @override
  String get __tableName {
    return "job";
  }

  @override
  String? get __idFieldName {
    return "id";
  }
}

// **************************************************************************
// NeedleOrmMigrationGenerator
// **************************************************************************

class BookMigration extends Migration {
  @override
  void up(Schema schema) {
    schema.create('books', (table) {
      table.varChar('name');

      table.float('price');

      table.varChar('author');

      table.serial('id');

      table.integer('version');

      table.boolean('deleted');

      table.timeStamp('created_at');

      table.timeStamp('updated_at');

      table.varChar('created_by');

      table.varChar('last_updated_by');

      table.varChar('remark');
    });
  }

  @override
  void down(Schema schema) {
    schema.drop('books');
  }
}

class UserMigration extends Migration {
  @override
  void up(Schema schema) {
    schema.create('users', (table) {
      table.varChar('name');

      table.varChar('login_name');

      table.varChar('address');

      table.integer('age');

      table.serial('id');

      table.integer('version');

      table.boolean('deleted');

      table.timeStamp('created_at');

      table.timeStamp('updated_at');

      table.varChar('created_by');

      table.varChar('last_updated_by');

      table.varChar('remark');
    });
  }

  @override
  void down(Schema schema) {
    schema.drop('users');
  }
}

class JobMigration extends Migration {
  @override
  void up(Schema schema) {
    schema.create('jobs', (table) {
      table.varChar('name');

      table.serial('id');

      table.integer('version');

      table.boolean('deleted');

      table.timeStamp('created_at');

      table.timeStamp('updated_at');

      table.varChar('created_by');

      table.varChar('last_updated_by');

      table.varChar('remark');
    });
  }

  @override
  void down(Schema schema) {
    schema.drop('jobs');
  }
}