import 'package:flutter/material.dart';

import '../Utils/Color.dart';
import '../services/session.dart';

class CommissionCharge extends StatefulWidget {
  const CommissionCharge({Key? key}) : super(key: key);

  @override
  State<CommissionCharge> createState() => _CommissionChargeState();
}

class _CommissionChargeState extends State<CommissionCharge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.primary,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(15, 54, 140, 1),
        elevation: 0,
        centerTitle: true,
        leading: Container(
          margin: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: Colors.white),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        title: Container(
            padding: const EdgeInsets.all(2),
            child: Text(
              getTranslated(context, "Commission Charge"),
            //  'Commission Charge',
              style: TextStyle(color: Colors.white, fontSize: 24),
            )),
      ),
    );
  }
}
