import 'index.dart';

const _opening = '<scores>';
const _closing = '</scores>';

String parseScoresRaw(String comment) {
  var deformat = stringReplace(comment, {
    '&lt;': '<',
    '&gt;': '>',
    '<br />': '',
    '<br/>': '',
  });

  var hasScoresTag = deformat.contains(_opening) && deformat.contains(_closing);

  if (hasScoresTag) {
    var startsAt1 = deformat.indexOf(_opening);
    var startsAt2 = deformat.lastIndexOf(_opening);
    if (startsAt1 != startsAt2) {
      return '';
    }

    var endsAt1 = deformat.indexOf(_closing);
    var endsAt2 = deformat.lastIndexOf(_closing);
    if (endsAt1 != endsAt2) {
      return '';
    }

    var result = deformat.substring(startsAt1, endsAt2 + 9);
    return result;
  } else {
    return '';
  }
}
