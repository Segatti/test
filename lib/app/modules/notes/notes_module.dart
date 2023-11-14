import 'package:flutter_modular/flutter_modular.dart';

import 'interactor/stores/notes_store.dart';
import 'ui/presenter/notes_page.dart';

class NotesModule extends Module {
  @override
  void binds(Injector i) {
    i.add(NotesStore.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      "/",
      child: (context) => const NotesPage(),
      transition: TransitionType.rightToLeft,
    );
  }
}
