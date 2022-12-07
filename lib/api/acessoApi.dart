import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:projeto_cidades/model/cidade.dart';
import 'package:projeto_cidades/model/cliente.dart';

class AcessoApi {
  Future<List<Cliente>> listaClientes() async {
    String url = "http://localhost:8080/cliente";
    http.Response resposta = await http.get(Uri.parse(url));
    String jsonUtf8 = (utf8.decode(resposta.bodyBytes));
    Iterable lista = jsonDecode(jsonUtf8);
    List<Cliente> clientes =
        List<Cliente>.from(lista.map((p) => Cliente.fromJson(p)));
    return clientes;
  }

  Future<List<Cliente>> pesquisaPorCidade(int cidade) async {
    String url = "http://localhost:8080/cliente/cidade/$cidade";
    http.Response resposta = await http.get(Uri.parse(url));
    String jsonUtf8 = (utf8.decode(resposta.bodyBytes));
    Iterable listaPorCidade = jsonDecode(jsonUtf8);
    List<Cliente> clientesPorCidade =
        List<Cliente>.from(listaPorCidade.map((p) => Cliente.fromJson(p)));
    return clientesPorCidade;
  }

  Future<void> insereCliente(Map<String, dynamic> cliente) async {
    String url = "http://localhost:8080/cliente";
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    http.Response resposta = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(cliente));
  }

  Future<void> alteraCliente(Map<String, dynamic> cliente) async {
    String url = "http://localhost:8080/cliente";
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    await http.put(Uri.parse(url), headers: headers, body: jsonEncode(cliente));
  }

  Future<void> excluiCliente(int id) async {
    String url = "http://localhost:8080/cliente/$id";
    await http.delete(Uri.parse(url));
  }

  Future<List<Cidade>> listaCidades() async {
    List<Cidade> cidades = [];

    String url = "http://localhost:8080/cidade";
    http.Response resposta = await http.get(Uri.parse(url));
    if (resposta.statusCode == 200) {
      Iterable listaC = jsonDecode(utf8.decode(resposta.bodyBytes));
      cidades = List<Cidade>.from(listaC.map((c) => Cidade.fromJson(c)));
    } else {
      print(resposta.statusCode);
    }
    return cidades;
  }

  Future<List<Cidade>> listarPorUf(String uf) async {
    List<Cidade> cidadesPorUf = [];

    String url = "http://localhost:8080/cidade/buscauf/$uf";
    http.Response resposta = await http.get(Uri.parse(url));
    if (resposta.statusCode == 200) {
      Iterable listaPorUf = jsonDecode(utf8.decode(resposta.bodyBytes));
      cidadesPorUf =
          List<Cidade>.from(listaPorUf.map((c) => Cidade.fromJson(c)));
    } else {
      print(resposta.statusCode);
    }
    return cidadesPorUf;
  }

  Future<void> insereCidade(Map<String, dynamic> cidade) async {
    String url = "http://localhost:8080/cidade";
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    http.Response resposta = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(cidade));
  }

  Future<void> alteraCidade(Map<String, dynamic> cidade) async {
    String url = "http://localhost:8080/cidade";
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    await http.put(Uri.parse(url), headers: headers, body: jsonEncode(cidade));
  }

  Future<void> excluiCidade(int id) async {
    String url = "http://localhost:8080/cidade/$id";
    await http.delete(Uri.parse(url));
  }
}
