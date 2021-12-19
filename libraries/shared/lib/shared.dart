library shared;

import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared/common/image_path.dart';
import 'package:shared/common/routes.dart';

export 'common/image_path.dart';
export 'common/routes.dart';
export 'widgets/custom_button.dart';

class SharedModule extends Module {

  @override
  List<Bind> get binds => [
    Bind((_) => Routes()),
    Bind((_) => ImagePath()),
  ];
}