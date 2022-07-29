import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notortalamahesaplama/constants/app_constants.dart';
import 'package:notortalamahesaplama/helper/data_helper.dart';
import 'package:notortalamahesaplama/widgets/ders_listesi.dart';
import 'package:notortalamahesaplama/widgets/harf_dropdown_widget.dart';
import 'package:notortalamahesaplama/widgets/kredi_dropdown_widget.dart';
import 'package:notortalamahesaplama/widgets/ortalama_goster.dart';

import '../model/ders.dart';

class OrtalamaHesaplaPage extends StatefulWidget {
  const OrtalamaHesaplaPage({Key? key}) : super(key: key);

  @override
  State<OrtalamaHesaplaPage> createState() => _OrtalamaHesaplaPageState();
}

class _OrtalamaHesaplaPageState extends State<OrtalamaHesaplaPage> {
  double secilenKrediDeger = 4;
  double secilenHarfDeger = 4;
  String girilenDersAdi = '';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Center(
            child: Text(
              Sabitler.baslikText,
              style: Sabitler.baslikStyle,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(flex: 2, child: _buildForm()),
                Expanded(
                    flex: 1,
                    child: OrtalamaGoster(
                        dersSayisi: DataHelper.tumEklenenDersler.length,
                        ortalama: DataHelper.ortalamaHesapla())),
              ],
            ),
            Expanded(
              child: DersListesi(
                onElemanCikarildi: (index) {
                  DataHelper.tumEklenenDersler.removeAt(index);
                  setState(() {});
                },
              ),
            ),
          ],
        ));
  }

  Widget _buildForm() {
    return Form(
      key: formKey,
      child: Column(children: [
        Padding(
          padding: Sabitler.yatayPadding8,
          child: _buildTextFormField(),
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                  padding: Sabitler.yatayPadding8,
                  child: HarfDropdownWidget(
                    onHarfSecildi: (harf) {
                      secilenHarfDeger = harf;
                    },
                  )),
            ),
            Expanded(
              child: Padding(
                  padding: Sabitler.yatayPadding8,
                  child: KrediDropdownWidget(
                    onKrediSecildi: (kredi) {
                      secilenKrediDeger = kredi;
                    },
                  )),
            ),
            IconButton(
              onPressed: _dersEkleveOrtalamaHesapla,
              icon: Icon(Icons.arrow_forward_ios),
              color: Sabitler.anaRenk,
              iconSize: 30,
            )
          ],
        ),
        SizedBox(
          height: 5,
        )
      ]),
    );
  }

  _buildTextFormField() {
    return TextFormField(
      onSaved: (deger) {
        setState(() {
          girilenDersAdi = deger!;
        });
      },
      validator: (s) {
        if (s!.length <= 0) {
          return 'Ders Adi Giriniz';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
          hintText: 'Matematik',
          border: OutlineInputBorder(
              borderRadius: Sabitler.borderRadius, borderSide: BorderSide.none),
          filled: true,
          fillColor: Sabitler.anaRenk.shade100),
    );
  }

  void _dersEkleveOrtalamaHesapla() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      var eklenecekDers = Ders(
          ad: girilenDersAdi,
          harfDegeri: secilenHarfDeger,
          krediDegeri: secilenKrediDeger);
      DataHelper.dersEkle(eklenecekDers);
      setState(() {});
    }
  }
}
