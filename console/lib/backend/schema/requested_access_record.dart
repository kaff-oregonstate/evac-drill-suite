import 'dart:async';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'requested_access_record.g.dart';

abstract class RequestedAccessRecord
    implements Built<RequestedAccessRecord, RequestedAccessRecordBuilder> {
  static Serializer<RequestedAccessRecord> get serializer =>
      _$requestedAccessRecordSerializer;

  String? get email;

  @BuiltValueField(wireName: 'created_time')
  DateTime? get createdTime;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(RequestedAccessRecordBuilder builder) =>
      builder..email = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('RequestedAccess');

  static Stream<RequestedAccessRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<RequestedAccessRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then(
          (s) => serializers.deserializeWith(serializer, serializedData(s))!);

  RequestedAccessRecord._();
  factory RequestedAccessRecord(
          [void Function(RequestedAccessRecordBuilder) updates]) =
      _$RequestedAccessRecord;

  static RequestedAccessRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createRequestedAccessRecordData({
  String? email,
  DateTime? createdTime,
}) {
  final firestoreData = serializers.toFirestore(
    RequestedAccessRecord.serializer,
    RequestedAccessRecord((u) => u
      ..email = email
      ..createdTime = createdTime),
  );

  return firestoreData;
}
