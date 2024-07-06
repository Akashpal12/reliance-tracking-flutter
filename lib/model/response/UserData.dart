class UserData {
  final String apiStatus;
  final int appVersion;
  final String appUrl;
  final String appStatus;
  final List<User> userDetails;

  UserData({
    required this.apiStatus,
    required this.appVersion,
    required this.appUrl,
    required this.appStatus,
    required this.userDetails,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      apiStatus: json['API_STATUS'],
      appVersion: json['APPVERSION'],
      appUrl: json['APPURL'],
      appStatus: json['APPSTATUS'],
      userDetails: List<User>.from(
        json['USERDETAILS']['Table'].map((x) => User.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'API_STATUS': apiStatus,
      'APPVERSION': appVersion,
      'APPURL': appUrl,
      'APPSTATUS': appStatus,
      'USERDETAILS': {
        'Table': userDetails.map((user) => user.toJson()).toList(),
      },
    };
  }
}
class User {
  final int utid;
  final String utUserType;
  final String userId;
  final String name;
  final String mobile;
  final int factId;
  final String fName;
  final String fShort;
  final bool gpsFlag;
  final double timeFrom;
  final double timeTo;
  final int leaveFlag;

  User({
    required this.utid,
    required this.utUserType,
    required this.userId,
    required this.name,
    required this.mobile,
    required this.factId,
    required this.fName,
    required this.fShort,
    required this.gpsFlag,
    required this.timeFrom,
    required this.timeTo,
    required this.leaveFlag,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      utid: json['UTID'],
      utUserType: json['UT_USERTYPE'],
      userId: json['USERID'],
      name: json['NAME'],
      mobile: json['MOBILE'],
      factId: json['FACTID'],
      fName: json['F_NAME'],
      fShort: json['F_SHORT'],
      gpsFlag: json['GPS_FLG'],
      timeFrom: json['TIMEFROM'].toDouble(),
      timeTo: json['TIMETO'].toDouble(),
      leaveFlag: json['LEAVEFLG'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UTID': utid,
      'UT_USERTYPE': utUserType,
      'USERID': userId,
      'NAME': name,
      'MOBILE': mobile,
      'FACTID': factId,
      'F_NAME': fName,
      'F_SHORT': fShort,
      'GPS_FLG': gpsFlag,
      'TIMEFROM': timeFrom,
      'TIMETO': timeTo,
      'LEAVEFLG': leaveFlag,
    };
  }
}
