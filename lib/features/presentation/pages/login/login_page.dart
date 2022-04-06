import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tmdb_task/features/data/data_sources/local_data/constant_data.dart';
import 'package:tmdb_task/features/domain/model/login/get_login_model.dart';
import 'package:tmdb_task/features/domain/model/login/post_login.dart';
import 'package:tmdb_task/features/domain/model/session_model.dart';
import 'package:tmdb_task/features/domain/model/token_model.dart';
import 'package:tmdb_task/features/domain/use_cases/case.dart';
import 'package:tmdb_task/features/domain/use_cases/controller/getx_token.dart';
import 'package:tmdb_task/features/presentation/pages/home/home.dart';
import 'package:tmdb_task/features/presentation/pages/login/widget/text_field_decoration.dart';
import 'package:tmdb_task/features/presentation/res/context.dart';
import 'package:tmdb_task/features/presentation/res/injection.dart';
import 'package:tmdb_task/features/presentation/res/loading.dart';
import 'package:tmdb_task/features/presentation/res/toast_utils.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller1;
  late Animation animation1;
  RequestLoginModel loginModel = RequestLoginModel();
  late Animation shade;

  late Animation animation2;

  final formKey = GlobalKey<FormState>();

  final showProgress = false.obs;

  @override
  void initState() {
    super.initState();
    controller1 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation1 = Tween<Offset>(begin: Offset(1.5, 0.0), end: Offset.zero)
        .animate(CurvedAnimation(parent: controller1, curve: Curves.easeIn));
    animation2 = Tween<Offset>(begin: Offset(-1.5, 0.0), end: Offset.zero)
        .animate(
            CurvedAnimation(parent: controller1, curve: Curves.fastOutSlowIn));
    shade = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller1, curve: Curves.fastOutSlowIn));
    controller1.forward();
  }

  @override
  void dispose() {
    super.dispose();
    controller1.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Context _context = Context(context);
    return Scaffold(
      backgroundColor: _context.getTheme().backgroundColor,
      appBar: AppBar(
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
                onTap: () {
                  Get.off(() => HomePage(), transition: Transition.fadeIn);
                },
                child: const Text('skip'))
          ],
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
      ),
      body: Form(
        key: formKey,
        child: Container(
          alignment: Alignment.center,
          child: AnimatedBuilder(
              animation: controller1,
              builder: (animation, child) {
                return SingleChildScrollView(
                  child: SizedBox(
                    height: _context.getHeight(),
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FadeTransition(
                                opacity: shade as Animation<double>,
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(right: 10),
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SlideTransition(
                                position: animation1 as Animation<Offset>,
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  child: TextFormField(
                                    maxLines: 1,
                                    onChanged: (value) {
                                      loginModel.username = value;
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'need to write user name';
                                      }
                                      return null;
                                    },
                                    style: const TextStyle(
                                        fontSize: 15.0, color: Colors.white),
                                    decoration:
                                        getLoginDecoration('', Icons.person),
                                  ),
                                ),
                              ),
                              SlideTransition(
                                position: animation2 as Animation<Offset>,
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  child: TextFormField(
                                    maxLines: 1,
                                    obscureText: true,
                                    onChanged: (value) {
                                      loginModel.password = value;
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'need to write password';
                                      }
                                      return null;
                                    },
                                    style: const TextStyle(
                                        fontSize: 15.0, color: Colors.white),
                                    decoration: getLoginDecoration(
                                        '******', Icons.lock),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Obx(() {
                                if (showProgress.value) {
                                  return Container(
                                    alignment: Alignment.center,
                                    child: ProgressPage(),
                                  );
                                } else {
                                  return Container(
                                    margin: const EdgeInsets.all(10),
                                    child: TextButton(
                                      onPressed: loginMethod,
                                      child: Container(
                                        height: 45,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white,
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 2.0,
                                              spreadRadius: 0.0,
                                              offset: Offset(2.0,
                                                  2.0), // shadow direction: bottom right
                                            )
                                          ],
                                        ),
                                        child: const Text(
                                          'Login',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }

  void loginMethod() async {
    unfocus(context);
    if (formKey.currentState!.validate()) {
     try{
       showProgress(true);
       final controller = Get.find<GetToken>();
       var tokenModel = await controller.getToken();
       if (tokenModel is TokenModel) {
         loginModel.requestToken = tokenModel.requestToken;
       } else {
         throw(tokenModel.toString());
       }
       var response = await sl<Cases>().validateLogin(loginModel);

       if (response is LoginModel) {
         var sessionResponse = await sl<Cases>().createSession(response.requestToken.toString());
         showProgress(false);
         if (sessionResponse is SessionModel) {
           response.sessionID = sessionResponse.sessionId;
           sl<Cases>().setLoginData(response);
           Get.off(() => HomePage(), transition: Transition.fadeIn);
           showToast("success", errorType: MessageErrorType.success);
         } else if (sessionResponse is String) {
           throw(sessionResponse);
         }
       } else if (response is String) {
         throw(response);
       }
     }catch(e){
       showToast(e.toString());
       showProgress(false);
     }
    }
  }
}
