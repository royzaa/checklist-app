import 'package:flutter/material.dart';

class RefreshChecklist extends StatefulWidget {
  const RefreshChecklist(
      {Key? key, required this.child, required this.onRefresh})
      : super(key: key);

  final Widget child;
  final Future Function() onRefresh;

  @override
  _RefreshChecklistState createState() => _RefreshChecklistState();
}

class _RefreshChecklistState extends State<RefreshChecklist> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(onRefresh: widget.onRefresh, child: widget.child);
  }
}
