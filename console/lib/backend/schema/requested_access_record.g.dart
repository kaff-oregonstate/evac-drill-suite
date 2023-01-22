// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requested_access_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<RequestedAccessRecord> _$requestedAccessRecordSerializer =
    new _$RequestedAccessRecordSerializer();

class _$RequestedAccessRecordSerializer
    implements StructuredSerializer<RequestedAccessRecord> {
  @override
  final Iterable<Type> types = const [
    RequestedAccessRecord,
    _$RequestedAccessRecord
  ];
  @override
  final String wireName = 'RequestedAccessRecord';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, RequestedAccessRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.email;
    if (value != null) {
      result
        ..add('email')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.createdTime;
    if (value != null) {
      result
        ..add('created_time')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.ffRef;
    if (value != null) {
      result
        ..add('Document__Reference__Field')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    return result;
  }

  @override
  RequestedAccessRecord deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new RequestedAccessRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'created_time':
          result.createdTime = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'Document__Reference__Field':
          result.ffRef = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
      }
    }

    return result.build();
  }
}

class _$RequestedAccessRecord extends RequestedAccessRecord {
  @override
  final String? email;
  @override
  final DateTime? createdTime;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$RequestedAccessRecord(
          [void Function(RequestedAccessRecordBuilder)? updates]) =>
      (new RequestedAccessRecordBuilder()..update(updates))._build();

  _$RequestedAccessRecord._({this.email, this.createdTime, this.ffRef})
      : super._();

  @override
  RequestedAccessRecord rebuild(
          void Function(RequestedAccessRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RequestedAccessRecordBuilder toBuilder() =>
      new RequestedAccessRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RequestedAccessRecord &&
        email == other.email &&
        createdTime == other.createdTime &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, email.hashCode), createdTime.hashCode), ffRef.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RequestedAccessRecord')
          ..add('email', email)
          ..add('createdTime', createdTime)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class RequestedAccessRecordBuilder
    implements Builder<RequestedAccessRecord, RequestedAccessRecordBuilder> {
  _$RequestedAccessRecord? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  DateTime? _createdTime;
  DateTime? get createdTime => _$this._createdTime;
  set createdTime(DateTime? createdTime) => _$this._createdTime = createdTime;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  RequestedAccessRecordBuilder() {
    RequestedAccessRecord._initializeBuilder(this);
  }

  RequestedAccessRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _createdTime = $v.createdTime;
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RequestedAccessRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$RequestedAccessRecord;
  }

  @override
  void update(void Function(RequestedAccessRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RequestedAccessRecord build() => _build();

  _$RequestedAccessRecord _build() {
    final _$result = _$v ??
        new _$RequestedAccessRecord._(
            email: email, createdTime: createdTime, ffRef: ffRef);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
