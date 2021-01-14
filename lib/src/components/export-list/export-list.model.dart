import 'package:momentum/momentum.dart';

import 'index.dart';

class ExportListModel extends MomentumModel<ExportListController> {
  ExportListModel(ExportListController controller) : super(controller);

  @override
  void update() {
    ExportListModel(
      controller,
    ).updateMomentum();
  }
}
