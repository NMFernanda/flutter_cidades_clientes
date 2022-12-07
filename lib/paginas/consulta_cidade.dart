import 'package:flutter/material.dart';
import 'package:projeto_cidades/api/acessoApi.dart';
import 'package:projeto_cidades/model/cidade.dart';
import 'package:projeto_cidades/util/combo_cidade.dart';
import 'package:projeto_cidades/util/combo_uf.dart';
import 'package:projeto_cidades/util/componentes.dart';

class ConsultaCidade extends StatefulWidget {
  const ConsultaCidade({super.key});

  @override
  State<ConsultaCidade> createState() => _ConsultaCidadeState();
}

class _ConsultaCidadeState extends State<ConsultaCidade> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  TextEditingController txtUf = TextEditingController();

  List<Cidade> lista = [];

  listarTodasCidades() async {
    List<Cidade> cidades = await AcessoApi().listaCidades();
    setState(() {
      lista = cidades;
    });
  }

  listarPorUf(String uf) async {
    List<Cidade> cidadeUf = await AcessoApi().listarPorUf(uf);
    setState(() {
      lista = cidadeUf;
    });
  }

  criaItemCidade(Cidade c, context) {
    return ListTile(
      title: Text('${c.id} - ${c.nome} - ${c.uf}'),
      trailing: FittedBox(
        fit: BoxFit.fill,
        child: Row(
          children: [
            IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    "/cadastro_cidade",
                    arguments: c,
                  );
                }),
            IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  await AcessoApi().excluiCidade(c.id);
                  setState(() {
                    listarTodasCidades();
                  });
                }),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    listarTodasCidades();
  }

  @override
  Widget build(BuildContext context) {
    irTelaCadastro() {
      Navigator.pushNamed(
        context,
        "/cadastro_cidade",
        arguments: Cidade(0, "", ""),
      );
    }

    menuRedirecionar() {
      Navigator.of(context).pushNamed('/');
    }

    return Scaffold(
      appBar: Componentes()
          .criaAppBar('Consulta de Cidade', 30, Colors.white, menuRedirecionar),
      body: Form(
        key: formController,
        child: Center(
          child: Container(
            width: 400.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.list,
                  size: 100.0,
                  color: Colors.red,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: ComboUf(
                        controller: txtUf,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(),
                          onPressed: () {
                            if (formController.currentState!.validate()) {
                              listarPorUf(txtUf.text);
                            }
                          },
                          child: Componentes()
                              .criaTexto("Filtrar", 25, Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                  child: Componentes().criaBotao("Listar todas as cidades",
                      listarTodasCidades, formController, context),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: lista.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 6,
                          margin: const EdgeInsets.all(5),
                          child: criaItemCidade(lista[index], context),
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: irTelaCadastro,
        child: const Icon(Icons.add),
      ),
    );
  }
}
