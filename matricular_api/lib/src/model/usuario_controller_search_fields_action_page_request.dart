//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:matricular/src/model/search_field_value.dart';
import 'package:matricular/src/model/pageable.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'usuario_controller_search_fields_action_page_request.g.dart';

/// UsuarioControllerSearchFieldsActionPageRequest
///
/// Properties:
/// * [searchFieldValues]
/// * [page]
@BuiltValue()
abstract class UsuarioControllerSearchFieldsActionPageRequest
    implements
        Built<UsuarioControllerSearchFieldsActionPageRequest,
            UsuarioControllerSearchFieldsActionPageRequestBuilder> {
  @BuiltValueField(wireName: r'searchFieldValues')
  BuiltList<SearchFieldValue>? get searchFieldValues;

  @BuiltValueField(wireName: r'page')
  Pageable? get page;

  UsuarioControllerSearchFieldsActionPageRequest._();

  factory UsuarioControllerSearchFieldsActionPageRequest(
          [void updates(
              UsuarioControllerSearchFieldsActionPageRequestBuilder b)]) =
      _$UsuarioControllerSearchFieldsActionPageRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(
          UsuarioControllerSearchFieldsActionPageRequestBuilder b) =>
      b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UsuarioControllerSearchFieldsActionPageRequest>
      get serializer =>
          _$UsuarioControllerSearchFieldsActionPageRequestSerializer();
}

class _$UsuarioControllerSearchFieldsActionPageRequestSerializer
    implements
        PrimitiveSerializer<UsuarioControllerSearchFieldsActionPageRequest> {
  @override
  final Iterable<Type> types = const [
    UsuarioControllerSearchFieldsActionPageRequest,
    _$UsuarioControllerSearchFieldsActionPageRequest
  ];

  @override
  final String wireName = r'UsuarioControllerSearchFieldsActionPageRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UsuarioControllerSearchFieldsActionPageRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.searchFieldValues != null) {
      yield r'searchFieldValues';
      yield serializers.serialize(
        object.searchFieldValues,
        specifiedType: const FullType(BuiltList, [FullType(SearchFieldValue)]),
      );
    }
    if (object.page != null) {
      yield r'page';
      yield serializers.serialize(
        object.page,
        specifiedType: const FullType(Pageable),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UsuarioControllerSearchFieldsActionPageRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UsuarioControllerSearchFieldsActionPageRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'searchFieldValues':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(BuiltList, [FullType(SearchFieldValue)]),
          ) as BuiltList<SearchFieldValue>;
          result.searchFieldValues.replace(valueDes);
          break;
        case r'page':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Pageable),
          ) as Pageable;
          result.page.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UsuarioControllerSearchFieldsActionPageRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UsuarioControllerSearchFieldsActionPageRequestBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}
