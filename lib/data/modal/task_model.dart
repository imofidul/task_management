class TaskModal {
  String? name;
  String? description;
  String? type;
  String? id;
  int? date;
  bool? isDone;

  TaskModal({this.name, this.description, this.type, this.id,this.date,this.isDone});

  TaskModal.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    type = json['type'];
    id = json['id'];
    date=json['date'];
    isDone=json['isDone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['type'] = type;
    data['id'] = id;
    data['date']=date;
    data['isDone']=isDone;
    return data;
  }
}