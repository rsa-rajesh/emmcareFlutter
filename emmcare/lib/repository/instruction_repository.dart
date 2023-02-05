import 'package:emmcare/data/network/BaseApiServices.dart';
import 'package:emmcare/data/network/NetworkApiService.dart';
import 'package:emmcare/res/app_url.dart';

import '../model/instruction_model.dart';

class InstructionRepository {
  // Base and Network api Services
  BaseApiServices _apiServices = NetworkApiService();

  Future<InstructionModel> fetchInstructionList() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.instructionEndPoint);
      return response = InstructionModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
