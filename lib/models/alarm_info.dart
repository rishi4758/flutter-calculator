class AlarmInfo {
  AlarmInfo({
    this.id,
    this.total,
  });

  int id;
  String total;

  factory AlarmInfo.fromJson(Map<String, dynamic> json) => AlarmInfo(
        id: json["id"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "total": total,
      };
}
