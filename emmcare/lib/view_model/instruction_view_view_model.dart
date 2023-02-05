import 'package:emmcare/data/response/api_response.dart';
import 'package:flutter/cupertino.dart';

import '../model/instruction_model.dart';
import '../repository/instruction_repository.dart';

class InstructionViewViewModel with ChangeNotifier {
  final _myRepo = InstructionRepository();

  ApiResponse<InstructionModel> instructionList = ApiResponse.loading();

  setInstructionList(ApiResponse<InstructionModel> response) {
    instructionList = response;
    notifyListeners();
  }

  Future<void> fetchInstructionListApi() async {
    setInstructionList(ApiResponse.loading());
    _myRepo.fetchInstructionList().then(
      (value) {
        setInstructionList(ApiResponse.completed(value));
      },
    ).onError(
      (error, stackTrace) {
        setInstructionList(ApiResponse.error(error.toString()));
      },
    );
  }
}
