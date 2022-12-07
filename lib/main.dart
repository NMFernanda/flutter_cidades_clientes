import 'package:flutter/material.dart';
import 'package:projeto_cidades/paginas/cadastro_cidade.dart';
import 'package:projeto_cidades/paginas/cadastro_cliente.dart';
import 'package:projeto_cidades/paginas/consulta_cidade.dart';
import 'package:projeto_cidades/paginas/consuta_cliente.dart';
import 'package:projeto_cidades/paginas/home.dart';

void main() {
  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red),
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/cadastro_cliente': (context) => const CadastroCliente(),
        '/consulta_cliente': (context) => const ConsultaCliente(),
        '/consulta_cidade': (context) => const ConsultaCidade(),
        '/cadastro_cidade': (context) => const CadastroCidade(),
      },
    );
  }
}
