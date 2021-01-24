import '../../absract/index.dart';
import '../index.dart';
import '../types/index.dart';

class AnimeFilterTotalDurationData extends AnimeFilterData {
  AnimeFilterTotalDurationData({
    this.durationType = DurationType.minutes,
    this.type = CountFilterType.none,
    this.exactCount = null,
    this.range = const [null, null],
    this.lessThan = null,
    this.moreThan = null,
  });

  final DurationType durationType;
  final CountFilterType type;
  final double exactCount;
  final List<double> range;
  final double lessThan;
  final double moreThan;

  String get label {
    return getCountFilterTypeLabel(type);
  }

  String get durationLabel {
    switch (type) {
      case CountFilterType.none:
        return '';
      case CountFilterType.exactCount:
        return getDurationTypeLabelWithValue(durationType, exactCount);
      case CountFilterType.range:
        return getDurationTypeLabelWithValue(durationType, range[1]);
      case CountFilterType.lessThan:
        return getDurationTypeLabelWithValue(durationType, lessThan);
      case CountFilterType.moreThan:
        return getDurationTypeLabelWithValue(durationType, moreThan);
    }
    return '';
  }

  @override
  bool match(AnimeDetails animeData) {
    try {
      var matcher = convertByType(animeData);
      switch (type) {
        case CountFilterType.none:
          return false;
          break;
        case CountFilterType.exactCount:
          return matcher == exactCount;
          break;
        case CountFilterType.range:
          var min = range[0];
          var max = range[1];
          if (matcher >= min && matcher <= max) {
            return true;
          }
          return false;
          break;
        case CountFilterType.lessThan:
          var matched = matcher > 0 && matcher < lessThan;
          return matched;
          break;
        case CountFilterType.moreThan:
          var matched = matcher > moreThan;
          return matched;
          break;
      }
    } catch (e) {
      return false;
    }

    return false;
  }

  double convertByType(AnimeDetails animeData) {
    var averageEpisodeDuration = animeData?.averageEpisodeDuration ?? 0;
    var numEpisodes = animeData?.numEpisodes ?? 0;
    var totalDuration = averageEpisodeDuration * numEpisodes;
    var matcher = 0.0;
    switch (durationType) {
      case DurationType.seconds:
        matcher = totalDuration.toDouble();
        break;
      case DurationType.minutes:
        matcher = double.parse((totalDuration / 60).toStringAsFixed(1));
        break;
      case DurationType.hours:
        var minutes = double.parse((totalDuration / 60).toStringAsFixed(1));
        matcher = double.parse((minutes / 60).toStringAsFixed(1));
        break;
    }
    return matcher;
  }

  AnimeFilterTotalDurationData copyWith({
    CountFilterType type,
    DurationType durationType,
    double exactCount,
    List<double> range,
    double lessThan,
    double moreThan,
  }) {
    return AnimeFilterTotalDurationData(
      type: type ?? this.type,
      durationType: durationType ?? this.durationType,
      exactCount: exactCount ?? this.exactCount,
      range: range ?? this.range,
      lessThan: lessThan ?? this.lessThan,
      moreThan: moreThan ?? this.moreThan,
    );
  }
}
