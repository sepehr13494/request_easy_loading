# Boilerplate Project

The request_easy_loading package helps you to show loading or progress dialog while sending request to server and it doesn't need context for doing that

## Getting Started

The request_easy_loading contains the minimal implementation required to create navigator key and pass it to the library

## How to Use

**Step 1:**

Download or clone this repo by using the link below:

```
https://github.com/zubairehman/flutter-boilerplate-project.git
```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies:

```
flutter pub get 
```

## Boilerplate Features:

* showLoading
* showProgressDialog

Now, lets dive into the lib folder which has the main code for the application.

### Main
Create a navigator key and pass it to the setNavigator method in the request_easy_loading this will manage all the contexts.
Also pass the navigator key to your MaterialApp widget.

This helps you to access current context wherever in the app through:

BuildContext currentContext = navigatorKey.currentState!.context;

and let's get back to our project

```dart

final navigatorKey = GlobalKey<NavigatorState>();  // add this line

void main() {
  WidgetsFlutterBinding.ensureInitialized();   // add this line
  RequestEasyLoading().setNavigatorKey(navigatorKey);   // add this line
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey, // add this line
      home: HomePage(),
    );
  }
}


```

And now you can easily use this line to show loading dialog anywhere in your app.

```dart
showLoading(){
  RequestEasyLoading().showEasyLoading();
}
```

or cancel loading with 
```dart
cancelLoading(){
  RequestEasyLoading().cancelEasyLoading();
}
```

And for the requests that you need to upload a file and you need to show progress dialog simply use:
```dart
showProgressDialog(){
  RequestEasyLoading().showProgressDialog(sent, total);
}
```

For #dio you can use it like this:
```dart
sendFileRequest(){
  dio.post(
      baseUrl,
      data: body,
      onSendProgress:(int sent,int total){
        print("$sent , $total");
        RequestEasyLoading().showProgressDialog(sent,total);
      }
  );
}
```

## Conclusion

I will be happy to answer any questions that you may have on this approach, and if you want to lend a hand with the request_easy_loading then please feel free to submit an issue and/or pull request 🙂
