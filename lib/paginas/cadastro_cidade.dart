import 'package:flutter/material.dart';
import 'package:projeto_cidades/api/acessoApi.dart';
import 'package:projeto_cidades/model/cidade.dart';
import 'package:projeto_cidades/util/componentes.dart';

class CadastroCidade extends StatefulWidget {
  const CadastroCidade({super.key});

  @override
  State<CadastroCidade> createState() => _CadastroCidadeState();
}

class _CadastroCidadeState extends State<CadastroCidade> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  TextEditingController txtNome = TextEditingController();
  TextEditingController txtUf = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Cidade;
    txtNome.text = args.nome;
    txtUf.text = args.uf.toString();

    salvar() async {
      Cidade c = Cidade(args.id, txtNome.text, txtUf.text);
      if (c.id == 0) {
        await AcessoApi().insereCidade(c.toJson());
      } else {
        await AcessoApi().alteraCidade(c.toJson());
      }
      Navigator.of(context).pushNamed('/consulta_cidade');
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
                Componentes().criaTextField("Estado", false, TextInputType.text,
                    txtUf, "Digite o estado"),
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
