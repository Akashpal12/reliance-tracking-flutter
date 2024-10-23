

class ApiResponse {
  final String apiStatus;
  final UserDetails userDetails;

  ApiResponse({required this.apiStatus, required this.userDetails});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      apiStatus: json['API_STATUS'],
      userDetails: UserDetails.fromJson(json['USERDETAILS']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'API_STATUS': apiStatus,
      'USERDETAILS': userDetails.toJson(),
    };
  }
}

class UserDetails {
  final List<UserDetail> table;

  UserDetails({required this.table});

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        table: List<UserDetail>.from(
            json["Table"].map((x) => UserDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() {
    return {
      'Table': table.map((user) => user.toJson()).toList(),
    };
  }
}

class UserDetail {
  final int utid;
  final String utUserType;
  final String userId;
  final String name;
  final String mobile;
  final String factId;
  final String fName;
  final String fShort;
  final double timeFrom;
  final double timeTo;
  final String leaveFlg;

  UserDetail({
    required this.utid,
    required this.utUserType,
    required this.userId,
    required this.name,
    required this.mobile,
    required this.factId,
    required this.fName,
    required this.fShort,
    required this.timeFrom,
    required this.timeTo,
    required this.leaveFlg,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) {
    return UserDetail(
      utid: json['UTID'],
      utUserType: json['UT_USERTYPE'],
      userId: json['USERID'],
      name: json['NAME'],
      mobile: json['MOBILE'],
      factId: json['FACTID'],
      fName: json['F_NAME'],
      fShort: json['F_SHORT'],
      timeFrom: json['TIMEFROM'],
      timeTo: json['TIMETO'],
      leaveFlg: json['LEAVEFLG'],
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
      'TIMEFROM': timeFrom,
      'TIMETO': timeTo,
      'LEAVEFLG': leaveFlg,
    };
  }
}
