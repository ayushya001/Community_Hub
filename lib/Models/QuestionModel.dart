class QuestionModel {
  QuestionModel({
    required this.By,
    required this.QuestionId,
    required this.Question,
    required this.Time,
    required this.Type,
    required this.Image,
  });
  late final String By;
  late final String QuestionId;
  late final String Question;
  late final String Time;
  late final String Type;
  late final String Image;

  QuestionModel.fromJson(Map<String, dynamic> json){
    By = json['By'] ?? '';
    QuestionId = json['QuestionId'] ?? '';
    Question = json['Question'] ?? '';
    Time = json['Time'] ?? '';
    Type = json['Type'] ?? '';
    Image = json['Image'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['By'] = By;
    _data['QuestionId'] = QuestionId;
    _data['Question'] = Question;
    _data['Time'] = Time;
    _data['Type'] = Type;
    _data['Image'] = Image;
    return _data;
  }
}