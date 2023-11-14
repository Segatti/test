import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:target_sistemas/app/modules/notes/ui/widgets/note_line_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../shared/ui/widgets/views/base_view_widget.dart';
import '../../interactor/stores/notes_store.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late final NotesStore store;

  @override
  void initState() {
    super.initState();
    store = Modular.get<NotesStore>();
    store.getNotes();
  }

  deleteNotePopup(BuildContext context, int index) {
    Widget cancelButton = ElevatedButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {
        Navigator.of(context).pop();
        store.deleteNote(index);
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Atenção"),
      content: const Text("Tem certeza que deseja excluir esta nota?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  editNotePopup(BuildContext context, int index) {
    store.setNoteEdit(store.notes[index]);

    Widget cancelButton = ElevatedButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {
        Navigator.of(context).pop();
        store.editNote(index);
      },
    );

    AlertDialog alert = AlertDialog(
      content: Observer(builder: (_) {
        return Form(
          key: store.keyFormPopup,
          child: TextFormField(
            controller: store.noteEdit,
            autofocus: true,
            textAlign: TextAlign.center,
            maxLines: 1,
            onChanged: (_) {
              if (store.debugError) {
                store.keyFormPopup.currentState!.validate();
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Preencha este campo';
              }
              return null;
            },
            cursorColor: Colors.black,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: "Digite seu texto",
              hintStyle: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              alignLabelWithHint: true,
              counterText: "",
              contentPadding: const EdgeInsets.only(
                bottom: 8.0,
                top: 8.0,
              ),
              errorStyle: const TextStyle(
                color: Colors.yellow,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(5),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        );
      }),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseViewWidget(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 64),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Observer(builder: (context) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height * .5,
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          itemBuilder: (_, index) => NoteLineWidget(
                              note: store.notes[index],
                              editPopup: editNotePopup,
                              deletePopup: deleteNotePopup,
                              index: index),
                          separatorBuilder: (_, __) => const Divider(
                            height: 1,
                            color: Colors.grey,
                            thickness: 1.5,
                            indent: 8,
                            endIndent: 8,
                          ),
                          itemCount: store.notes.length,
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 32),
                  Form(
                    key: store.keyForm,
                    child: TextFormField(
                      controller: store.note,
                      autofocus: true,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      onChanged: (_) {
                        if (store.debugError) {
                          store.keyForm.currentState!.validate();
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Preencha este campo';
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) {
                        // Salvar e listar
                        store.saveNote(value);
                        store.note.clear();
                      },
                      onEditingComplete: () {},
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Digite seu texto",
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        alignLabelWithHint: true,
                        counterText: "",
                        contentPadding: const EdgeInsets.only(
                          bottom: 8.0,
                          top: 8.0,
                        ),
                        errorStyle: const TextStyle(
                          color: Colors.yellow,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 48),
                child: GestureDetector(
                  onTap: () async {
                    await launchUrl(
                      Uri.parse("https://www.google.com"),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  child: const Text(
                    "Política de Privacidade",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
