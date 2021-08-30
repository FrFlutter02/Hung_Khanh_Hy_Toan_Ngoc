import 'package:intl/intl.dart';

class TimeAgo {
  static String timeAgoSinceDate(int dateString) {
    final DateTime dateNow = DateTime.now();
    final String format = DateFormat('dd-MM')
        .format(DateTime.fromMillisecondsSinceEpoch((dateString)));
    final difference =
        dateNow.difference(DateTime.fromMillisecondsSinceEpoch(dateString));
    if (difference.inDays >= 7) {
      return format;
    } else if ((difference.inDays / 7).floor() >= 1) {
      return '1 week ago';
    } else if (difference.inDays >= 1) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds}s ago';
    } else {
      return 'Just now';
    }
  }
}
