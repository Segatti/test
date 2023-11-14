import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../shared/ui/widgets/views/base_view_widget.dart';
import '../../interactor/stores/auth_store.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late final AuthStore store;
  // alphanumeric with space inside
  static final validCharacters = RegExp(r'^[a-zA-Z0-9\s]+$');

  @override
  void initState() {
    super.initState();
    store = Modular.get<AuthStore>();
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
              Form(
                key: store.keyForm,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Row(
                      children: [
                        SizedBox(width: 8),
                        Text(
                          "Usuário",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: store.email,
                      textAlignVertical: TextAlignVertical.center,
                      maxLength: 20,
                      cursorColor: Colors.black,
                      onChanged: (_) =>
                          (store.debugError) ? store.validateForm() : null,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Preencha este campo';
                        } else if (value.endsWith(" ")) {
                          return 'Não pode terminar com espaço';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        counterText: "",
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
                        contentPadding: const EdgeInsets.only(
                          left: 16.0,
                          bottom: 8.0,
                          top: 8.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Row(
                      children: [
                        SizedBox(width: 8),
                        Text(
                          "Senha",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: store.password,
                      textAlignVertical: TextAlignVertical.center,
                      maxLength: 20,
                      obscureText: true,
                      cursorColor: Colors.black,
                      onChanged: (_) =>
                          (store.debugError) ? store.validateForm() : null,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Preencha este campo';
                        } else if (value.length < 2) {
                          return 'Senha deve ter 2 ou mais caracteres';
                        }  else if (value.endsWith(" ")) {
                          return 'Não pode terminar com espaço';
                        } else if (!validCharacters.hasMatch(value)) {
                          return 'Não é permitido caracter especial';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        counterText: "",
                        contentPadding: const EdgeInsets.only(
                          left: 16.0,
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
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        width: 200,
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          color: Color(0xFF44BD6E),
                        ),
                        child: InkWell(
                          onTap: () async {
                            await store.validateForm();
                            if (store.userLogged) {
                              Modular.to.navigate("/notes/");
                            }
                          },
                          child: const Center(
                            child: Text(
                              "Entrar",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
