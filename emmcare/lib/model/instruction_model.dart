class InstructionModel {
  List<Instruction>? instruction;

  InstructionModel({this.instruction});

  InstructionModel.fromJson(Map<String, dynamic> json) {
    if (json['instruction'] != null) {
      instruction = <Instruction>[];
      json['instruction'].forEach((v) {
        instruction!.add(new Instruction.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.instruction != null) {
      data['instruction'] = this.instruction!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Instruction {
  String? instructions;
  int? id;

  Instruction({this.instructions, this.id});

  Instruction.fromJson(Map<String, dynamic> json) {
    instructions = json['instructions'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['instructions'] = this.instructions;
    data['id'] = this.id;
    return data;
  }
}
