// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario_controller_search_fields_action_page_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UsuarioControllerSearchFieldsActionPageRequest
    extends UsuarioControllerSearchFieldsActionPageRequest {
  @override
  final BuiltList<SearchFieldValue>? searchFieldValues;
  @override
  final Pageable? page;

  factory _$UsuarioControllerSearchFieldsActionPageRequest(
          [void Function(UsuarioControllerSearchFieldsActionPageRequestBuilder)?
              updates]) =>
      (new UsuarioControllerSearchFieldsActionPageRequestBuilder()
            ..update(updates))
          ._build();

  _$UsuarioControllerSearchFieldsActionPageRequest._(
      {this.searchFieldValues, this.page})
      : super._();

  @override
  UsuarioControllerSearchFieldsActionPageRequest rebuild(
          void Function(UsuarioControllerSearchFieldsActionPageRequestBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UsuarioControllerSearchFieldsActionPageRequestBuilder toBuilder() =>
      new UsuarioControllerSearchFieldsActionPageRequestBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UsuarioControllerSearchFieldsActionPageRequest &&
        searchFieldValues == other.searchFieldValues &&
        page == other.page;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, searchFieldValues.hashCode);
    _$hash = $jc(_$hash, page.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'UsuarioControllerSearchFieldsActionPageRequest')
          ..add('searchFieldValues', searchFieldValues)
          ..add('page', page))
        .toString();
  }
}

class UsuarioControllerSearchFieldsActionPageRequestBuilder
    implements
        Builder<UsuarioControllerSearchFieldsActionPageRequest,
            UsuarioControllerSearchFieldsActionPageRequestBuilder> {
  _$UsuarioControllerSearchFieldsActionPageRequest? _$v;

  ListBuilder<SearchFieldValue>? _searchFieldValues;
  ListBuilder<SearchFieldValue> get searchFieldValues =>
      _$this._searchFieldValues ??= new ListBuilder<SearchFieldValue>();
  set searchFieldValues(ListBuilder<SearchFieldValue>? searchFieldValues) =>
      _$this._searchFieldValues = searchFieldValues;

  PageableBuilder? _page;
  PageableBuilder get page => _$this._page ??= new PageableBuilder();
  set page(PageableBuilder? page) => _$this._page = page;

  UsuarioControllerSearchFieldsActionPageRequestBuilder() {
    UsuarioControllerSearchFieldsActionPageRequest._defaults(this);
  }

  UsuarioControllerSearchFieldsActionPageRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _searchFieldValues = $v.searchFieldValues?.toBuilder();
      _page = $v.page?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UsuarioControllerSearchFieldsActionPageRequest other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UsuarioControllerSearchFieldsActionPageRequest;
  }

  @override
  void update(
      void Function(UsuarioControllerSearchFieldsActionPageRequestBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  UsuarioControllerSearchFieldsActionPageRequest build() => _build();

  _$UsuarioControllerSearchFieldsActionPageRequest _build() {
    _$UsuarioControllerSearchFieldsActionPageRequest _$result;
    try {
      _$result = _$v ??
          new _$UsuarioControllerSearchFieldsActionPageRequest._(
              searchFieldValues: _searchFieldValues?.build(),
              page: _page?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'searchFieldValues';
        _searchFieldValues?.build();
        _$failedField = 'page';
        _page?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'UsuarioControllerSearchFieldsActionPageRequest',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
