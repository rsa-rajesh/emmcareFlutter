import 'package:emmcare/res/colors.dart';
import 'package:emmcare/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/response/status.dart';
import '../../../view_model/instruction_view_view_model.dart';

class InstructionView extends StatefulWidget {
  const InstructionView({super.key});
  @override
  State<InstructionView> createState() => _InstructionViewState();
}

class _InstructionViewState extends State<InstructionView> {
  InstructionViewViewModel instructionViewViewModel =
      InstructionViewViewModel();

  @override
  void initState() {
    instructionViewViewModel.fetchInstructionListApi();
    super.initState();
    getClientName();
  }

  String? cltName;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bodyBackgroudColor,
      appBar: AppBar(
        title: Text(cltName!),
        centerTitle: true,
        backgroundColor: AppColors.appBarColor,
        automaticallyImplyLeading: true,
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () {
          return refresh();
        },
        child: ChangeNotifierProvider<InstructionViewViewModel>(
          create: (BuildContext context) => instructionViewViewModel,
          child: Consumer<InstructionViewViewModel>(
            builder: (context, value, _) {
              switch (value.instructionList.status) {
                case Status.LOADING:
                  return Center(
                    child: CircularProgressIndicator(),
                  );

                case Status.ERROR:
                  return AlertDialog(
                    icon: Icon(Icons.error_rounded, size: 30),
                    title: Text(
                      value.instructionList.message.toString(),
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
                    ),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                shape: StadiumBorder()),
                            onPressed: () {
                              refresh();
                            },
                            child: Text(
                              'Refresh',
                            ),
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                shape: StadiumBorder()),
                            onPressed: () {
                              SystemChannels.platform
                                  .invokeMethod('SystemNavigator.pop');
                            },
                            child: Text('Abort'),
                          ),
                        ],
                      )
                    ],
                  );

                case Status.COMPLETED:
                  return ListView.builder(
                    itemCount: value.instructionList.data!.instruction!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(
                            value.instructionList.data!.instruction![index]
                                .instructions
                                .toString(),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                      );
                    },
                  );

                default:
                  return Container(); // just to satisfy flutter analyzer
              }
            },
          ),
        ),
      ),
    );
  }

  Future<void> refresh() async {
    setState(() {
      instructionViewViewModel.fetchInstructionListApi();
    });
  }

  Future<void> getClientName() async {
    final sharedpref = await SharedPreferences.getInstance();

    setState(() {
      cltName = sharedpref.getString(HomeViewState.KEYCLIENTNAME)!;
    });
  }
}
