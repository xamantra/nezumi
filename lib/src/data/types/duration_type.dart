enum DurationType {
  seconds,
  minutes,
  hours,
}

String getDurationTypeLabel(DurationType type) {
  switch (type) {
    case DurationType.seconds:
      return 'Seconds';
    case DurationType.minutes:
      return 'Minutes';
    case DurationType.hours:
      return 'Hours';
  }
  return '';
}

String getDurationTypeLabelWithValue(DurationType type, double value) {
  switch (type) {
    case DurationType.seconds:
      return (value ?? 0) > 1 ? 'seconds' : 'second';
    case DurationType.minutes:
      return (value ?? 0) > 1 ? 'minutes' : 'minute';
    case DurationType.hours:
      return (value ?? 0) > 1 ? 'hours' : 'hour';
  }
  return '';
}
