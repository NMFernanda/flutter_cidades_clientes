import 'package:flutter/material.dart';
import 'package:projeto_cidades/util/componentes.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();

  redirect(page) {
    Navigator.of(context).pushNamed('/$page');
  }

  viewConsult() {
    Navigator.of(context).pushNamed('/consulta_cliente');
  }

  viewRegister() {
    Navigator.of(context).pushNamed('/consulta_cidade');
  }

  menuRedirecionar() {
    Navigator.of(context).pushNamed('/consulta_cidade');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Componentes()
          .criaAppBar('API Clientes', 30, Colors.white, menuRedirecionar),
      body: Form(
        key: formController,
        child: Center(
          child: Container(
            width: 400.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Componentes().criaBotaoRedirect("Cidade", redirect,
                    'consulta_cidade', formController, context),
                Componentes().criaBotaoRedirect("Cliente", redirect,
                    'consulta_cliente', formController, context)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
