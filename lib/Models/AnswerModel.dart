class AnswerModel {
  AnswerModel({
    required this.By,
    required this.AnswerId,
    required this.Answer,
    required this.Time,
    required this.Type,
    required this.QuestionId,
  });
  late final String By;
  late final String AnswerId;
  late final String Answer;
  late final String Time;
  late final String Type;
  late final String QuestionId;

  AnswerModel.fromJson(Map<String, dynamic> json){
    By = json['By'] ?? '';
    AnswerId = json['AnswerId'] ?? '';
    Answer = json['Answer'] ?? '';
    Time = json['Time'] ?? '';
    Type = json['Type'] ?? '';
    QuestionId = json['QuestionId'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['By'] = By;
    _data['AnswerId'] = AnswerId;
    _data['Answer'] = Answer;
    _data['Time'] = Time;
    _data['Type'] = Type;
    _data['QuestionId'] = QuestionId;
    return _data;
  }
}