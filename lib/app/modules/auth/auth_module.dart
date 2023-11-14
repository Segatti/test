import 'package:flutter_modular/flutter_modular.dart';

import 'interactor/stores/auth_store.dart';
import 'ui/presenter/auth_page.dart';

class AuthModule extends Module {
  @override
  void binds(Injector i) {
    i.add(AuthStore.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      "/",
      child: (context) => const AuthPage(),
    );
  }
}
