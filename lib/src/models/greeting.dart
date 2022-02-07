import 'package:angel3_migration/angel3_migration.dart';
import 'package:angel3_serialize/angel3_serialize.dart';
import 'package:angel3_orm/angel3_orm.dart';
import 'package:optional/optional.dart';
part 'greeting.g.dart';

@serializable
@orm
abstract class _Greeting extends Model {
  @SerializableField(isNullable: false)
  String? get message;
}

@serializable
@orm
class _Book extends Model {
  @Column()
  String? _name;

  @Column()
  double? _price;

  _Book();
}
