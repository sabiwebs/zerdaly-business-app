import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class Business {
  final url = 'https://api.zerdaly.com/api/business/';

  Future<List> login(String email, String pass) async {
    List response = new List(3);
    await http.post(url + 'login', body: {
      'json': json.encode({
        'email': email,
        'password': pass,
      }).toString(),
    }).then((res) {
      final result = json.decode(res.body);
      response[0] = result['code'];
      response[1] = result['status'];
      response[2] = result['token'];
    });
    return response;
  }

  Future<List> register(var data) async {
    List response = new List(5);

    await http
        .post(url + "register", body: {'json': json.encode(data)}).then((res) {
      final data = json.decode(res.body);
      response[0] = data["code"];
      response[1] = data["status"];
      response[2] = data["errors"];
      response[3] = data["message"];
      response[4] = data["token"];
    }).catchError((error) {});
    return response;
  }

  Future<List> update(var data, String token) async {
    List response = new List(3);

    await http.put(url + "update", body: {
      'json': data,
    }, headers: {
      HttpHeaders.authorizationHeader: token
    }).then((res) {
      final result = json.decode(res.body);

      response[0] = result["code"];
      response[1] = result["status"];
      response[2] = result["message"];
    }).then((error) {});

    return response;
  }

    Future<List> uploadBusinessImage(String img, String token) async {
    List response = new List(3);
    await http.post(url + "upload", body: {
      'json': json.encode({
        'image': img,
      })
    }, headers: {
      HttpHeaders.authorizationHeader: token
    }).then((res) {
      final result = json.decode(res.body);
      response[0] = result["code"];
      response[1] = result["status"];
      response[2] = result["image"];
    }).then((error) {});

    return response;
  }

  Future<List> info(String token) async {
    List response = new List(6);
    await http.post(url + "info",
        headers: {HttpHeaders.authorizationHeader: token}).then((res) {
      final result = json.decode(res.body);
      response[0] = result["code"];
      response[1] = result["business"];
      response[2] = result["business_sales"];
      response[3] = result["business_orders"];
      response[4] = result["business_products"];
      response[5] = result["business_likes"];
    }).catchError((error) {});

    return response;
  }

  Future<bool> newBank(String bankName, String bankType, String bankNumber,
      String bankHolder, String token) async {
    bool status = false;
    await http.post(url + "new/bank", body: {
      'json': json.encode({
        'bank_name': bankName,
        'account_type': bankType,
        'account_holder': bankHolder,
        'account_number': bankNumber,
      }),
    }, headers: {
      HttpHeaders.authorizationHeader: token
    }).then((res) {
      if (res.statusCode == 200) {
        status = true;
      }
    }).catchError((error) {});

    return status;
  }

  Future<List> newSubscription(String cardNumber, String cardMonth,
      String cardYear, String cardCVV, String token) async {
    List response = new List(4);

    await http.post(url + "new/subscription", body: {
      'json': json.encode({
        'card_number': cardNumber,
        'exp_month': cardMonth,
        'exp_year': cardYear,
        'cvc': cardCVV,
      })
    }, headers: {
      HttpHeaders.authorizationHeader: token
    }).then((res) {
      final result = json.decode(res.body);

      response[0] = result["code"];
      response[1] = result["status"];
      response[2] = result["message"];
      response[3] = result["subscription"];
    }).catchError((error) {});

    return response;
  }

  Future<List> getSubsctiption(String token) async {
    List response = new List(3);
    await http.post(url + "get/subscription",
        headers: {HttpHeaders.authorizationHeader: token}).then((res) {
      final result = json.decode(res.body);
      response[0] = result["code"];
      response[1] = result["status"];
      response[2] = result["message"];
    }).then((error) {});

    return response;
  }

  Future<List> cancelSubsctiption(String token) async {
    List response = new List(3);
    await http.post(url + "cancel/subscription",
        headers: {HttpHeaders.authorizationHeader: token}).then((res) {
      
      final result = json.decode(res.body);
      response[0] = result["code"];
      response[1] = result["status"];
      response[2] = result["message"];
    }).then((error) {});

    return response;
  }

  Future<List> renewSubsctiption(String token) async {
    List response = new List(3);
    await http.put(url + "renew/subscription",
        headers: {HttpHeaders.authorizationHeader: token}).then((res) {

      final result = json.decode(res.body);
      response[0] = result["code"];
      response[1] = result["status"];
      response[2] = result["message"];
    }).then((error) {});

    return response;
  }

  Future<List> newProduct(String name, String price, String on_stock,
      String description, String image, String token) async {
    List response = new List(3);

    await http.post(url + "new/product", body: {
      'json': json.encode({
        'name': name,
        'price': price,
        'on_stock': on_stock,
        'description': description,
        'image': image,
        'active': 1,
      })
    }, headers: {
      HttpHeaders.authorizationHeader: token
    }).then((res) {
      final result = json.decode(res.body);
      response[0] = result["code"];
      response[1] = result["status"];
      response[2] = result["message"];
    });

    return response;
  }

  Future<List> editProduct(int id, String name, String price, String on_stock,
      String description, String image, String status, String token) async {
    List response = new List(3);

    await http.put(url + "update/product", body: {
      'json': json.encode({
        'id': id,
        'name': name,
        'price': price,
        'on_stock': on_stock,
        'description': description,
        'image': image,
        'active': status,
      })
    }, headers: {
      HttpHeaders.authorizationHeader: token
    }).then((res) {
      final result = json.decode(res.body);
      response[0] = result["code"];
      response[1] = result["status"];
      response[2] = result["message"];
    });

    return response;
  }

  Future<List> uploadProductImage(String img, String token) async {
    List response = new List(3);
    await http.post(url + "upload/product", body: {
      'json': json.encode({
        'image': img,
      })
    }, headers: {
      HttpHeaders.authorizationHeader: token
    }).then((res) {
      final result = json.decode(res.body);
      response[0] = result["code"];
      response[1] = result["status"];
      response[2] = result["image"];
    }).then((error) {});

    return response;
  }

  Future<List> getUser(int id, String token) async {
    List response = new List(3);
    await http.post("https://api.zerdaly.com/api/user/getuser", body: {
      'json': json.encode({
        'id': id,
      })
    }, headers: {
      HttpHeaders.authorizationHeader: token
    }).then((res) {
      final result = json.decode(res.body);
      response[0] = result["code"];
      response[1] = result["status"];
      response[2] = result["message"];
    }).then((error) {});

    return response;
  }

    Future<List> getUserLocation(int id, String token) async {
    List response = new List(3);
    await http.post("https://api.zerdaly.com/api/user/getlocation", body: {
      'json': json.encode({
        'id': id,
      })
    }, headers: {
      HttpHeaders.authorizationHeader: token
    }).then((res) {
      final result = json.decode(res.body);
      response[0] = result["code"];
      response[1] = result["status"];
      response[2] = result["message"];
    }).then((error) {});

    return response;
  }

  Future<List> getDelivery(int id, String token) async {
    List response = new List(3);
    await http.post("https://api.zerdaly.com/api/delivery/getdelivery", body: {
      'json': json.encode({
        'id': id,
      })
    }, headers: {
      HttpHeaders.authorizationHeader: token
    }).then((res) {
      final result = json.decode(res.body);
      response[0] = result["code"];
      response[1] = result["status"];
      response[2] = result["message"];
    }).then((error) {});

    return response;
  }

  Future<List> getDeliveriesAvailible(String token) async {
    List response = new List(3);
    await http.post(url + "get/deliveries/availible",
        headers: {HttpHeaders.authorizationHeader: token}).then((res) {
      final result = json.decode(res.body);
      response[0] = result["code"];
      response[1] = result["status"];
      response[2] = result["deliveries"];
    }).then((error) {});

    return response;
  }

  Future<List> contactDeliveryAvailible(
      int deliveryId, int orderId, String token) async {
    List response = new List(3);
    await http.post(url + "contact/delivery", body: {
      'json': json.encode({
        'delivery_id': deliveryId,
        'order_id': orderId,
      })
    }, headers: {
      HttpHeaders.authorizationHeader: token
    }).then((res) {
      final result = json.decode(res.body);
      response[0] = result["code"];
      response[1] = result["status"];
      response[2] = result["message"];
    }).then((error) {});

    return response;
  }

  Future<List> shippingSent(int id, String token) async {
    List response = new List(3);
    await http.post(url + "shipping/sent", body: {
      'json': json.encode({
        'order_id': id,
      })
    }, headers: {
      HttpHeaders.authorizationHeader: token
    }).then((res) {
      final result = json.decode(res.body);
      response[0] = result["code"];
      response[1] = result["status"];
      response[2] = result["message"];
    }).then((error) {});

    return response;
  }
}
