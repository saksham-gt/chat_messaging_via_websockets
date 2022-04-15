# Chat Messaging via WebSocket

Integrating ChatMessaging via WebSocket ([socket_io_client](https://pub.dev/packages/socket_io_client) package) in Flutter Application.

The server is also built in Dart. [socket_io](https://pub.dev/packages/socket_io) is used for server side socket integration.

**Demonstrations:**

Video for running the server:

https://user-images.githubusercontent.com/55953830/162538124-26303aeb-8642-4918-ae20-d9c412ad837c.mp4

Replying feature demonstration:

https://user-images.githubusercontent.com/55953830/163651574-85bcae7e-174b-4b31-8af0-ab74fbd6e726.mp4

Subscription to Chat Feature demonstration:

https://user-images.githubusercontent.com/55953830/163652015-c373ef26-4723-40cc-9f4c-b0b3cca59d31.mp4

Report User demo:

https://user-images.githubusercontent.com/55953830/163653080-34932664-5573-4438-afa0-17c0b9adb3c6.mp4



To run this application, there are 4 parts :

**1. Running the server**

**2. Resolving localhost issue (for testing on localhost)**

**3. Running client**

**4. Testing application**

> **1. Running the server**

  1. Go to the `chat_server` directory
  2. Execute `dart run` in the directory
  3. Server should run successfully on localhost.


> **2. Resolving localhost issue (for testing on localhost)**
  
**Question : Why do you face this issue?**
  
**Answer** : For testing we need 2 clients, I for myself took one as my own mobile phone and other the chrome on the current system. 
Now, when we run the server and the client will try to connect to the server (on mobile phone) it'll be through phone's localhost itself and not the system's localhost on which the server is actually running. 
Therefore, it'll show an `Connection refused Error`. To resolve this issue this section is important.
  
  Execute the following command :
  `adb reverse tcp:3000 tcp:3000`
  
  > **3. Running client**
    
   1. Goto the `chat_client` directory
   2. Run `flutter run` to run it on phone.
   3. Parallely, run `flutter run -d chrome` to run the other client on Chrome.
 
 > **4. Testing application**
 
   1. Login with any of the following dummy user name: `Ashwin`, `Shourya`, `Ayush`, `Kunal`, `Piyush`, `Saksham` (case sensitive).
   2. Click the login button.
   3. You'll see a list of Chat users on the application after logging in.
   4. Now, **on the other client** login with any dummy chat user.
   5. Open the corresponding chat of the user logged in other client. 
      (Let's say, I logged in with `Ashwin` on phone and `Saksham` on chrome. 
      Then, click `Saksham` on the phone to open chat of `Ashwin` with `Saksham` and open `Ashwin` chat on chrome)
   6. Now, type a`message`and click send icon on client, you should see the message on both clients.
   
   If you're able to successfully run all the steps then congratulation you've successfully run Chat Messaging application. 🥳🥳
   
   Checkout the code, and raise an issue if you have any doubt.
