import 'package:intl/intl.dart';

final _vnFormatter = NumberFormat('#,###', 'vi_VN');

String formatVnNumber(num value) => _vnFormatter.format(value);

String formatVnDate(DateTime d) =>
    DateFormat('dd/MM/yyyy', 'vi_VN').format(d);
