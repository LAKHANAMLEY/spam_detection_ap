// To parse this JSON data, do
//
//     final blockedContactListResponse = blockedContactListResponseFromJson(jsonString);

import 'dart:convert';

BlockedContactListResponse blockedContactListResponseFromJson(String str) =>
    BlockedContactListResponse.fromJson(json.decode(str));

String blockedContactListResponseToJson(BlockedContactListResponse data) =>
    json.encode(data.toJson());

class BlockedContactListResponse {
  final int? statusCode;
  final List<BlockedContact>? blockcontactslist;

  BlockedContactListResponse({
    this.statusCode,
    this.blockcontactslist,
  });

  factory BlockedContactListResponse.fromJson(Map<String, dynamic> json) =>
      BlockedContactListResponse(
        statusCode: json["status_code"],
        blockcontactslist: json["blockcontactslist"] == null
            ? []
            : List<BlockedContact>.from(json["blockcontactslist"]!
                .map((x) => BlockedContact.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "blockcontactslist": blockcontactslist == null
            ? []
            : List<dynamic>.from(blockcontactslist!.map((x) => x.toJson())),
      };
}

class BlockedContact {
  final String? id;
  final String? mobileNo;
  final String? comments;
  final String? name;

  BlockedContact({
    this.id,
    this.mobileNo,
    this.comments,
    this.name,
  });

  factory BlockedContact.fromJson(Map<String, dynamic> json) => BlockedContact(
        id: json["id"],
        mobileNo: json["mobile_no"],
        comments: json["comments"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mobile_no": mobileNo,
        "comments": comments,
        "name": name,
      };
}
