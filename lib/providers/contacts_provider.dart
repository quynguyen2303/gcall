import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

import '../config/Constants.dart';

import '../models/contact.dart';

class Contacts extends ChangeNotifier {
  final String _token;
  List<Contact> _contacts = [];
  Contact _contact;
  bool _isSetInterceptor = false;

  Contacts(this._token);

  var dio = Dio();
  final String url = kUrl + 'contacts';

  Contact get contactInfo {
    return _contact;
  }

  List<Contact> get contacts {
    return _contacts;
  }

  void setUpDioWithHeader() {
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      options.headers['x-sessiontoken'] = _token;
    }));
    _isSetInterceptor = true;
  }

  Future<void> searchContacts(String query) async {
    print('Searching...');
    final String searchUrl = kUrl + 'contacts/search';
    try {
      Response response = await dio.get(searchUrl, queryParameters: {
        'q': query,
      });

      if (_contacts.isNotEmpty) {
        _contacts.clear();
      }

      response.data['result'].forEach(
        (e) {
          final String id = e['_id'];
          final String firstName = e['firstName'];
          final String lastName = e['lastName'];
          final String phone = e['phone'];

          final newContact = Contact(
              id: id, firstName: firstName, lastName: lastName, phone: phone);
          _contacts.add(newContact);
        },
      );
      notifyListeners();
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print('error data:');
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print('error without data:');
        print(e.request);
        print(e.message);
      }
      throw (e);
    }
  }

  Future<void> fetchAndSetUpContacts(int pageNumber) async {
    print('Fetching...');
    if (!_isSetInterceptor) {
      setUpDioWithHeader();
    }

    try {
      Response response = await dio.get(
        url,
        queryParameters: {
          'page': pageNumber,
          'limit': 30,
        },
      );

      response.data['result'].forEach(
        (e) {
          final String id = e['_id'];
          final String firstName = e['firstName'];
          final String lastName = e['lastName'];
          final String phone = e['phone'];

          final newContact = Contact(
              id: id, firstName: firstName, lastName: lastName, phone: phone);
          _contacts.add(newContact);
        },
      );
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print('error data:');
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print('error without data:');
        print(e.request);
        print(e.message);
      }
      throw (e);
    }

    notifyListeners();
  }

  Future<void> createContact(String firstName, String lastName, String gender,
      String phone, String email) async {
    if (!_isSetInterceptor) {
      setUpDioWithHeader();
    }
    const String createContactUrl = kUrl + 'contact';

    try {
      Response response = await dio.post(
        createContactUrl,
        data: {
          "firstName": firstName,
          "lastName": lastName,
          "gender": gender,
          "email": email,
          "phone": phone,
          "avatar": '',
        },
      );

      print(response.data['success']);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print('error data:');
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print('error without data:');
        print(e.request);
        print(e.message);
      }
      throw (e);
    }
  }

  Future<void> getOneContact(String contactId) async {
    print('Getting contact info');

    final String getOneContactUrl = kUrl + 'contact/$contactId';

    try {
      Response response = await dio.get(getOneContactUrl);
      _contact = Contact(
        id: response.data['result']['_id'],
        firstName: response.data['result']['firstName'],
        lastName: response.data['result']['lastName'],
        phone: response.data['result']['phone'],
        email: response.data['result']['email'],
        gender: response.data['result']['gender'],
      );

      print('API finished');
      print(response.data['result']);
      print(_contact.toString());
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print('error data:');
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print('error without data:');
        print(e.request);
        print(e.message);
      }
      throw (e);
    }
  }

  void clearContacts() {
    print('Clearing...');
    _contacts.clear();
  }
}
