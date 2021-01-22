import 'package:basic_utils/basic_utils.dart';

String normalizeSlug(String slug) {
  try {
    var normal = slug.replaceAll('_', ' ');
    var n = StringUtils.capitalize(normal ?? '?');
    return n;
  } catch (e) {
    return '';
  }
}

String slugify(String normal) {
  try {
    var slug = normal.replaceAll(' ', '_');
    var s = (slug ?? '?').toLowerCase();
    return s;
  } catch (e) {
    return '';
  }
}
