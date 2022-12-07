import 'package:flutter/material.dart';
import 'package:projeto_cidades/api/acessoApi.dart';
import 'package:projeto_cidades/model/cidade.dart';
import 'package:projeto_cidades/model/cliente.dart';
import 'package:projeto_cidades/util/combo_cidade.dart';
import 'package:projeto_cidades/util/componentes.dart';
import 'package:projeto_cidades/util/genero.dart';

class CadastroCliente extends StatefulWidget {
  const CadastroCliente({super.key});

  @override
  State<CadastroCliente> createState() => _CadastroClienteState();
}

class _CadastroClienteState extends State<CadastroCliente> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  TextEditingController txtNome = TextEditingController();
  TextEditingController txtSexo = TextEditingController(text: 'M');
  TextEditingController txtIdade = TextEditingController();
  TextEditingController txtCidade = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Cliente;
    txtNome.text = args.nome;
    txtIdade.text = args.idade.toString();
    txtSexo.text = args.sexo;
    txtCidade.text = args.cidade.id.toString();

    salvar() {
      Cliente p = Cliente(args.id, txtNome.text, txtSexo.text,
          int.parse(txtIdade.text), Cidade(int.parse(txtCidade.text), "", ""));
      print(p);
      AcessoApi().insereCliente(p.toJson());
      Navigator.of(context).pushReplacementNamed('/consulta_cliente');
    }

    menuRedirecionar() {
      Navigator.of(context).pushNamed('/');
    }

    return Scaffold(
      appBar: Componentes()
          .criaAppBar('Registro', 30, Colors.white, menuRedirecionar),
      body: Form(
        key: formController,
        child: Center(
          child: Container(
            width: 400.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.person_add,
                  size: 100.0,
                  color: Colors.red,
                ),
                Componentes().criaTextField("Nome", false, TextInputType.text,
                    txtNome, "Digite o nome"),
                Componentes().criaTextField("Idade", false,
                    TextInputType.number, txtIdade, "Digite a idade"),
                Center(
                  child: Genero(
                    controller: txtSexo,
                    gEditar: args.sexo,
                  ),
                ),
                Center(
                  child: ComboCidade(
                    controller: txtCidade,
                    cEditar: args.cidade.id,
                  ),
                ),
                Componentes()
                    .criaBotao("Cadastrar", salvar, formController, context)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
