import 'package:flutter/material.dart';

class Componentes {
  criaAppBar(titulo, tam, cor, funcao) {
    return AppBar(
      title: criaTexto(titulo, tam, cor),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            funcao();
          },
          icon: const Icon(Icons.home),
        )
      ],
    );
  }

  criaTexto(conteudo, tamanho, cor) {
    return Text(
      conteudo,
      style: TextStyle(fontSize: tamanho, color: cor),
    );
  }

  criaTextField(titulo, ofuscar, tipoTeclado, controlador, msgValidacao) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        keyboardType: tipoTeclado,
        obscureText: ofuscar,
        decoration: InputDecoration(
          labelText: titulo,
          border: const OutlineInputBorder(),
          labelStyle: const TextStyle(
            color: Colors.red,
          ),
        ),
        textAlign: TextAlign.start,
        style: const TextStyle(
          fontSize: 25.0,
        ),
        controller: controlador,
        validator: (value) {
          if (value!.isEmpty) {
            return msgValidacao;
          }
        },
      ),
    );
  }

  criaBotaoRedirect(titulo, funcao, page, controladorForm, context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.all(10),
            height: 80,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(),
              onPressed: () {
                if (controladorForm.currentState!.validate()) {
                  funcao(page);
                }
              },
              child: criaTexto(titulo, 30, Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  criaBotao(titulo, funcao, controladorForm, context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.all(8),
            height: 80,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(),
              onPressed: () {
                if (controladorForm.currentState!.validate()) {
                  funcao();
                }
              },
              child: criaTexto(titulo, 30, Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
