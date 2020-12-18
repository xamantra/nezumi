import 'package:momentum/momentum.dart';
import 'package:nezumi/src/services/index.dart';

mixin CoreMixin<T> on MomentumController<T> {
  ApiService _api;
  ApiService get api {
    _api ??= getService<ApiService>();
    return _api;
  }
}
