import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  final String message;
  final bool cancelable;

  const Loading(this.message, this.cancelable, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Center(
            child: GestureDetector(
              onTap: () {
                if (cancelable) {
                  Navigator.pop(context);
                }
              },
              child: Container(
                height: 130,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SpinKitWave(
                      color: Colors.indigoAccent,
                      size: 50,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 12, left: 12, right: 12),
                      child: Text(
                        message,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
