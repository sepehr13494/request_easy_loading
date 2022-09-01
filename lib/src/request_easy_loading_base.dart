import 'dart:math';

import 'package:flutter/material.dart';

class RequestEasyLoading {
  late GlobalKey<NavigatorState> _navigatorKey;
  int _count = 0;
  BuildContext? _context;
  bool _showProgress = false;
  GlobalKey<ProgressDialogState> _progressKey = GlobalKey<ProgressDialogState>();

  static final RequestEasyLoading _singleton = RequestEasyLoading._internal();

  factory RequestEasyLoading() {
    return _singleton;
  }

  RequestEasyLoading._internal();

  setNavigatorKey(GlobalKey<NavigatorState> navKey){
    _navigatorKey = navKey;
  }

  Future<void> showEasyLoading() async {
    _count++;
    if (_count == 1) {
      try {
        _showLoading();
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    return;
  }

  Future<void> cancelEasyLoading() async {
    if (_count == 1) {
      try {
        _cancelLoading();
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    _count--;
    return;
  }

  _showLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        barrierColor: Colors.transparent,
        context: _navigatorKey.currentState!.context,
        builder: (context) {
          _context = context;
          return const LoadingDialog();
        },
      );
    });
  }

  _cancelLoading() {
    Navigator.pop(_context!);
  }

  showProgressDialog(int sent, int total) {
    if(_showProgress){
      if(_progressKey.currentState != null){
        if(sent >= total){
          Navigator.pop(_navigatorKey.currentState!.context);
        }
        _progressKey.currentState!.updateProgress(min((sent/total),1));
      }
    }else{
      _showProgress = true;
      _progressKey = GlobalKey<ProgressDialogState>();
      showDialog(context: _navigatorKey.currentState!.context, builder: (context){
        return ProgressDialog(key: _progressKey);
      }).then((value) => _showProgress = false);
    }
  }
}

class ProgressDialog extends StatefulWidget {
  const ProgressDialog({Key? key}) : super(key: key);

  @override
  State<ProgressDialog> createState() => ProgressDialogState();
}

class ProgressDialogState extends State<ProgressDialog> {

  double _value = 0;

  void updateProgress(double value) {
    setState(() {
      _value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadingDialog(value: _value,);
  }
}


class LoadingDialog extends StatelessWidget {
  final double? value;

  const LoadingDialog({
    Key? key,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(MediaQuery
          .of(context)
          .size
          .width - 56) / 2,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.circular(12)),
        height: 56,
        width: 56,
        padding: const EdgeInsets.all(8.0),
        child: CircularProgressIndicator(value: value),
      ),
    );
  }
}
