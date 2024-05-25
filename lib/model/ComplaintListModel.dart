import 'package:flutter/material.dart';

class ComplaintListModels {
  String? status;
  String? priority;
  String? date;
  String? equipment;
  String? assigned;
  int? complainId;
  Color? color;
  int? complaintId;
  String? complaintDate;
  String? assignment;
  String? workStart;
  String? workEnd;
  String? make;
  String? model;
  String? serialNo;
  int? equipmentId;

  ComplaintListModels({
    this.complaintId,
    this.complaintDate,
    this.priority,
    this.assignment,
    this.workStart,
    this.workEnd,
    this.equipment,
    this.make,
    this.model,
    this.serialNo,
    this.equipmentId,
    this.status
  });
}
