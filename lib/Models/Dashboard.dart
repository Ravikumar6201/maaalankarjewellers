// ignore_for_file: file_names, unnecessary_this, prefer_collection_literals, unnecessary_new

class Member {
  dynamic id;
  dynamic groupname;
  dynamic slot;
  dynamic lucky;
  dynamic availableSlots;
  dynamic userId;
  dynamic memberid;
  dynamic phone;
  dynamic firmaddress;
  dynamic state;
  dynamic district;
  dynamic proprietername;
  dynamic dob;
  dynamic marraigedate;
  dynamic proemail;
  dynamic photo;
  dynamic createdAt;
  dynamic updatedAt;

  Member(
      {this.id,
      this.groupname,
      this.slot,
      this.lucky,
      this.availableSlots,
      this.userId,
      this.memberid,
      this.phone,
      this.firmaddress,
      this.state,
      this.district,
      this.proprietername,
      this.dob,
      this.marraigedate,
      this.proemail,
      this.photo,
      this.createdAt,
      this.updatedAt});

  Member.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupname = json['groupname'];
    slot = json['slot'];
    lucky = json['lucky'];
    availableSlots = json['available_slots'];
    userId = json['user_id'];
    memberid = json['memberid'];
    phone = json['phone'];
    firmaddress = json['firmaddress'];
    state = json['state'];
    district = json['district'];
    proprietername = json['proprietername'];
    dob = json['dob'];
    marraigedate = json['marraigedate'];
    proemail = json['proemail'];
    photo = json['photo'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['groupname'] = this.groupname;
    data['slot'] = this.slot;
    data['lucky'] = this.lucky;
    data['available_slots'] = this.availableSlots;
    data['user_id'] = this.userId;
    data['memberid'] = this.memberid;
    data['phone'] = this.phone;
    data['firmaddress'] = this.firmaddress;
    data['state'] = this.state;
    data['district'] = this.district;
    data['proprietername'] = this.proprietername;
    data['dob'] = this.dob;
    data['marraigedate'] = this.marraigedate;
    data['proemail'] = this.proemail;
    data['photo'] = this.photo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class User {
  dynamic id;
  dynamic deviceId;
  dynamic fname;
  dynamic lname;
  dynamic name;
  dynamic groupname;
  dynamic memberid;
  dynamic email;
  dynamic emailVerifiedAt;
  dynamic phone;
  dynamic username;
  dynamic role;
  dynamic status;
  dynamic address;
  dynamic district;
  dynamic block;
  dynamic panchayat;
  dynamic village;
  dynamic image;
  dynamic type;
  dynamic referralCode;
  dynamic createdBy;
  dynamic createdAt;
  dynamic updatedAt;

  User(
      {this.id,
      this.deviceId,
      this.fname,
      this.lname,
      this.name,
      this.groupname,
      this.memberid,
      this.email,
      this.emailVerifiedAt,
      this.phone,
      this.username,
      this.role,
      this.status,
      this.address,
      this.district,
      this.block,
      this.panchayat,
      this.village,
      this.image,
      this.type,
      this.referralCode,
      this.createdBy,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deviceId = json['device_id'];
    fname = json['fname'];
    lname = json['lname'];
    name = json['name'];
    groupname = json['groupname'];
    memberid = json['memberid'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    phone = json['phone'];
    username = json['username'];
    role = json['role'];
    status = json['status'];
    address = json['address'];
    district = json['district'];
    block = json['block'];
    panchayat = json['panchayat'];
    village = json['village'];
    image = json['image'];
    type = json['type'];
    referralCode = json['referral_code'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['device_id'] = this.deviceId;
    data['fname'] = this.fname;
    data['lname'] = this.lname;
    data['name'] = this.name;
    data['groupname'] = this.groupname;
    data['memberid'] = this.memberid;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['phone'] = this.phone;
    data['username'] = this.username;
    data['role'] = this.role;
    data['status'] = this.status;
    data['address'] = this.address;
    data['district'] = this.district;
    data['block'] = this.block;
    data['panchayat'] = this.panchayat;
    data['village'] = this.village;
    data['image'] = this.image;
    data['type'] = this.type;
    data['referral_code'] = this.referralCode;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
//Price Gold And Siliver
class Updateprice {
  dynamic id;
  dynamic goldprice;
  dynamic silverprice;
  dynamic date;
  dynamic createdAt;
  dynamic updatedAt;

  Updateprice(
      {this.id,
      this.goldprice,
      this.silverprice,
      this.date,
      this.createdAt,
      this.updatedAt});

  Updateprice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    goldprice = json['goldprice'];
    silverprice = json['silverprice'];
    date = json['date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['goldprice'] = this.goldprice;
    data['silverprice'] = this.silverprice;
    data['date'] = this.date;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
