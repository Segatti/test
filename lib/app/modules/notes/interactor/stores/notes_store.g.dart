// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NotesStore on NotesStoreBase, Store {
  late final _$noteEditAtom =
      Atom(name: 'NotesStoreBase.noteEdit', context: context);

  @override
  TextEditingController get noteEdit {
    _$noteEditAtom.reportRead();
    return super.noteEdit;
  }

  @override
  set noteEdit(TextEditingController value) {
    _$noteEditAtom.reportWrite(value, super.noteEdit, () {
      super.noteEdit = value;
    });
  }

  late final _$debugErrorAtom =
      Atom(name: 'NotesStoreBase.debugError', context: context);

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

  late final _$notesAtom = Atom(name: 'NotesStoreBase.notes', context: context);

  @override
  List<String> get notes {
    _$notesAtom.reportRead();
    return super.notes;
  }

  @override
  set notes(List<String> value) {
    _$notesAtom.reportWrite(value, super.notes, () {
      super.notes = value;
    });
  }

  late final _$getNotesAsyncAction =
      AsyncAction('NotesStoreBase.getNotes', context: context);

  @override
  Future<void> getNotes() {
    return _$getNotesAsyncAction.run(() => super.getNotes());
  }

  late final _$saveNoteAsyncAction =
      AsyncAction('NotesStoreBase.saveNote', context: context);

  @override
  Future<void> saveNote(String note) {
    return _$saveNoteAsyncAction.run(() => super.saveNote(note));
  }

  late final _$editNoteAsyncAction =
      AsyncAction('NotesStoreBase.editNote', context: context);

  @override
  Future<void> editNote(int index) {
    return _$editNoteAsyncAction.run(() => super.editNote(index));
  }

  late final _$deleteNoteAsyncAction =
      AsyncAction('NotesStoreBase.deleteNote', context: context);

  @override
  Future<void> deleteNote(int index) {
    return _$deleteNoteAsyncAction.run(() => super.deleteNote(index));
  }

  late final _$NotesStoreBaseActionController =
      ActionController(name: 'NotesStoreBase', context: context);

  @override
  dynamic setNoteEdit(String value) {
    final _$actionInfo = _$NotesStoreBaseActionController.startAction(
        name: 'NotesStoreBase.setNoteEdit');
    try {
      return super.setNoteEdit(value);
    } finally {
      _$NotesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setDebugError(bool value) {
    final _$actionInfo = _$NotesStoreBaseActionController.startAction(
        name: 'NotesStoreBase.setDebugError');
    try {
      return super.setDebugError(value);
    } finally {
      _$NotesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setNotes(List<String> value) {
    final _$actionInfo = _$NotesStoreBaseActionController.startAction(
        name: 'NotesStoreBase.setNotes');
    try {
      return super.setNotes(value);
    } finally {
      _$NotesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
noteEdit: ${noteEdit},
debugError: ${debugError},
notes: ${notes}
    ''';
  }
}
