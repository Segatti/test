import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
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
                          itemBuilder: (_, index) => SizedBox(
                            height: 55,
                            child: Container(
                              padding: const EdgeInsets.only(left: 16),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: SingleChildScrollView(
                                        physics: const BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        child: Text(
                                          store.notes[index],
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  GestureDetector(
                                    onTap: () {
                                      store.deleteNote(index);
                                    },
                                    child: const Icon(
                                      Icons.cancel,
                                      color: Colors.red,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                ],
                              ),
                            ),
                          ),
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
