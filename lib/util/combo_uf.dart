import 'package:flutter/material.dart';
import 'package:projeto_cidades/api/acessoApi.dart';
import 'package:projeto_cidades/model/cidade.dart';
import 'package:projeto_cidades/model/estado.dart';

class ComboUf extends StatefulWidget {
  TextEditingController? controller;

  ComboUf({Key? key, this.controller}) : super(key: key);

  @override
  State<ComboUf> createState() => _ComboUfState();
}

class _ComboUfState extends State<ComboUf> {
  int? estadoSel;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 1))
          .then((value) => AcessoApi().listaCidades()),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          List<Cidade> cities = snapshot.data;
          List<Estado> estados = [];
          cities.forEach((cidade) {
            if ((estados.singleWhere((it) => it.uf == cidade.uf,
                    orElse: () => Estado(0, ""))).uf ==
                "") {
              estados.add(Estado(estados.length, cidade.uf));
            }
          });
          return Padding(
            padding: const EdgeInsets.all(8),
            child: DropdownButton(
                isExpanded: true,
                value: estadoSel,
                icon: const Icon(Icons.arrow_downward),
                hint: const Text('Selecione o estado...'),
                elevation: 16,
                onChanged: (int? value) {
                  int value2 = value?.toInt() ?? 0;
                  String textoUf = estados.elementAt(value2).uf;
                  setState(() {
                    estadoSel = value;
                    widget.controller?.text = textoUf;
                  });
                },
                items: estados.map<DropdownMenuItem<int>>((Estado est) {
                  return DropdownMenuItem<int>(
                      value: est.id, child: Text(est.uf));
                }).toList()),
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [CircularProgressIndicator(), Text('Carregando')],
          );
        }
      },
    );
  }
}
