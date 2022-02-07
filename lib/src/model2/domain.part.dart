part of 'domain.dart';

// can write business logic here.

extension BizBook on Book {
  bool isDartBook() {
    return name!.startsWith('dart');
  }

  // specified in @Entity(prePersist: 'beforeInsert', postPersist: 'afterInsert') because override is not possible now, see: https://github.com/dart-lang/language/issues/177
  // @override
  void beforeInsert() {
    _version = 1;
    _deleted = false;
    print('before insert book ....');
  }

  void afterInsert() {
    print('after insert book ....');
  }
}
