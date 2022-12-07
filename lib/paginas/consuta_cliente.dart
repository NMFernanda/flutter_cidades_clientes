import 'package:flutter/material.dart';
import 'package:projeto_cidades/api/acessoApi.dart';
import 'package:projeto_cidades/model/cidade.dart';
import 'package:projeto_cidades/model/cliente.dart';
import 'package:projeto_cidades/util/combo_cidade.dart';
import 'package:projeto_cidades/util/componentes.dart';

class ConsultaCliente extends StatefulWidget {
  const ConsultaCliente({super.key});

  @override
  State<ConsultaCliente> createState() => _ConsultaClienteState();
}

class _ConsultaClienteState extends State<ConsultaCliente> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  TextEditingController txtCidade = TextEditingController();

  List<Cliente> lista = [];

  listaTodosClientes() async {
    List<Cliente> clientes = await AcessoApi().listaClientes();
    setState(() {
      lista = clientes;
    });
  }

  listaPorCidade(int cidade) async {
    List<Cliente> clientesPorCidade =
        await AcessoApi().pesquisaPorCidade(cidade);
    setState(() {
      lista = clientesPorCidade;
    });
  }

  criaItemCliente(Cliente p, context) {
    String sexo = p.sexo == 'M' ? "Masculino" : "Feminino";
    return ListTile(
      title: Componentes().criaTexto("${p.id} - ${p.nome}", 12, Colors.black),
      subtitle: Componentes().criaTexto(
          "${p.idade} anos - ${sexo} - ${p.cidade.nome}/${p.cidade.uf}",
          12,
          Colors.black),
      trailing: FittedBox(
        fit: BoxFit.fill,
        child: Row(
          children: [
            IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    "/cadastro_cliente",
                    arguments: p,
                  );
                }),
            IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  await AcessoApi().excluiCliente(p.id);
                  setState(() {
                    listaTodosClientes();
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
    listaTodosClientes();
  }

  @override
  Widget build(BuildContext context) {
    irTelaCadastro() {
      Navigator.pushNamed(
        context,
        "/cadastro_cliente",
        arguments: Cliente(0, "", "", 0, Cidade(0, "", "")),
      );
    }

    menuRedirecionar() {
      Navigator.of(context).pushNamed('/');
    }

    return Scaffold(
      appBar: Componentes().criaAppBar(
          'Consulta de Cliente', 30, Colors.white, menuRedirecionar),
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
                      child: ComboCidade(
                        controller: txtCidade,
                        cEditar: 0,
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
                              listaPorCidade(int.parse(txtCidade.text));
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
                  child: Componentes().criaBotao("Listar todos os clientes",
                      listaTodosClientes, formController, context),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: lista.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 4,
                          margin: const EdgeInsets.all(3),
                          child: criaItemCliente(lista[index], context),
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
