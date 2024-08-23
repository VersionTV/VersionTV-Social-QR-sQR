import 'package:flutter/material.dart';
import 'package:flutter_application_1/home_view.dart';
import 'package:flutter_application_1/services/auth_service.dart';
import 'package:provider/provider.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late Color myColor;
  late Size mediaSize;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberUser = false;//Sonra degistirilecek

  @override
  Widget build(BuildContext context) {
    myColor = const Color.fromRGBO(0, 180, 255, 1);//ana renk
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: myColor,
        image: DecorationImage(
          image: const AssetImage("assets/images/bg.png"),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(myColor.withOpacity(0.2), BlendMode.dstATop),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Positioned(top: 80, child: _buildTop()),
          Positioned(bottom: 0, child: _buildBottom()),
        ]),
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.qr_code_2_outlined,
            size: 100,
            color: Colors.white,
          ),
          Text(
            "sQR",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 40,
                letterSpacing: 2),
          )
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Kayıt Olun",
          style: TextStyle(
              color: myColor, fontSize: 32, fontWeight: FontWeight.w500),
        ),
        _buildGreyText("Lütfen kullanıcı kaydınızı gerçekleştirin."),
        const SizedBox(height: 60),
        _buildGreyText("Adınız"),
        _buildInputField(nameController),
        const SizedBox(height: 40),
        _buildGreyText("Email adresiniz"),
        _buildInputField(emailController),
        const SizedBox(height: 40),
        _buildGreyText("Şifreniz"),
        _buildInputField(passwordController, isPassword: true),
        const SizedBox(height: 20),
        
        const SizedBox(height: 20),
        _buildRegisterButton(),
        const SizedBox(height: 20),
        
      ],
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey),
    );
  }

  Widget _buildInputField(TextEditingController controller,
      {isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: isPassword ? const Icon(Icons.remove_red_eye) : const Icon(Icons.done),
      ),
      obscureText: isPassword,
    );
  }

  Widget _buildRememberForgot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
                value: rememberUser,
                onChanged: (value) {
                  setState(() {
                    rememberUser = value!;
                  });
                }),
            _buildGreyText("Beni Hatırla"),
          ],
        ),
        TextButton(
            onPressed: () {}, child: _buildGreyText("Şifremi unuttum"))
      ],
    );
  }

  Widget _buildRegisterButton() {
     final authService = Provider.of<AuthService>(context);
    return ElevatedButton(
      onPressed: () async {
                try {
                  await authService.register(emailController.text, passwordController.text,nameController.text);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomeView()));
                } catch (e) {
                  print(e);
                  // Kullanıcıya hata mesajı gösterilebilir
                }
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 20,
        shadowColor: myColor,
        
        minimumSize: const Size.fromHeight(60),
      ),
      child: const Text("KAYIT OL"),
    );
  }

  Widget _buildOtherLogin() {
    return Center(
      child: Column(
        children: [
          _buildGreyText("Ya da şununla kayıt ol..."),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
             
              Tab(icon: Image.asset("assets/images/github.png")),
            ],
          )
        ],
      ),
    );
  }
}
