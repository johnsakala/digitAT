import 'package:flutter/rendering.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'app_database.g.dart';
class Users extends Table{
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer()();
  TextColumn get phoneNumber => text().withLength(min: 1, max: 50)();
  TextColumn get fullName => text().withLength(min: 1,max: 50)();
  TextColumn get city => text().withLength(min: 1,max: 50)();
  
}
class Doctrs extends Table{
  TextColumn get doctorList => text().withLength(min:1,max:200)();
}
@UseMoor(tables: [Users, Doctrs])
class AppDatabase extends _$AppDatabase{
AppDatabase():super(FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite',
logStatements: true));

@override 
  int get schemaVersion => 3;


Future insertUser(User user)=> into(users).insert(user);
Future<List<User>>getUser()=> select(users).get();

Future insertList(Doctr doctr)=> into(doctrs).insert(doctr);
Future<Doctr>getList()=> select(doctrs).getSingle();
}