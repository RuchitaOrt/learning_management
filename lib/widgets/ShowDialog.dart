
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learning_mgt/Utils/learning_colors.dart';
import 'package:learning_mgt/main.dart';



class ShowDialogs {
 

  static Future<void> showLoadingDialog(BuildContext context, GlobalKey key,
      {String message = "Loading..", bool setForLightScreen = false}) async {
    Future.delayed(
      Duration(microseconds: 300),
      () {
        showLoadingDialogWithDelay(context, key, message, setForLightScreen);
      },
    );
  }
  static Future<void> showLoadingDialogWithDelay(BuildContext context,
      GlobalKey key, String message, bool setForLightScreen) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Material(
            key: key,
            type: MaterialType.transparency,
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //  CircularProgressIndicator()
                CircularProgressIndicator(
                    color: setForLightScreen ? Colors.black : Colors.white),
                SizedBox(height: 15),
                Text(message,
                    style: TextStyle(
                        color: setForLightScreen ? Colors.black : Colors.white))
              ],
            )),
          );
        });
  }




  static void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        textColor:LearningColors.neutralBlue850,
        backgroundColor: Colors.white,
        fontSize: 14.0);
  }
static exitDialog()
{
  showDialog(
    context: routeGlobalKey.currentContext!,
    builder: (context) => AlertDialog(
      title: Text('Exit App'),
      content: Text('Are you sure you want to exit?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close dialog
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            SystemNavigator.pop(); // Close the app
          },
          child: Text('Exit'),
        ),
      ],
    ),
  );
  
}
static logoutDialog({required Function onYesPressed})
{
  showDialog(
    context: routeGlobalKey.currentContext!,
    builder: (context) => AlertDialog(
      title: Text('Sign Out'),
      content: Text('Are you sure you want to Sign Out?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close dialog
          },
          child: Text('No'),
        ),
        TextButton(
          onPressed: ()
          {
            onYesPressed();  
    Navigator.of(context).pop(); 
          },
          child: Text('Yes'),
        ),
      ],
    ),
  );
}

static removeConfirmatioon({required Function onYesPressed,String? title,String? subTitle})
{
  showDialog(
    context: routeGlobalKey.currentContext!,
    builder: (context) => AlertDialog(
      title: Text(title!),
      content: Text(subTitle!),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close dialog
          },
          child: Text('No'),
        ),
        TextButton(
          onPressed: ()
          {
            onYesPressed();  
    Navigator.of(context).pop(); 
          },
          child: Text('Yes'),
        ),
      ],
    ),
  );
}
 
}

