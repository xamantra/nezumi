/// `type` is either "list_status" or "my_list_status"
String allAnimeListParams({
  String type = 'list_status',
  List<String> omit = const [],
  bool list_status_only = false,
}) {
  var status = [list_status_status, list_status_score, list_status_num_episodes_watched, list_status_is_rewatching, list_status_updated_at, list_status_comments, list_status_tags, list_status_priority, list_status_num_times_rewatched, list_status_rewatch_value, list_status_start_date, list_status_finish_date]..removeWhere((x) => omit.any((y) => x == y));

  if (list_status_only) {
    return '$type{${status.join(",")}}';
  }

  var props = [synopsis, start_date, end_date, alternative_titles, num_episodes, status, genres, studios, producers, rating, source, mean, rank, popularity, num_list_users, num_scoring_users, created_at, updated_at, media_type, start_season, broadcast, average_episode_duration, background, nsfw, pictures, related_anime, related_manga, recommendations, statistics]..removeWhere((x) => omit.any((y) => x == y));

  return '$type{${status.join(",")}},${props.join(",")}';
}

const list_status_status = 'status';
const list_status_score = 'score';
const list_status_num_episodes_watched = 'num_episodes_watched';
const list_status_is_rewatching = 'is_rewatching';
const list_status_updated_at = 'updated_at';
const list_status_comments = 'comments';
const list_status_tags = 'tags';
const list_status_priority = 'priority';
const list_status_num_times_rewatched = 'num_times_rewatched';
const list_status_rewatch_value = 'rewatch_value';
const list_status_start_date = 'start_date';
const list_status_finish_date = 'finish_date';

const synopsis = 'synopsis';
const start_date = 'start_date';
const end_date = 'end_date';
const alternative_titles = 'alternative_titles';
const num_episodes = 'num_episodes';
const status = 'status';
const genres = 'genres';
const studios = 'studios';
const producers = 'producers';
const rating = 'rating';
const source = 'source';
const mean = 'mean';
const rank = 'rank';
const popularity = 'popularity';
const num_list_users = 'num_list_users';
const num_scoring_users = 'num_scoring_users';
const created_at = 'created_at';
const updated_at = 'updated_at';
const media_type = 'media_type';
const start_season = 'start_season';
const broadcast = 'broadcast';
const average_episode_duration = 'average_episode_duration';
const background = 'background';

// anime details
const nsfw = 'nsfw';
const pictures = 'pictures';
const related_anime = 'related_anime';
const related_manga = 'related_manga';
const recommendations = 'recommendations';
const statistics = 'statistics';

// omit list
const omitList1 = [
  synopsis,
  background,
  pictures,
  related_anime,
  related_manga,
  recommendations,
  statistics,
];
