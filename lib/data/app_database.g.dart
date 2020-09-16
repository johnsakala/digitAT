// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class User extends DataClass implements Insertable<User> {
  final int id;
  final int userId;
  final String phoneNumber;
  final String fullName;
  final String city;
  User(
      {@required this.id,
      @required this.userId,
      @required this.phoneNumber,
      @required this.fullName,
      @required this.city});
  factory User.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return User(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      userId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}user_id']),
      phoneNumber: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}phone_number']),
      fullName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}full_name']),
      city: stringType.mapFromDatabaseResponse(data['${effectivePrefix}city']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<int>(userId);
    }
    if (!nullToAbsent || phoneNumber != null) {
      map['phone_number'] = Variable<String>(phoneNumber);
    }
    if (!nullToAbsent || fullName != null) {
      map['full_name'] = Variable<String>(fullName);
    }
    if (!nullToAbsent || city != null) {
      map['city'] = Variable<String>(city);
    }
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      phoneNumber: phoneNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(phoneNumber),
      fullName: fullName == null && nullToAbsent
          ? const Value.absent()
          : Value(fullName),
      city: city == null && nullToAbsent ? const Value.absent() : Value(city),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      phoneNumber: serializer.fromJson<String>(json['phoneNumber']),
      fullName: serializer.fromJson<String>(json['fullName']),
      city: serializer.fromJson<String>(json['city']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'phoneNumber': serializer.toJson<String>(phoneNumber),
      'fullName': serializer.toJson<String>(fullName),
      'city': serializer.toJson<String>(city),
    };
  }

  User copyWith(
          {int id,
          int userId,
          String phoneNumber,
          String fullName,
          String city}) =>
      User(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        fullName: fullName ?? this.fullName,
        city: city ?? this.city,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('fullName: $fullName, ')
          ..write('city: $city')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          userId.hashCode,
          $mrjc(
              phoneNumber.hashCode, $mrjc(fullName.hashCode, city.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.phoneNumber == this.phoneNumber &&
          other.fullName == this.fullName &&
          other.city == this.city);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<int> userId;
  final Value<String> phoneNumber;
  final Value<String> fullName;
  final Value<String> city;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.fullName = const Value.absent(),
    this.city = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    @required int userId,
    @required String phoneNumber,
    @required String fullName,
    @required String city,
  })  : userId = Value(userId),
        phoneNumber = Value(phoneNumber),
        fullName = Value(fullName),
        city = Value(city);
  static Insertable<User> custom({
    Expression<int> id,
    Expression<int> userId,
    Expression<String> phoneNumber,
    Expression<String> fullName,
    Expression<String> city,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (fullName != null) 'full_name': fullName,
      if (city != null) 'city': city,
    });
  }

  UsersCompanion copyWith(
      {Value<int> id,
      Value<int> userId,
      Value<String> phoneNumber,
      Value<String> fullName,
      Value<String> city}) {
    return UsersCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      fullName: fullName ?? this.fullName,
      city: city ?? this.city,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('fullName: $fullName, ')
          ..write('city: $city')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  final GeneratedDatabase _db;
  final String _alias;
  $UsersTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _userIdMeta = const VerificationMeta('userId');
  GeneratedIntColumn _userId;
  @override
  GeneratedIntColumn get userId => _userId ??= _constructUserId();
  GeneratedIntColumn _constructUserId() {
    return GeneratedIntColumn(
      'user_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _phoneNumberMeta =
      const VerificationMeta('phoneNumber');
  GeneratedTextColumn _phoneNumber;
  @override
  GeneratedTextColumn get phoneNumber =>
      _phoneNumber ??= _constructPhoneNumber();
  GeneratedTextColumn _constructPhoneNumber() {
    return GeneratedTextColumn('phone_number', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  final VerificationMeta _fullNameMeta = const VerificationMeta('fullName');
  GeneratedTextColumn _fullName;
  @override
  GeneratedTextColumn get fullName => _fullName ??= _constructFullName();
  GeneratedTextColumn _constructFullName() {
    return GeneratedTextColumn('full_name', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  final VerificationMeta _cityMeta = const VerificationMeta('city');
  GeneratedTextColumn _city;
  @override
  GeneratedTextColumn get city => _city ??= _constructCity();
  GeneratedTextColumn _constructCity() {
    return GeneratedTextColumn('city', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, userId, phoneNumber, fullName, city];
  @override
  $UsersTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'users';
  @override
  final String actualTableName = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id'], _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('phone_number')) {
      context.handle(
          _phoneNumberMeta,
          phoneNumber.isAcceptableOrUnknown(
              data['phone_number'], _phoneNumberMeta));
    } else if (isInserting) {
      context.missing(_phoneNumberMeta);
    }
    if (data.containsKey('full_name')) {
      context.handle(_fullNameMeta,
          fullName.isAcceptableOrUnknown(data['full_name'], _fullNameMeta));
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('city')) {
      context.handle(
          _cityMeta, city.isAcceptableOrUnknown(data['city'], _cityMeta));
    } else if (isInserting) {
      context.missing(_cityMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return User.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(_db, alias);
  }
}

class Doctr extends DataClass implements Insertable<Doctr> {
  final String doctorList;
  Doctr({@required this.doctorList});
  factory Doctr.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return Doctr(
      doctorList: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}doctor_list']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || doctorList != null) {
      map['doctor_list'] = Variable<String>(doctorList);
    }
    return map;
  }

  DoctrsCompanion toCompanion(bool nullToAbsent) {
    return DoctrsCompanion(
      doctorList: doctorList == null && nullToAbsent
          ? const Value.absent()
          : Value(doctorList),
    );
  }

  factory Doctr.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Doctr(
      doctorList: serializer.fromJson<String>(json['doctorList']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'doctorList': serializer.toJson<String>(doctorList),
    };
  }

  Doctr copyWith({String doctorList}) => Doctr(
        doctorList: doctorList ?? this.doctorList,
      );
  @override
  String toString() {
    return (StringBuffer('Doctr(')
          ..write('doctorList: $doctorList')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf(doctorList.hashCode);
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Doctr && other.doctorList == this.doctorList);
}

class DoctrsCompanion extends UpdateCompanion<Doctr> {
  final Value<String> doctorList;
  const DoctrsCompanion({
    this.doctorList = const Value.absent(),
  });
  DoctrsCompanion.insert({
    @required String doctorList,
  }) : doctorList = Value(doctorList);
  static Insertable<Doctr> custom({
    Expression<String> doctorList,
  }) {
    return RawValuesInsertable({
      if (doctorList != null) 'doctor_list': doctorList,
    });
  }

  DoctrsCompanion copyWith({Value<String> doctorList}) {
    return DoctrsCompanion(
      doctorList: doctorList ?? this.doctorList,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (doctorList.present) {
      map['doctor_list'] = Variable<String>(doctorList.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DoctrsCompanion(')
          ..write('doctorList: $doctorList')
          ..write(')'))
        .toString();
  }
}

class $DoctrsTable extends Doctrs with TableInfo<$DoctrsTable, Doctr> {
  final GeneratedDatabase _db;
  final String _alias;
  $DoctrsTable(this._db, [this._alias]);
  final VerificationMeta _doctorListMeta = const VerificationMeta('doctorList');
  GeneratedTextColumn _doctorList;
  @override
  GeneratedTextColumn get doctorList => _doctorList ??= _constructDoctorList();
  GeneratedTextColumn _constructDoctorList() {
    return GeneratedTextColumn('doctor_list', $tableName, false,
        minTextLength: 1, maxTextLength: 200);
  }

  @override
  List<GeneratedColumn> get $columns => [doctorList];
  @override
  $DoctrsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'doctrs';
  @override
  final String actualTableName = 'doctrs';
  @override
  VerificationContext validateIntegrity(Insertable<Doctr> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('doctor_list')) {
      context.handle(
          _doctorListMeta,
          doctorList.isAcceptableOrUnknown(
              data['doctor_list'], _doctorListMeta));
    } else if (isInserting) {
      context.missing(_doctorListMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  Doctr map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Doctr.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $DoctrsTable createAlias(String alias) {
    return $DoctrsTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $UsersTable _users;
  $UsersTable get users => _users ??= $UsersTable(this);
  $DoctrsTable _doctrs;
  $DoctrsTable get doctrs => _doctrs ??= $DoctrsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [users, doctrs];
}
