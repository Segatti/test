// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on AuthStoreBase, Store {
  late final _$debugErrorAtom =
      Atom(name: 'AuthStoreBase.debugError', context: context);

  @override
  bool get debugError {
    _$debugErrorAtom.reportRead();
    return super.debugError;
  }

  @override
  set debugError(bool value) {
    _$debugErrorAtom.reportWrite(value, super.debugError, () {
      super.debugError = value;
    });
  }

  late final _$validateFormAsyncAction =
      AsyncAction('AuthStoreBase.validateForm', context: context);

  @override
  Future<bool> validateForm() {
    return _$validateFormAsyncAction.run(() => super.validateForm());
  }

  late final _$AuthStoreBaseActionController =
      ActionController(name: 'AuthStoreBase', context: context);

  @override
  dynamic setDebugError(bool value) {
    final _$actionInfo = _$AuthStoreBaseActionController.startAction(
        name: 'AuthStoreBase.setDebugError');
    try {
      return super.setDebugError(value);
    } finally {
      _$AuthStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
debugError: ${debugError}
    ''';
  }
}
