import 'package:flutter/material.dart';

enum sexoEnum { masculino, feminino }

class Genero extends StatefulWidget {
  TextEditingController? controller;
  String? gEditar;
  Genero({Key? key, this.controller, this.gEditar}) : super(key: key);

  @override
  State<Genero> createState() => _GeneroState();
}

class _GeneroState extends State<Genero> {
  sexoEnum? _escolha;

  @override
  Widget build(BuildContext context) {
    print(widget.gEditar);
    if (widget.gEditar == "F") {
      _escolha = sexoEnum.feminino;
      widget.controller?.text = "F";
      widget.gEditar = "";
    } else if (widget.gEditar == "M") {
      _escolha = sexoEnum.masculino;
      widget.controller?.text = "M";
      widget.gEditar = "";
    }
    return Row(
      children: [
        Expanded(
            child: ListTile(
          title: const Text("Masculino"),
          leading: Radio<sexoEnum>(
            value: sexoEnum.masculino,
            groupValue: _escolha,
            onChanged: (sexoEnum? value) {
              setState(() {
                _escolha = value;
                widget.controller?.text = 'M';
              });
            },
          ),
        )),
        Expanded(
            child: ListTile(
          title: const Text("Feminino"),
          leading: Radio<sexoEnum>(
            value: sexoEnum.feminino,
            groupValue: _escolha,
            onChanged: (sexoEnum? value) {
              setState(() {
                _escolha = value;
                widget.controller?.text = 'F';
              });
            },
          ),
        ))
      ],
    );
  }
}
