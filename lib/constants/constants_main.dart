import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

String naira = '₦';

double referralCut(String role) {
  if (role == 'Employed') {
    return 0.1;
  } else {
    return 0.2;
  }
}

int storeEligibilty = 180;

String formatNumber(double number) {
  if (number.toStringAsFixed(0).length == 4) {
    return "${number.toStringAsFixed(0).substring(0, 1)},${number.toStringAsFixed(0).substring(1)}";
  } else if (number.toStringAsFixed(0).length == 5) {
    return "${number.toStringAsFixed(0).substring(0, 2)},${number.toStringAsFixed(0).substring(2)}";
  } else if (number.toStringAsFixed(0).length == 6) {
    return "${number.toStringAsFixed(0).substring(0, 3)},${number.toStringAsFixed(0).substring(3)}";
  } else if (number.toStringAsFixed(0).length == 7) {
    return "${number.toStringAsFixed(0).substring(0, 1)},${number.toStringAsFixed(0).substring(1, 4)},${number.toStringAsFixed(0).substring(4)}";
  } else {
    return number.toString();
  }
}

String formatMoney(double money) {
  return "$naira${formatNumber(money)}";
}

String getMonthAndYear(DateTime month) {
  switch (month.month) {
    case 1:
      return 'January | ${month.year}';
    case 2:
      return 'February | ${month.year}';
    case 3:
      return 'March | ${month.year}';
    case 4:
      return 'April | ${month.year}';
    case 5:
      return 'May | ${month.year}';
    case 6:
      return 'June | ${month.year}';
    case 7:
      return 'July | ${month.year}';
    case 8:
      return 'August | ${month.year}';
    case 9:
      return 'September | ${month.year}';
    case 10:
      return 'October | ${month.year}';
    case 11:
      return 'November | ${month.year}';
    default:
      return 'December | ${month.year}';
  }
}

String formatDate(DateTime date) {
  const days = [
    'Mon',
    'Tue',
    'Wed',
    'Thur',
    'Fri',
    'Sat',
    'Sun',
  ];

  final dayName = days[date.weekday - 1];

  String suffix;

  if (date.day >= 11 && date.day <= 13) {
    suffix = 'th';
  } else {
    switch (date.day % 10) {
      case 1:
        suffix = 'st';
        break;
      case 2:
        suffix = 'nd';
        break;
      case 3:
        suffix = 'rd';
        break;
      default:
        suffix = 'th';
    }
  }

  return '$dayName, ${date.day}$suffix ${_monthName(date.month)} ${date.year}';
}

String formatDateOrDaysAgo(DateTime date) {
  final now = DateTime.now();

  final today = DateTime(now.year, now.month, now.day);
  final activityDate = DateTime(
    date.year,
    date.month,
    date.day,
  );

  final daysAgo = today.difference(activityDate).inDays;

  if (daysAgo > 30) {
    return formatDate(date);
  }

  if (daysAgo == 0) {
    return 'Today';
  }

  if (daysAgo == 1) {
    return 'Yesterday';
  }

  return '$daysAgo days ago';
}

String _monthName(int month) {
  const months = [
    'Jan',
    'Feb',
    'March',
    'April',
    'May',
    'June',
    'July',
    'Aug',
    'Sept',
    'Oct',
    'Nov',
    'Dec',
  ];

  return months[month - 1];
}

String formatTime(DateTime date) {
  final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
  final minute = date.minute.toString().padLeft(2, '0');
  final period = date.hour >= 12 ? 'Pm' : 'Am';

  return '$hour:$minute $period';
}

String? formatDateShort(DateTime? date) {
  return date == null
      ? null
      : "${date.day}/${date.month}/${date.year.toString().substring(2)}";
}

DateTime monthStart() {
  final now = DateTime.now();
  return DateTime(now.year, now.month, 1);
}

DateTime secondWeek() {
  final now = DateTime.now();
  return DateTime(now.year, now.month, 7);
}

DateTime thirdWeek() {
  final now = DateTime.now();
  return DateTime(now.year, now.month, 14);
}

DateTime fourthWeek() {
  final now = DateTime.now();
  return DateTime(now.year, now.month, 21);
}

DateTime monthEnd() {
  final now = DateTime.now();
  return DateTime(now.year, now.month + 1, 0, 23, 59, 59);
}

DateTime dayStart(DateTime day) {
  return DateTime(day.year, day.month, day.day, 0, 0, 0);
}

DateTime dayEnd(DateTime day) {
  return DateTime(
    day.year,
    day.month,
    day.day,
    23,
    59,
    59,
    999,
  );
}

int dateDifference(DateTime date1, DateTime date2) {
  return date2.difference(date1).inDays.abs();
}

int getMonthDifference(DateTime date1, DateTime date2) {
  int months =
      (date2.year - date1.year) * 12 +
      (date2.month - date1.month);

  if (date2.day < date1.day) {
    months -= 1;
  }

  return months.abs();
}

bool isValidEmail(String email) {
  final emailRegex = RegExp(
    r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$",
  );
  return emailRegex.hasMatch(email);
}

final double salary = 100000;
final double totalAgentTargetStores = 48;

double getAgentsSalary(int monthsRegistered) {
  var percent = (monthsRegistered / totalAgentTargetStores);
  return (salary * percent);
}

const double mobileScreenSmall = 520;

const double mobileScreen = 650;

const double tabletScreenSmall = 950;

const double tabletScreen = 1024;

bool isMobileSmall(BuildContext context) {
  return screenWidth(context) <= mobileScreenSmall;
}

bool isMobile(BuildContext context) {
  return screenWidth(context) <= mobileScreen;
}

bool isTabletSmall(BuildContext context) {
  return screenWidth(context) <= tabletScreenSmall &&
      screenWidth(context) > mobileScreen;
}

bool isTablet(BuildContext context) {
  return screenWidth(context) <= tabletScreenSmall &&
      screenWidth(context) > mobileScreen;
}

double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

var uuid = Uuid();
String uuidGen() {
  return uuid.v4();
}
