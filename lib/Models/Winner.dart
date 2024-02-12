// ignore_for_file: file_names

class Winner {
  int? id;
  String? winnerName;
  String? groupname;
  String? winnermnth;
  String? createdAt;
  String? updatedAt;

  Winner(
      {this.id,
      this.winnerName,
      this.groupname,
      this.winnermnth,
      this.createdAt,
      this.updatedAt});

  Winner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    winnerName = json['winner_name'];
    groupname = json['groupname'];
    winnermnth = json['winnermnth'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['winner_name'] = this.winnerName;
    data['groupname'] = this.groupname;
    data['winnermnth'] = this.winnermnth;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
