import 'dart:convert';
import 'dart:io';

import 'package:meta/meta.dart';
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

  Future<void> exportList({
    @required List<ExportAnimeType> types,
    @required List<ExportAnimeField> fields,
    @required List<ExportAnimeItem> items,
    @required String label,
  }) async {
    for (var type in types) {
      switch (type) {
        case ExportAnimeType.markdownTable:
          await exportMarkdownTable(fields: fields, items: items, label: label);
          break;
        case ExportAnimeType.json:
          await exportJSON(fields: fields, items: items, label: label);
          break;
        case ExportAnimeType.jsonForCsvExport:
          await exportJSONForCsvExport(fields: fields, items: items, label: label);
          break;
      }
    }
  }

  Future<void> saveFile({
    @required String content,
    @required String label,
    @required String secondaryLabel,
    @required String fileExt,
  }) async {
    if (await Permission.storage.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
      var timestamp = DateTime.now().millisecondsSinceEpoch;
      var dir = Directory('/storage/emulated/0/Download/');
      var exists = await dir.exists();
      var path = dir.path;
      if (!exists) {
        path += '/storage/emulated/0/Downloads/';
      }
      var name = 'MyAnimeList.Rankings($label).$timestamp.$secondaryLabel.$fileExt';
      var file = File('$path$name');
      await file.create(recursive: true);
      file = await file.writeAsString(content);
      sendEvent(ExportListEvent('Exported file: "$name"'));
    }
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
  Future<void> exportMarkdownTable({
    @required List<ExportAnimeField> fields,
    @required List<ExportAnimeItem> items,
    @required String label,
  }) async {
    var header = _formatRedditHeader(fields);
    var body = _formatRedditBody(fields, items);
    var result = '&#x200B;\n';
    result += '\n$header';
    result += '$body\n';
    result += '\n&#x200B;';

    await saveFile(
      content: result,
      label: label,
      secondaryLabel: 'markdown_table',
      fileExt: 'md',
    );
  }

  Future<void> exportJSON({
    @required List<ExportAnimeField> fields,
    @required List<ExportAnimeItem> items,
    @required String label,
  }) async {
    var jsonList = _getBasedJsonList(fields: fields, items: items);
    var json = jsonEncode(jsonList);
    await saveFile(
      content: json,
      label: label,
      secondaryLabel: 'normal',
      fileExt: 'json',
    );
  }

  Future<void> exportJSONForCsvExport({
    @required List<ExportAnimeField> fields,
    @required List<ExportAnimeItem> items,
    @required String label,
  }) async {
    var jsonList = _getBasedJsonList(fields: fields, items: items);
    var json = jsonEncode(
      {
        'exported': {
          'list': jsonList,
        }
      },
    );
    await saveFile(
      content: json,
      label: label,
      secondaryLabel: 'csv_export',
      fileExt: 'json',
    );
  }

  List<dynamic> _getBasedJsonList({
    @required List<ExportAnimeField> fields,
    @required List<ExportAnimeItem> items,
  }) {
    var jsonList = <dynamic>[];
    for (var item in items) {
      var map = <String, dynamic>{};
      for (var field in fields) {
        switch (field) {
          case ExportAnimeField.id:
            map.putIfAbsent(toLabelExportAnimeField(ExportAnimeField.id), () => item.id);
            break;
          case ExportAnimeField.title:
            map.putIfAbsent(toLabelExportAnimeField(ExportAnimeField.title), () => item.title);
            break;
          case ExportAnimeField.mean:
            map.putIfAbsent(toLabelExportAnimeField(ExportAnimeField.mean), () => item.mean);
            break;
          case ExportAnimeField.userVotes:
            map.putIfAbsent(toLabelExportAnimeField(ExportAnimeField.userVotes), () => item.userVotes);
            break;
          case ExportAnimeField.popularity:
            map.putIfAbsent(toLabelExportAnimeField(ExportAnimeField.popularity), () => item.popularity);
            break;
          case ExportAnimeField.episodes:
            map.putIfAbsent(toLabelExportAnimeField(ExportAnimeField.episodes), () => item.episodes);
            break;
          case ExportAnimeField.duration:
            map.putIfAbsent(toLabelExportAnimeField(ExportAnimeField.duration), () => item.duration);
            break;
          case ExportAnimeField.totalDuration:
            map.putIfAbsent(toLabelExportAnimeField(ExportAnimeField.totalDuration), () => item.totalDuration);
            break;
        }
      }
      jsonList.add(map);
    }
    return jsonList;
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
