import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:target_sistemas/app/modules/auth/ui/widgets/auth_field_widget.dart';
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
                    Observer(builder: (_) {
                      return AuthFieldWidget(
                        controller: store.email,
                        title: "Usuário",
                        haveError: store.debugError,
                        validateForm: () => store.validateForm(),
                        isObscureText: false,
                        icon: const Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                      );
                    }),
                    const SizedBox(height: 32),
                    Observer(builder: (_) {
                      return AuthFieldWidget(
                        controller: store.password,
                        title: "Senha",
                        haveError: store.debugError,
                        validateForm: () => store.validateForm(),
                        isObscureText: true,
                        icon: const Icon(
                          Icons.lock,
                          color: Colors.black,
                        ),
                      );
                    }),
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
                            if (await store.validateForm()) {
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
