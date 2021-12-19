library core;

import 'package:core/network/dio_client.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CoreModule extends Module {
  final String baseUrl;

  CoreModule({required this.baseUrl});

  @override
  List<Bind> get binds => [
    Bind((_) => Modular.get<DioClient>().dio),
    Bind((_) => DioClient(apiBaseUrl: baseUrl)),
  ];
}