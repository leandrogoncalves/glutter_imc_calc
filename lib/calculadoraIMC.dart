import 'package:flutter/material.dart';

class CalculadoraIMC extends StatefulWidget {
  @override
  _CalculadoraIMCState createState() => _CalculadoraIMCState();
}

class _CalculadoraIMCState extends State<CalculadoraIMC> {
  final TextEditingController _alturaController = TextEditingController();
  final TextEditingController _pesoController = TextEditingController();
  final key = GlobalKey<ScaffoldState>();

  var _btnLimpar = 0;
  var _btnCalcular = 1;
  var _resultado = '';
  var _situacao = '';


  _onItemTapped(int index){
    // debugPrint(index.toString());
    if(index == _btnLimpar){
      _alturaController.clear();
      _pesoController.clear();
      setState(() {
      _resultado =  '';
      _situacao =  '';
      });
    }

    if(index == _btnCalcular){
      if(_pesoController.text.isEmpty || _alturaController.text.isEmpty){
        key.currentState.showSnackBar(
          SnackBar(content: Text('Altura e peso são obrigatórios'), duration: Duration(seconds: 2),)
        );
        return false;
      }

      try{
        var peso = double.parse(_pesoController.text);
        var altura = double.parse(_alturaController.text);
        var imc = peso / (altura * altura);
        setState(() {
          _resultado = 'Seu imc é ${imc.toStringAsFixed(2)}';

          if(imc < 17){
            _situacao = 'Muito abaixo do peso';
          }else if(imc < 18.5){
            _situacao = 'Abaixo do peso';
          }else if(imc < 25){
            _situacao = 'Peso Normal';
          }else if(imc < 30){
            _situacao = 'Acima do peso';
          }else if(imc < 35){
            _situacao = 'Obesidadde 1';
          }else if(imc < 40){
            _situacao = 'Obesidadde 2';
          }else{
            _situacao = 'Obesidadde 3';
          }
        });
      }catch(e){
        key.currentState.showSnackBar(
            SnackBar(content: Text('Altura ou peso inválidos'), duration: Duration(seconds: 2),)
        );
        return false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(title: Text('Calculara IMC')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset('assets/balanca.jpg', width: 90),
          TextField(
            controller: _alturaController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
                hintText: 'Altura',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                icon: Icon(Icons.height)),
          ),
          TextField(
            controller: _pesoController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
                hintText: 'Peso',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                icon: Icon(Icons.accessibility)),
          ),
          Text('${_resultado}', style: TextStyle(fontSize: 30),),
          Text('${_situacao}', style: TextStyle(fontSize: 30),)
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.lightBlue,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.clear, color: Colors.white),
              title: Text('Limpar', style: TextStyle(color: Colors.white),)
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.check,color: Colors.white),
              title: Text('Calcular', style: TextStyle(color: Colors.white),)
          ),
        ],
      ),
    );
  }
}
