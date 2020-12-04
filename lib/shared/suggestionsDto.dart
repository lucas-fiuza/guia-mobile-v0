class Suggestion {
  String id;
  String datasuggestion;
  String suggestion;
  String userid;

  Suggestion({this.id, this.datasuggestion, this.suggestion, this.userid});

  Suggestion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    datasuggestion = json['datasuggestion'];
    suggestion = json['suggestion'];
    userid = json['userid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id ?? '';
    data['datasuggestion'] = this.datasuggestion;
    data['suggestion'] = this.suggestion;
    data['userid'] = this.userid;
    return data;
  }
}