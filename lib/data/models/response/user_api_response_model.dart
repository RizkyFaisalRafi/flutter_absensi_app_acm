import 'dart:convert';

class UserApiResponseModel {
  final int? id;
  final String? name;
  final String? email;
  final int? cuti;
  final DateTime? emailVerifiedAt;
  final dynamic twoFactorSecret;
  final dynamic twoFactorRecoveryCodes;
  final dynamic twoFactorConfirmedAt;
  final String? fcmToken;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? phone;
  final String? role;
  final String? position;
  final String? department;
  final String? faceEmbedding;
  final dynamic imageUrl;

  UserApiResponseModel({
    this.id,
    this.name,
    this.email,
    this.cuti,
    this.emailVerifiedAt,
    this.twoFactorSecret,
    this.twoFactorRecoveryCodes,
    this.twoFactorConfirmedAt,
    this.fcmToken,
    this.createdAt,
    this.updatedAt,
    this.phone,
    this.role,
    this.position,
    this.department,
    this.faceEmbedding,
    this.imageUrl,
  });

  factory UserApiResponseModel.fromJson(String str) =>
      UserApiResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserApiResponseModel.fromMap(Map<String, dynamic> json) =>
      UserApiResponseModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        cuti: json["cuti"],
        emailVerifiedAt: json["email_verified_at"] == null
            ? null
            : DateTime.parse(json["email_verified_at"]),
        twoFactorSecret: json["two_factor_secret"],
        twoFactorRecoveryCodes: json["two_factor_recovery_codes"],
        twoFactorConfirmedAt: json["two_factor_confirmed_at"],
        fcmToken: json["fcm_token"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        phone: json["phone"],
        role: json["role"],
        position: json["position"],
        department: json["department"],
        faceEmbedding: json["face_embedding"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
        "cuti": cuti,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "two_factor_secret": twoFactorSecret,
        "two_factor_recovery_codes": twoFactorRecoveryCodes,
        "two_factor_confirmed_at": twoFactorConfirmedAt,
        "fcm_token": fcmToken,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "phone": phone,
        "role": role,
        "position": position,
        "department": department,
        "face_embedding": faceEmbedding,
        "image_url": imageUrl,
      };
}