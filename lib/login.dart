import 'package:flutter/material.dart';

class TelaLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'LOGIN',
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
              ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Usuário',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Senha',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: (){

              }, 
              child: 
                Text('Entrar')
              ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: (){

              }, 
              child: 
                Text('Cadastro')
              )
          ],
        ),
      ),
    );
  }
}
