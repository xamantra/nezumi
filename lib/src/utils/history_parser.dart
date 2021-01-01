import 'package:html/dom.dart';
import 'package:intl/intl.dart';

import '../data/index.dart';

AnimeHistory parseAnimeHistory(Element element) {
  var ts = element.querySelectorAll('td > a');
  if (ts.length > 0) {
    var titleElement = ts[0];
    var id = int.parse(titleElement?.attributes['href'].split('=')[1]);
    var title = titleElement?.text?.trim();
    var episode = element.querySelector('td > strong').text;
    var fuzzyTimeAgo = element.querySelectorAll('td')[1].text.trim();
    DateTime timestamp = parseFuzzyTime(fuzzyTimeAgo);
    var parsed = AnimeHistory(
      id: id,
      title: title,
      episode: episode,
      timestamp: timestamp,
    );
    return parsed;
  }
  return null;
}

DateTime parseFuzzyTime(String from) {
  // Nov 29, 10:23 PM
  DateTime result;
  var time = from.replaceAll('Edit ', '');
  var isToday = time.contains('Today');
  var isYesterday = time.contains('Yesterday');
  if (isToday || isYesterday) {
    var isPM = time.contains(' PM');
    var t = time.replaceAll('Today, ', '').replaceAll('Yesterday, ', '').replaceAll(' AM', '').replaceAll(' PM', '');
    var hm = t.split(':');
    var hour = int.parse(hm[0]);
    if (isPM) {
      if (hour != 12) {
        hour += 12;
      }
    } else {
      if (hour == 12) {
        hour = 0;
      }
    }
    t = [hour, hm[1]].join(':');
    var now = DateTime.now().toUtc().subtract(Duration(hours: 8)); // PST time.
    if (isYesterday) {
      var today = DateFormat('y-MM-d').format(now);
      result = DateFormat('y-MM-d H:mm').parse('$today $t');
      result = result.subtract(Duration(hours: 8));
    } else {
      var today = DateFormat('y-MM-d').format(now);
      result = DateFormat('y-MM-d H:mm').parse('$today $t');
      result = result.add(Duration(hours: 16));
    }
    // MAL => LOCAL
    // Today, 12:52 AM => Yesterday, 4:52 PM ..... (-8 hours)
    // Yesterday, 8:25 PM => Yesterday, 12:25 PM ..... (-8 hours)
    // result = result.subtract(Duration(hours: 8));
  } else if (time.contains('second')) {
    var now = DateTime.now();
    var agoStr = time.replaceAll(' seconds ago', '').replaceAll(' second ago', '');
    var ago = int.parse(agoStr);
    result = now.subtract(Duration(seconds: ago));
  } else if (time.contains('minute')) {
    var now = DateTime.now();
    var agoStr = time.replaceAll(' minutes ago', '').replaceAll(' minute ago', '');
    var ago = int.parse(agoStr);
    result = now.subtract(Duration(minutes: ago));
  } else if (time.contains('hour')) {
    var now = DateTime.now();
    var agoStr = time.replaceAll(' hours ago', '').replaceAll(' hour ago', '');
    var ago = int.parse(agoStr);
    result = now.subtract(Duration(hours: ago));
  } else {
    try {
      // MMM d, H:mm a
      var now = DateTime.now().toUtc().subtract(Duration(hours: 8)); // PST time.
      var day = time.split(', ');
      var isPM = day[1].contains(' PM');
      var _time = day[1].replaceAll(' AM', '').replaceAll(' PM', '');
      var hm = _time.split(':');
      var hour = int.parse(hm[0]);
      if (isPM) {
        if (hour != 12) {
          hour += 12;
        }
      } else {
        if (hour == 12) {
          hour = 0;
        }
      }

      var _t = [hour, hm[1]].join(':');
      var _d = '${day[0]}, $_t';
      var t = '${now.year} $_d';
      result = DateFormat('y MMM d, H:mm').parse(t);
      result = result.add(Duration(hours: 16));
    } catch (e) {
      // MMM d, y H:mm a
      var now = DateTime.now().toUtc().subtract(Duration(hours: 8)); // PST time.
      var day = time.split(', ');
      var year = day[1].split(' ')[0];
      day[1] = day[1].replaceAll(year, '').trim();
      var isPM = day[1].contains(' PM');
      var _time = day[1].replaceAll(' AM', '').replaceAll(' PM', '');
      var hm = _time.split(':');
      var hour = int.parse(hm[0]);
      if (isPM) {
        if (hour != 12) {
          hour += 12;
        }
      } else {
        if (hour == 12) {
          hour = 0;
        }
      }

      var _t = [hour, hm[1]].join(':');
      var _d = '${day[0]}, $_t';
      var t = '$year $_d';
      result = DateFormat('y MMM d, H:mm').parse(t);
      result = result.add(Duration(hours: 16));
    }
  }
  return result;
}
