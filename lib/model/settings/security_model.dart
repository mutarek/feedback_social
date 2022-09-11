import 'dart:convert';

SecurityModel securityModelFromJson(String str) =>
    SecurityModel.fromJson(json.decode(str));

String securityModelToJson(SecurityModel data) => json.encode(data.toJson());

class SecurityModel {
  SecurityModel({
    this.isText,
    this.isAuthentication,
    this.isSecurityKey,
  });

  bool? isText;
  bool? isAuthentication;
  bool? isSecurityKey;

  factory SecurityModel.fromJson(Map<String, dynamic> json) => SecurityModel(
        isText: json["is_text"],
        isAuthentication: json["is_authentication"],
        isSecurityKey: json["is_security_key"],
      );

  Map<String, dynamic> toJson() => {
        "is_text": isText,
        "is_authentication": isAuthentication,
        "is_security_key": isSecurityKey,
      };
}
