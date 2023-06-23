class TaskModal {
  String? name;
  String? description;
  String? type;
  String? id;
  int? date;

  TaskModal({this.name, this.description, this.type, this.id,this.date});

  TaskModal.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    type = json['type'];
    id = json['id'];
    date=json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['type'] = this.type;
    data['id'] = this.id;
    data['date']=this.date;
    return data;
  }
}