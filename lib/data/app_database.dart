import 'package:flutter/rendering.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'app_database.g.dart';
class Users extends Table{
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer()();
  TextColumn get phoneNumber => text().withLength(min: 1, max: 50)();
  TextColumn get email => text().withLength(min: 1,max: 50)();
}
@UseMoor(tables: [Users])
class AppDatabase extends _$AppDatabase{
AppDatabase():super(FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite',
logStatements: true));

@override 
  int get schemaVersion => 1;


Future insertUser(User user)=> into(users).insert(user);
}