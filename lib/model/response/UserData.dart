final String UserTName = "user";

class UserData {
  String apiStatus;
  int appversion;
  String appurl;
  String appstatus;
  Userdetails userdetails;

  UserData({
    required this.apiStatus,
    required this.appversion,
    required this.appurl,
    required this.appstatus,
    required this.userdetails,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        apiStatus: json["API_STATUS"],
        appversion: json["APPVERSION"],
        appurl: json["APPURL"],
        appstatus: json["APPSTATUS"],
        userdetails: Userdetails.fromJson(json["USERDETAILS"]),
      );

  Map<String, dynamic> toJson() => {
        "API_STATUS": apiStatus,
        "APPVERSION": appversion,
        "APPURL": appurl,
        "APPSTATUS": appstatus,
        "USERDETAILS": userdetails.toJson(),
      };
}

class Userdetails {
  List<UserTable> table;

  Userdetails({
    required this.table,
  });

  factory Userdetails.fromJson(Map<String, dynamic> json) => Userdetails(
        table: List<UserTable>.from(
            json["Table"].map((x) => UserTable.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Table": List<dynamic>.from(table.map((x) => x.toJson())),
      };
}

class UserTable {
  String utid;
  String utUsertype;
  String userid;
  String name;
  String mobile;
  String factid;
  String fName;
  String fShort;
  String gpsFlg;
  String timefrom;
  String timeto;
  String leaveflg;

  UserTable({
    required this.utid,
    required this.utUsertype,
    required this.userid,
    required this.name,
    required this.mobile,
    required this.factid,
    required this.fName,
    required this.fShort,
    required this.gpsFlg,
    required this.timefrom,
    required this.timeto,
    required this.leaveflg,
  });

  factory UserTable.fromJson(Map<String, dynamic> json) => UserTable(
        utid: json["UTID"].toString(), // It is In Int
        utUsertype: json["UT_USERTYPE"],
        userid: json["USERID"],
        name: json["NAME"],
        mobile: json["MOBILE"],
        factid: json["FACTID"].toString(), // It is In Int
        fName: json["F_NAME"],
        fShort: json["F_SHORT"],
        gpsFlg: json["GPS_FLG"].toString(),   // It is In Bool
        timefrom: json["TIMEFROM"].toString(),  // It is In double
        timeto: json["TIMETO"].toString(),  // It is In double
        leaveflg: json["LEAVEFLG"],
      );

  Map<String, dynamic> toJson() => {
        "UTID": utid,
        "UT_USERTYPE": utUsertype,
        "USERID": userid,
        "NAME": name,
        "MOBILE": mobile,
        "FACTID": factid,
        "F_NAME": fName,
        "F_SHORT": fShort,
        "GPS_FLG": gpsFlg,
        "TIMEFROM": timefrom,
        "TIMETO": timeto,
        "LEAVEFLG": leaveflg,
      };
}

class UserFields {
  static final String Id = "id";
  static final String UTID = "UTID";
  static final String UT_USERTYPE = "UT_USERTYPE";
  static final String USERID = "USERID";
  static final String NAME = "NAME";
  static final String MOBILE = "MOBILE";
  static final String FACTID = "FACTID";
  static final String F_NAME = "F_NAME";
  static final String F_SHORT = "F_SHORT";
  static final String GPS_FLG = "GPS_FLG";
  static final String TIMEFROM = "TIMEFROM";
  static final String TIMETO = "TIMETO";
  static final String LEAVEFLG = "LEAVEFLG";
}
