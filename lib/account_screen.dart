import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/edit_screen.dart';
import 'package:flutter_application_1/home_page.dart';
import 'package:flutter_application_1/login_view.dart';
import 'package:flutter_application_1/widgets/forward_button.dart';
import 'package:flutter_application_1/widgets/setting_item.dart';
import 'package:flutter_application_1/widgets/setting_switch.dart';
import 'package:flutter_application_1/services/auth_service.dart';
import 'package:flutter_application_1/themes/theme_provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        leadingWidth: 80,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Ayarlar",
                style: textTheme.headline1
                    ?.copyWith(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              Text(
                "Hesap",
                style: textTheme.headline2
                    ?.copyWith(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Image.asset("assets/images/avatar.png",
                        width: 70, height: 70),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Profil Ayarları",
                          style: textTheme.bodyText1?.copyWith(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                    const Spacer(),
                    ForwardButton(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditAccountScreen(),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Text(
                "Ayarlar",
                style: textTheme.headline2
                    ?.copyWith(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              /*   const SizedBox(height: 20),
              SettingItem(
                title: "Bildirimler",
                icon: Ionicons.notifications,
                bgColor: Colors.blue.shade100,
                iconColor: Colors.blue,
                onTap: () {},
              ),
              */
              const SizedBox(height: 20),
              SettingSwitch(
                title: "Dark Mode",
                icon: Ionicons.earth,
                bgColor: Colors.purple.shade100,
                iconColor: Colors.purple,
                value: themeProvider.isDarkMode,
                onTap: (value) {
                  themeProvider.toggleTheme();
                },
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: "Çıkış Yap",
                icon: Ionicons.log_out_outline,
                bgColor: Colors.red.shade100,
                iconColor: Colors.red,
                onTap: () async {
                  await authService.signOut();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
