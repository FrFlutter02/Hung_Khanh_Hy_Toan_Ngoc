class TimeAgo {
  static String timeAgoSinceDate(int dateString) {
    final DateTime dateNow = DateTime.now();
    final difference =
        dateNow.difference(DateTime.fromMillisecondsSinceEpoch(dateString));

    if (difference.inDays >= 365) {
      print(difference.inDays);
      return '${(difference.inDays / 365).floor()} year ago';
    } else if (difference.inDays >= 30) {
      return '${(difference.inDays / 30).floor()} month ago';
    } else if ((difference.inDays / 7).floor() >= 1) {
      return '${(difference.inDays / 7).floor()} week ago';
    } else if (difference.inDays >= 1) {
      return '${difference.inDays} day ago';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} hour ago';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} second ago';
    } else {
      return 'Just now';
    }
  }
}
