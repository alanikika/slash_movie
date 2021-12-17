library shared;

import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared/common/routes.dart';

export 'common/routes.dart';

class SharedModule extends Module {

  @override
  List<Bind> get binds => [
    Bind((_) => Routes()),
  ];
}