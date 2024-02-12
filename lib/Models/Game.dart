class Upcoming {
  int? id;
  String? groupname;
  String? venue;
  String? gamedate;
  String? gametime;
  String? meetinglink;
  String? createdAt;
  String? updatedAt;

  Upcoming(
      {this.id,
      this.groupname,
      this.venue,
      this.gamedate,
      this.gametime,
      this.meetinglink,
      this.createdAt,
      this.updatedAt});

  Upcoming.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupname = json['groupname'];
    venue = json['venue'];
    gamedate = json['gamedate'];
    gametime = json['gametime'];
    meetinglink = json['meetinglink'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['groupname'] = this.groupname;
    data['venue'] = this.venue;
    data['gamedate'] = this.gamedate;
    data['gametime'] = this.gametime;
    data['meetinglink'] = this.meetinglink;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
