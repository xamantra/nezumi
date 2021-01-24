import 'package:flutter_test/flutter_test.dart';
import 'package:nezumi/src/utils/index.dart';

void main() {
  test('comments.parser_test', () {
    var source = '''-<br />
&lt;scores&gt;<br />
Enjoyment: 4/10<br />
Story: 1.5/6<br />
Visuals: 3.5/6<br />
Characters: 1.5/5<br />
Music: 2.5/3<br />
&lt;/scores&gt;''';

    var expected = '''<scores>
Enjoyment: 4/10
Story: 1.5/6
Visuals: 3.5/6
Characters: 1.5/5
Music: 2.5/3
</scores>''';

    var result = parseScoresRaw(source);
    expect(result, expected);
  });
}
