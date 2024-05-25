import 'package:customers_payments/theme/theme_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../app_colors.dart';
import '../../../main.dart';
import 'package:intl/intl.dart';


const int New = 1;
const int Assigned = 2;
const int WorkStarted = 3;
const int WorkPaused = 4;
const int WorkEnd = 5;
const int Approved = 6;
const int Rejected = 7;
const int Closed = 8;

double heightInPercentage(double percentValue) {
  double screenHeight =
      MediaQuery.of(globalNavigatorKey.currentContext!).size.height;
  // Set the desired percentage height
  double percentageHeight =
      percentValue; // Replace with your desired percentage
  // Calculate the actual height in pixels
  double containerHeight = (screenHeight * percentageHeight) / 100.0;
  return containerHeight;
}

Color statusColor(String status) {
  Color color;
  switch (status) {
    case "Pending":
      {
        color = AppColors.primaryColor;
      }
      break;
    case "Completed":
      {
        color = AppColors.closedGreen;
      }
      break;
    case "In Progress":
      {
        color = AppColors.inProgressYellow;
      }
      break;
    default:
      {
        color = AppColors.accentColor;
      }
      break;
  }
  return color;
}

String getStatusFromString(String item) {
  if (item.contains('Pending')) {
    return item;
  } else if (item.contains('In Progress')) {
    return item;
  } else if (item.contains('Completed')) {
    return item;
  }
  return item;
}

String getStatusName(int? statusNumber) {
  switch (statusNumber) {
    case New:
      return "New";
    case Assigned:
      return "TO DO";
    case WorkStarted:
      return "Work Started";
    case WorkPaused:
      return "ON GOING";
    case WorkEnd:
      return "Work End";
    case Approved:
      return "Approved";
    case Rejected:
      return "Dispute";
    case Closed:
      return "SOLVED";
    default:
      return "Unknown"; // Handle unknown status numbers
  }
}
//TODO  -Assigned
//ONGOING -WORKSTART -WORKEND -WORKPAUSE -Dispute
//SOLVED -APPROVED -SOLVED

Color statusColorWithId(int? status) {
  Color color;
  switch (status) {
    case 1: // New
      color = AppColors.primaryColor;
      break;
    case 2: // Assigned
      color = AppColors.infoColor;
      break;
    case 3: // Work Started
      color = AppColors.inProgressYellow;
      break;
    case 4: // Work Paused
      color = AppColors.darkGray;
      break;
    case 5: // Work End
      color = AppColors.closedGreen;
      break;
    case 6: // Approved
      color = AppColors.closedGreen;
      break;
    case 7: // Rejected
      color = AppColors.primaryColor;
      break;
    case 8: // Closed
      color = AppColors.closedGreen;
      break;
    default:
      color = AppColors.accentColor;
      break;
  }
  return color;
}


String parseDateTime(String? dateTimeString) {
  try {
    final DateTime dateTime = DateTime.parse(dateTimeString!);
    final String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    return formattedDate;
  } catch (e) {
    // Handle parsing error here if necessary
    return "Not Available";
  }
}

String extractDay(String dateTimeString) {
  try {
    final DateTime dateTime = DateTime.parse(dateTimeString);
    final String formattedDay = DateFormat('dd').format(dateTime); // Extract day
    return formattedDay;
  } catch (e) {
    // Handle parsing error here if necessary
    return dateTimeString;
  }
}

String extractMonth(String dateTimeString) {
  try {
    final DateTime dateTime = DateTime.parse(dateTimeString);
    final String formattedMonth = DateFormat('MMM').format(
        dateTime); // Extract abbreviated month
    return formattedMonth;
  } catch (e) {
    // Handle parsing error here if necessary
    return dateTimeString;
  }
}

Color getPriorityColor(int? priority) {
  switch (priority) {
    case 1:
      return appTheme.redA700;
    case 2:
      return appTheme.blue700;
    case 3:
      return appTheme.lightGreenA700;
    default:
      return appTheme.black900;
  }
}


String getPriorityName(int? priority) {
  switch (priority) {
    case 1:
      return "High";
    case 2:
      return "Medium";
    case 3:
      return "Low";
    default:
      return "Unknown";
  }
}
