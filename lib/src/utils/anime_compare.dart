import '../data/index.dart';
import '../data/types/index.dart';

int compareTitle(OrderBy orderBy, AnimeDetails a, AnimeDetails b) {
  switch (orderBy) {
    case OrderBy.ascending:
      return a.title.toLowerCase().compareTo(b.title.toLowerCase());
      break;
    case OrderBy.descending:
      return b.title.toLowerCase().compareTo(a.title.toLowerCase());
      break;
  }
  return 0;
}

int comparePersonalScore(OrderBy orderBy, AnimeDetails a, AnimeDetails b) {
  var a_Score = a.myListStatus?.score ?? 0;
  var b_Score = b.myListStatus?.score ?? 0;
  switch (orderBy) {
    case OrderBy.ascending:
      if (a_Score == 0) {
        return 1;
      }
      return a_Score.compareTo(b_Score);
    case OrderBy.descending:
      if (b_Score == 0) {
        return -1;
      }
      return b_Score.compareTo(a_Score);
  }
  return 0;
}

int compareMean(OrderBy orderBy, AnimeDetails a, AnimeDetails b) {
  switch (orderBy) {
    case OrderBy.ascending:
      if (a.mean == 0) {
        return 1;
      }
      return a.mean.compareTo(b.mean);
    case OrderBy.descending:
      if (b.mean == 0) {
        return -1;
      }
      return b.mean.compareTo(a.mean);
  }
  return 0;
}

int compareScoringMember(OrderBy orderBy, AnimeDetails a, AnimeDetails b) {
  switch (orderBy) {
    case OrderBy.ascending:
      return (a.numScoringUsers ?? 0).compareTo(b.numScoringUsers ?? 0);
      break;
    case OrderBy.descending:
      return (b.numScoringUsers ?? 0).compareTo(a.numScoringUsers ?? 0);
      break;
  }
  return 0;
}

int compareLastUpdated(OrderBy orderBy, AnimeDetails a, AnimeDetails b) {
  switch (orderBy) {
    case OrderBy.ascending:
      if (a.myListStatus == null) {
        return -1;
      }
      return a.myListStatus?.updatedAt?.compareTo(b.myListStatus?.updatedAt);
      break;
    case OrderBy.descending:
      if (b.myListStatus == null) {
        return 1;
      }
      return b.myListStatus?.updatedAt?.compareTo(a.myListStatus?.updatedAt);
      break;
  }
  return 0;
}

int compareMember(OrderBy orderBy, AnimeDetails a, AnimeDetails b) {
  switch (orderBy) {
    case OrderBy.ascending:
      return (a.numListUsers ?? 0).compareTo(b.numListUsers ?? 0);
      break;
    case OrderBy.descending:
      return (b.numListUsers ?? 0).compareTo(a.numListUsers ?? 0);
      break;
  }
  return 0;
}

int compareTotalDuration(OrderBy orderBy, AnimeDetails a, AnimeDetails b) {
  switch (orderBy) {
    case OrderBy.ascending:
      return a.totalDuration.compareTo(b.totalDuration);
      break;
    case OrderBy.descending:
      return b.totalDuration.compareTo(a.totalDuration);
      break;
  }
  return 0;
}

int compareEpisodesWatched(OrderBy orderBy, AnimeDetails a, AnimeDetails b) {
  var a_Eps = a.myListStatus?.numEpisodesWatched ?? 0;
  var b_Eps = b.myListStatus?.numEpisodesWatched ?? 0;
  switch (orderBy) {
    case OrderBy.ascending:
      return a_Eps.compareTo(b_Eps);
    case OrderBy.descending:
      return b_Eps.compareTo(a_Eps);
  }
  return 0;
}

int compareStartWatch(OrderBy orderBy, AnimeDetails a, AnimeDetails b) {
  var a_Start = a.myListStatus?.startDate;
  var b_Start = b.myListStatus?.startDate;
  switch (orderBy) {
    case OrderBy.ascending:
      if (a_Start == null) {
        return -1;
      }
      if (b_Start == null) {
        return 1;
      }
      return a_Start.compareTo(b_Start);
      break;
    case OrderBy.descending:
      if (a_Start == null) {
        return 1;
      }
      if (b_Start == null) {
        return -1;
      }
      return b_Start.compareTo(a_Start);
      break;
  }
  return 0;
}

int compareFinishWatch(OrderBy orderBy, AnimeDetails a, AnimeDetails b) {
  var a_Finish = a.myListStatus?.finishDate;
  var b_Finish = b.myListStatus?.finishDate;
  switch (orderBy) {
    case OrderBy.ascending:
      if (a_Finish == null) {
        return -1;
      }
      if (b_Finish == null) {
        return 1;
      }
      return a_Finish.compareTo(b_Finish);
      break;
    case OrderBy.descending:
      if (a_Finish == null) {
        return 1;
      }
      if (b_Finish == null) {
        return -1;
      }
      return b_Finish.compareTo(a_Finish);
      break;
  }
  return 0;
}

int compareStartAir(OrderBy orderBy, AnimeDetails a, AnimeDetails b) {
  var a_Start = a.startDate;
  var b_Start = b.startDate;
  switch (orderBy) {
    case OrderBy.ascending:
      if (a_Start == null) {
        return -1;
      }
      if (b_Start == null) {
        return 1;
      }
      return a_Start.compareTo(b_Start);
      break;
    case OrderBy.descending:
      if (a_Start == null) {
        return 1;
      }
      if (b_Start == null) {
        return -1;
      }
      return b_Start.compareTo(a_Start);
      break;
  }
  return 0;
}

int compareEndAir(OrderBy orderBy, AnimeDetails a, AnimeDetails b) {
  var a_End = a.endDate;
  var b_End = b.endDate;
  switch (orderBy) {
    case OrderBy.ascending:
      if (a_End == null) {
        return -1;
      }
      if (b_End == null) {
        return 1;
      }
      return a_End.compareTo(b_End);
      break;
    case OrderBy.descending:
      if (a_End == null) {
        return 1;
      }
      if (b_End == null) {
        return -1;
      }
      return b_End.compareTo(a_End);
      break;
  }
  return 0;
}
