import 'dart:convert';

class AttendanceResponseModel {
  final String? message;
  final List<Attendance>? data;

  AttendanceResponseModel({
    this.message,
    this.data,
  });

  factory AttendanceResponseModel.fromJson(String str) =>
      AttendanceResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AttendanceResponseModel.fromMap(Map<String, dynamic> json) =>
      AttendanceResponseModel(
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Attendance>.from(
                json["data"]!.map((x) => Attendance.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class Attendance {
  final int? id;
  final int? userId;
  final DateTime? date;
  final String? timeIn;
  final String? timeOut;
  final String? latlongIn;
  final String? latlongOut;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Attendance({
    this.id,
    this.userId,
    this.date,
    this.timeIn,
    this.timeOut,
    this.latlongIn,
    this.latlongOut,
    this.createdAt,
    this.updatedAt,
  });

  factory Attendance.fromJson(String str) =>
      Attendance.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Attendance.fromMap(Map<String, dynamic> json) => Attendance(
        // id: json["id"],
        // userId: json["user_id"],

        id: json["id"] != null
            ? int.tryParse(json["id"].toString())
            : null, // Konversi dari String ke int
        userId: json["user_id"] != null
            ? int.tryParse(json["user_id"].toString())
            : null, // Konversi dari String ke int

        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        timeIn: json["time_in"],
        timeOut: json["time_out"],
        latlongIn: json["latlong_in"],
        latlongOut: json["latlong_out"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "time_in": timeIn,
        "time_out": timeOut,
        "latlong_in": latlongIn,
        "latlong_out": latlongOut,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
