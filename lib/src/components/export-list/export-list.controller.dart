import 'dart:io';

import 'package:momentum/momentum.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../data/index.dart';
import 'index.dart';

class ExportListController extends MomentumController<ExportListModel> {
  @override
  ExportListModel init() {
    return ExportListModel(
      this,
    );
  }

  /// Export into reddit table format as raw text.
  ///
  /// ----Reddit example table syntax----

  /// ```markdown
  /// &#x200B;
  ///
  /// |*COLUMN*|*COLUMN*|*COLUMN*|
  /// |:-|:-|:-|
  /// |[LINK_CELL](http://example.com)|CELL|CELL|
  /// |[LINK_CELL](http://example.com)|CELL|CELL|
  ///
  /// &#x200B;
  ///
  /// ----Reddit example table syntax----
  /// ```
  Future<void> exportRedditTable({
    List<ExportAnimeField> fields,
    List<ExportAnimeItem> items,
  }) async {
    var header = _formatRedditHeader(fields);
    var body = _formatRedditBody(fields, items);
    var result = '&#x200B;\n';
    result += '\n$header';
    result += '$body\n';
    result += '\n&#x200B;';

    if (await Permission.storage.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
      var timestamp = DateTime.now().millisecondsSinceEpoch;
      var dir = Directory('/storage/emulated/0/Download/');
      var exists = await dir.exists();
      var path = dir.path;
      if (!exists) {
        path += '/storage/emulated/0/Downloads/';
      }
      var file = File('${path}MyAnimeList.Rankings.$timestamp.reddit_table.txt');
      await file.create(recursive: true);
      file = await file.writeAsString(result);
      sendEvent(ExportListEvent('Exported rankings to file: "${file.path}".'));
    }
  }

  String _formatRedditHeader(List<ExportAnimeField> fields) {
    var cells = '| *#* |';
    var divider = '|:-|';
    for (var field in fields) {
      var label = toLabelExportAnimeField(field);
      cells += '*$label*|';
      divider += ':-|';
    }
    var result = '$cells\n$divider';
    return result;
  }

  String _formatRedditBody(
    List<ExportAnimeField> fields,
    List<ExportAnimeItem> items,
  ) {
    var result = '';
    for (var i = 0; i < items.length; i++) {
      var item = items[i];
      var title = item.title;
      if (title.length > 40) {
        title = '${title.substring(0, 40)}...';
      }
      var row = '|**${i + 1}**|';
      for (var field in fields) {
        switch (field) {
          case ExportAnimeField.id:
            row += '${item.id}|';
            break;
          case ExportAnimeField.title:
            row += '[$title](https://myanimelist.net/anime/${item.id})|';
            break;
          case ExportAnimeField.mean:
            row += '**${item.mean}**|';
            break;
          case ExportAnimeField.userVotes:
            row += '${item.userVotes}|';
            break;
          case ExportAnimeField.popularity:
            row += '${item.popularity}|';
            break;
          case ExportAnimeField.episodes:
            row += '${item.episodes} eps|';
            break;
          case ExportAnimeField.duration:
            row += '${item.duration} mins/ep|';
            break;
          case ExportAnimeField.totalDuration:
            row += '${item.totalDuration} mins|';
            break;
        }
      }
      result += '\n$row';
    }
    return result;
  }
}
