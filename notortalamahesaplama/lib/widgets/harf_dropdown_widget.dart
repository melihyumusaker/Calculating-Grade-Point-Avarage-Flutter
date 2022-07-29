import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../helper/data_helper.dart';

class HarfDropdownWidget extends StatefulWidget {
  final Function onHarfSecildi;
  const HarfDropdownWidget({required this.onHarfSecildi, Key? key})
      : super(key: key);

  @override
  State<HarfDropdownWidget> createState() => _HarfDropdownWidget();
}

class _HarfDropdownWidget extends State<HarfDropdownWidget> {
  double secilenHarfDeger = 4;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: Sabitler.dropDownPading,
      decoration: BoxDecoration(
          color: Sabitler.anaRenk.shade100.withOpacity(0.3),
          borderRadius: Sabitler.borderRadius),
      child: DropdownButton<double>(
        value: secilenHarfDeger,
        elevation: 16,
        iconEnabledColor: Sabitler.anaRenk.shade200,
        onChanged: (deger) {
          setState(() {
            secilenHarfDeger = deger!;
            widget.onHarfSecildi(secilenHarfDeger);
          });
        },
        items: DataHelper.tumDerslerinHarfleri(),
        underline: Container(),
      ),
    );
  }
}
