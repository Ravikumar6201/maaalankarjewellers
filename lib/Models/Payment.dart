// ignore_for_file: unnecessary_this, prefer_collection_literals, unnecessary_new

class Paymenthistory {
  dynamic id;
  dynamic date;
  dynamic payMode;
  dynamic razorpayPaymentId;
  dynamic month;
  dynamic amount;
  dynamic currency;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic memberId;

  Paymenthistory(
      {this.id,
      this.date,
      this.payMode,
      this.razorpayPaymentId,
      this.month,
      this.amount,
      this.currency,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.memberId});

  Paymenthistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    payMode = json['pay_mode'];
    razorpayPaymentId = json['razorpay_payment_id'];
    month = json['month'];
    amount = json['amount'];
    currency = json['currency'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    memberId = json['member_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['pay_mode'] = this.payMode;
    data['razorpay_payment_id'] = this.razorpayPaymentId;
    data['month'] = this.month;
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['member_id'] = this.memberId;
    return data;
  }
}

class Paymentlist {
  dynamic id;
  dynamic amount;
  dynamic dueMonth;
  dynamic memberid;
  dynamic bookingSlot;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;

  Paymentlist(
      {this.id,
      this.amount,
      this.dueMonth,
      this.memberid,
      this.bookingSlot,
      this.status,
      this.createdAt,
      this.updatedAt});

  Paymentlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    dueMonth = json['due_month'];
    memberid = json['memberid'];
    bookingSlot = json['booking_slot'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['due_month'] = this.dueMonth;
    data['memberid'] = this.memberid;
    data['booking_slot'] = this.bookingSlot;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Paymentremainder {
  dynamic id;
  dynamic amount;
  dynamic dueMonth;
  dynamic paidMonth;
  dynamic memberid;
  dynamic bookingSlot;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;

  Paymentremainder(
      {this.id,
      this.amount,
      this.dueMonth,
      this.paidMonth,
      this.memberid,
      this.bookingSlot,
      this.status,
      this.createdAt,
      this.updatedAt});

  Paymentremainder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    dueMonth = json['due_month'];
    paidMonth = json['paid_month'];
    memberid = json['memberid'];
    bookingSlot = json['booking_slot'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['due_month'] = this.dueMonth;
    data['paid_month'] = this.paidMonth;
    data['memberid'] = this.memberid;
    data['booking_slot'] = this.bookingSlot;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}