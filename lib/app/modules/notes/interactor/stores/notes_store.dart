import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'notes_store.g.dart';

class NotesStore = NotesStoreBase with _$NotesStore;

abstract class NotesStoreBase with Store {
  final GlobalKey<FormState> keyForm = GlobalKey();
  final GlobalKey<FormState> keyFormPopup = GlobalKey();
  final TextEditingController note = TextEditingController();
  
  @observable
  TextEditingController noteEdit = TextEditingController();
  @action
  setNoteEdit(String value) => noteEdit.text = value;
  

  @observable
  bool debugError = false;
  @action
  setDebugError(bool value) => debugError = value;

  @observable
  List<String> notes = [];
  @action
  setNotes(List<String> value) => notes = value;

  @action
  Future<void> getNotes() async {
    final SharedPreferences storage = await SharedPreferences.getInstance();
    setNotes(storage.getStringList("notes") ?? []);
  }

  @action
  Future<void> saveNote(String note) async {
    if (keyForm.currentState!.validate()) {
      // Gerando nova hash devido a bug do MobX
      List<String> notesNew = List.from(notes.map((e) => e).toList());
      notesNew.add(note);
      setNotes(notesNew);
      final SharedPreferences storage = await SharedPreferences.getInstance();
      await storage.setStringList("notes", notes);
    } else {
      setDebugError(true);
    }
  }

  @action
  Future<void> editNote(int index) async {
    if (keyFormPopup.currentState!.validate()) {
      notes[index] = noteEdit.text;
      List<String> notesNew = List.from(notes.map((e) => e).toList());
      setNotes(notesNew);
      final SharedPreferences storage = await SharedPreferences.getInstance();
      await storage.setStringList("notes", notes);
    } else {
      setDebugError(true);
    }
  }

  @action
  Future<void> deleteNote(int index) async {
    notes.removeAt(index);
    List<String> notesNew = List.from(notes.map((e) => e).toList());
    setNotes(notesNew);
    final SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setStringList("notes", notes);
  }
}
