// ignore_for_file: unused_field, unused_element

import 'package:angel3_migration/angel3_migration.dart';
import './constants.dart';
import 'package:needle_orm/needle_orm.dart';
import 'package:scope/scope.dart';

part 'domain.g.dart'; // auto generated code
part 'domain.part.dart'; // business logic code

// all Class names and Field names must start with '_'
// all business logic must be defined in file : 'domain.part.dart'

//__Model will be generated in .g.dart

// .g.dart needs scopeKeyDefaultDs
final scopeKeyDefaultDs = scopeKeyDataSource;

@Entity()
abstract class _BaseModel {
  @ID()
  int? _id;

  @Version()
  int? _version;

  @SoftDelete()
  bool? _deleted;

  @WhenCreated()
  DateTime? _createdAt;

  @WhenModified()
  DateTime? _updatedAt;

  @WhoCreated()
  String? _createdBy; // user login name

  @WhoModified()
  String? _lastUpdatedBy; // user login name

  @Column()
  String? _remark;

  _BaseModel();
}

// @Table()
@Entity(prePersist: 'beforeInsert', postPersist: 'afterInsert')
class _Book extends _BaseModel {
  @Column()
  String? _name;

  @Column()
  double? _price;

  @ManyToOne()
  _User? _author;

  _Book();
}

// @Table(name: 'tbl_user')
@Entity()
class _User extends _BaseModel {
  @Column()
  String? _name;

  @Column()
  String? _loginName;

  @Column()
  String? _address;

  @Column()
  int? _age;

  _User();
}

//@DB(name: "default")
@Entity()
class _Job extends _BaseModel {
  @Column()
  String? _name;

  _Job();
}
