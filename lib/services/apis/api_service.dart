// ignore_for_file: avoid_print
import 'package:talaba_uz/utils/tools/file_important.dart';
import '../model/responses/dtm_test_code.dart';

class ApiService extends ApiClient {
  Future<bool> registerUser(
    String name,
    String surname,
    String birth,
    String region,
    String phoneNumber,
    String email,
    String password,
  ) async {
    try {
      Response response =
          await dio.post("$baseUrl/api/v1/accounts/signup/", data: {
        "name": name,
        "surname": surname,
        "birth": birth,
        "region": region,
        "phone_number": phoneNumber,
        "email": email,
        "password": password,
      });

      if (response.statusCode == 200) {
        var auth = Hive.box('auth');
        auth.put("token", response.data["access_token"]);
        // Successful registration
        print("SignUp success: ${response.data}");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        int? userId = response.data['id'];
        String? email = response.data['email'];
        String? name = response.data['name'];
        String? surname = response.data['surname'];
        String? region = response.data['region'];
        String? phone = response.data['phone_number'];
        String? date = response.data['date'];
        prefs.setString('email', email ?? '');
        prefs.setString('name', name ?? '');
        prefs.setString('surname', surname ?? '');
        prefs.setString('region', region ?? '');
        prefs.setString('phone_number', phone ?? '');
        prefs.setString('date', date ?? '');
        prefs.setInt(
            'id', userId ?? 0); // Provide a default value if userId is null

        return true;
      } else {
        // Unsuccessful registration, handle specific error cases
        print("Error Status Code: ${response.statusCode}");
        print("Error Body: ${response.data}");
        return false;
      }
    } on DioError catch (e) {
      // Handle Dio errors with specific information
      if (e.response != null) {
        // The request was made, but the server responded with a non-successful status code
        print("Error Status Code: ${e.response!.statusCode}");
        print("Error Body: ${e.response!.data}");
      } else {
        // Something went wrong while sending the request
        print("DioError: $e");
      }
      return false;
    }
  }

  // final GoogleSignIn _googleSignIn = GoogleSignIn();
  // Future<void> _signIn() async {
  //   try {
  //     final GoogleSignInAccount? user = await _googleSignIn.signIn();
  //     if (user != null) {
  //       final GoogleSignInAuthentication googleAuth = await user.authentication;

  //       final accessToken = googleAuth.accessToken;

  //       if (accessToken != null) {
  //         // Use access token with Dio
  //         dio.options.headers['Authorization'] = 'Bearer $accessToken';

  //         try {
  //           // Make an authenticated request
  //           final response =
  //               await dio.get('https://www.googleapis.com/oauth2/v2/userinfo');
  //           print('User info: ${response.data}');
  //         } catch (error) {
  //           print('Error making request: $error');
  //         }
  //       }
  //     }
  //   } catch (error) {
  //     print('Error signing in: $error');
  //   }
  // }

  // Future<void> _signOut() async {
  //   await _googleSignIn.signOut();
  //   print('User signed out');
  // }

  Future<bool> verifyEmailOTP(String email, String otp) async {
    try {
      // Verify OTP with the backend server
      Response response = await dio.post(
        '$baseUrl/api/v1/accounts/signup/otpverification/',
        data: {
          "email": email,
          "otp": otp,
        },
      );

      if (response.statusCode == 200) {
        // OTP verification successful
        return true;
      } else {
        // OTP verification failed
        return false;
      }
    } catch (e) {
      print('Error verifying OTP: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>?> loginUser(String email, String password) async {
    try {
      // Make POST request to login
      Response response =
          await dio.post('$baseUrl/api/v1/accounts/login/', data: {
        "email": email,
        "password": password,
      });

      // Check response status
      if (response.statusCode == 200) {
        var auth = Hive.box('auth');
        auth.put("token", response.data["access_token"]);
        // Login successful, save user id to SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        int userId = response.data['id'];
        String email = response.data['email'];
        String name = response.data['name'];
        String surname = response.data['surname'];
        String region = response.data['region'];
        String phoneNumber = response.data['phone_number'];
        String birth = response.data['birth'];
        prefs.setString('email', email);
        prefs.setString('name', name);
        prefs.setString('surname', surname);
        prefs.setString('region', region);
        prefs.setString('phone_number', phoneNumber);
        prefs.setString('birth', birth);
        prefs.setInt('id', userId);
        print("Data: ${response.data}");
        // Return user data and user ID
        return {
          'userData': response.data,
          'id': userId,
          'email': email,
          'name': name,
          'surname': surname,
          'region': region,
          'phone_number': phoneNumber,
          'birth': birth,
        };
      } else {
        // Login failed, return null
        return null;
      }
    } catch (e) {
      // Handle any errors that occurred during the process
      print('Error: $e');
      return null;
    }
  }

  Future<bool> sendEmail(
    String email,
  ) async {
    try {
      // Prepare your login data
      Map<String, dynamic> loginData = {
        "email": email,
      };

      // Make POST request to login
      Response response = await dio
          .post('$baseUrl/api/v1/accounts/resetpass/sendotp/', data: loginData);

      // Check response status
      if (response.statusCode == 200) {
        // Login successful, handle response
        print('Send successful: ${response.data}');
        return true;
      } else {
        // Login failed, handle error
        print('Send failed: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      // Handle any errors that occurred during the process
      print('Error: $e');
      return false;
    }
  }

  Future<bool> resetEmailOTP(String email, String otp) async {
    try {
      // Verify OTP with the backend server
      Response response = await dio.post(
        '$baseUrl/api/v1/accounts/resetpass/otpverification/',
        data: {
          "email": email,
          "otp": otp,
        },
      );

      if (response.statusCode == 200) {
        // OTP verification successful
        return true;
      } else {
        // OTP verification failed
        return false;
      }
    } catch (e) {
      print('Error verifying OTP: $e');
      return false;
    }
  }

  Future<bool> newPassword(String email, String password) async {
    try {
      // Verify OTP with the backend server
      Response response = await dio.post(
        '$baseUrl/api/v1/accounts/setnewpass/',
        data: {
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        // OTP verification successful
        return true;
      } else {
        // OTP verification failed
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error verifying OTP: $e');
      }
      return false;
    }
  }

  Future<DtmTestCode?> dtmTestCollection(String dtmTestcode) async {
    try {
      Response response =
          await dio.get('$baseUrl/api/v1/dtmtests/tests/$dtmTestcode/');

      // Check response status
      if (response.statusCode == 200) {
        return DtmTestCode.fromJson(response.data);
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Handle any errors that occurred during the process
      print('Error: $e');
      return null;
    }
  }

  resultTestDtm(int studentId, String testCode, double point, String date) {}
}
