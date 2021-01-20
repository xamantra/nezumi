class AnimeUpdateRewatchEvent {
  final int value;

  AnimeUpdateRewatchEvent(this.value);
}

class AnimeUpdateEpisodesEvent {
  final int value;

  AnimeUpdateEpisodesEvent(this.value);
}

class AnimeUpdateError {
  final String message;

  AnimeUpdateError(this.message);
}
