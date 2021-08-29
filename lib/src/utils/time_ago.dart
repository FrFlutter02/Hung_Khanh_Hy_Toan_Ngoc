class TimeAgo {
  static String timeAgoSinceDate(int dateString) {
    final DateTime dateNow = DateTime.now();
    final difference =
        dateNow.difference(DateTime.fromMillisecondsSinceEpoch(dateString));
    if (difference.inDays > 8) {
      return dateString.toString();
    } else if ((difference.inDays / 7).floor() >= 1) {
      return '1 week ago';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return '1 day ago';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours}h ago';
    } else if (difference.inHours >= 1) {
      return '1h ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inMinutes >= 1) {
      return '1m ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds}s ago';
    } else {
      return 'Just now';
    }
  }
}
