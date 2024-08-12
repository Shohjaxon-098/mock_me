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

        int? studentId = response.data['id'];
        if (studentId != null) {
          auth.put('student_id', studentId);
          print("Student ID saved in Hive: $studentId");
        } else {
          print("Student ID is null in response");
        }

        String? idUser = response.data['id'].toString();
        auth.put('user_id', idUser);
        print("User ID saved in Hive: $idUser");

        String? firstName = response.data['name'].toString();
        auth.put('name', firstName);
        print("User\'s name has been saved in Hive: $firstName");

        String? lastName = response.data['surname'].toString();
        auth.put('surname', lastName);
        print("User\'s lastName has been saved in Hive");


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

        int? studentId = response.data['id'];
        if (studentId != null) {
          auth.put('student_id', studentId);
          print("Student ID saved in Hive: $studentId");
        } else {
          print("Student ID is null in response");
          return null;
        }

        String? idUser = response.data['id'].toString(); // Convert to String
        auth.put('user_id', idUser);
        print("User ID saved in Hive: $idUser");

        String? firstName = response.data['name'].toString();
        auth.put('name', firstName);
        print("User\'s name has been saved in Hive: $firstName");

        String? lastName = response.data['surname'].toString();
        auth.put('surname', lastName);
        print("User\'s lastName has been saved in Hive");


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




  Future<bool> resultId(String id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Check if the result ID is cached
      String? cachedId = prefs.getString('resultId');
      if (cachedId == id) {
        // If cached ID matches the requested ID, return true
        return true;
      }

      // Make API request to fetch the result
      Response response = await dio.get(
        '$baseUrl/api/v1/dtmtests/result/$id',
      );

      if (response.statusCode == 200) {
        // If API request is successful, cache the ID
        await prefs.setString('resultId', id);
        return true;
      } else {
        // If API request fails
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching result ID: $e');
      }
      return false;
    }
  }  Future<Map<String, dynamic>> fetchUserData(int userId) async {
    Dio dio = Dio();
    try {
      final response =
          await dio.get('$baseUrl/api/v1/accounts/update/${userId}/');
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(
            'Failed to load data with status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
        throw Exception(
            'Failed to load data with status code: ${e.response?.statusCode}. Data: ${e.response?.data}');
      } else {
        print('Error sending request!');
        print(e.message);
        throw Exception('Error sending request: ${e.message}');
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }



  Future<Map<String, dynamic>?> resultOfTest(int studentId, String testCode, double point, String date) async {
    try {
      // Make POST request to API
      Response response = await dio.post(
        '$baseUrl/api/v1/dtmtests/result/',
        data: {
          "student_id": studentId,
          "test_code": testCode,
          "point": point,
          "date": date,
        },


      );

      if (response.statusCode == 201) {
        print("Data: ${response.data}");
        // Return data from Result
        return {
          'student_id': studentId,
          'test_code': testCode,
          'point': point,
          'date': date,
        };
      } else {
        print('Error: ${response.statusCode} - ${response.data}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }



}


