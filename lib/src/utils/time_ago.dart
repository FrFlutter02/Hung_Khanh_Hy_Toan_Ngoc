import '../constants/constant_text.dart';

class TimeAgo {
  static String timeAgoSinceDate(int dateString) {
    final DateTime dateNow = DateTime.now();
    final difference =
        dateNow.difference(DateTime.fromMillisecondsSinceEpoch(dateString));

    if (difference.inDays >= 365) {
      print(difference.inDays);
      return '${(difference.inDays / 365).floor()} ${RecipeFeedText.yearAgo}';
    } else if (difference.inDays >= 30) {
      return '${(difference.inDays / 30).floor()} ${RecipeFeedText.monthAgo}';
    } else if ((difference.inDays / 7).floor() >= 1) {
      return '${(difference.inDays / 7).floor()} ${RecipeFeedText.weekAgo}';
    } else if (difference.inDays >= 1) {
      return '${difference.inDays} ${RecipeFeedText.dayAgo}';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} ${RecipeFeedText.hourAgo}';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} ${RecipeFeedText.minuteAgo}';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} ${RecipeFeedText.secondAgo}';
    } else {
      return 'Just now';
    }
  }
}
