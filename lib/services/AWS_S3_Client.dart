import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:amazon_cognito_identity_dart/sig_v4.dart';

class AWSClient {
  String accessKeyId =
      "AKIAUDYE7GGYTJCBTRH7"; // replace with your own access key
  String secretKeyId =
      "p+GQM6DGDBJy/STMOPR4gS0qqTojT0R9BZaG4h5x"; // replace with your own secret key
  String region = 'ap-south-1'; // replace with your account's region name
  String bucketname =
      "amplify-awsamp-dev-01624-deployment"; // replace with your S3's bucket name
  String s3Endpoint =
      'https://amplify-awsamp-dev-01624-deployment.s3-ap-south-1.amazonaws.com'; // update the endpoint url for your bucket

  dynamic uploadData(String folderName, String fileName, Uint8List data) async {
    final length = data.length;
    print(11);

    final uri = Uri.parse(s3Endpoint);
    final req = http.MultipartRequest("POST", uri);
    final multipartFile = http.MultipartFile(
        'file', http.ByteStream.fromBytes(data), length,
        filename: fileName);

    final policy = Policy.fromS3PresignedPost(
        folderName + '/' + fileName, bucketname, accessKeyId, 15, length,
        region: region);
    final key =
        SigV4.calculateSigningKey(secretKeyId, policy.datetime, region, 's3');
    final signature = SigV4.calculateSignature(key, policy.encode());

    req.files.add(multipartFile);
    req.fields['key'] = policy.key;
    req.fields['acl'] = 'public-read';
    req.fields['X-Amz-Credential'] = policy.credential;
    req.fields['X-Amz-Algorithm'] = 'AWS4-HMAC-SHA256';
    req.fields['X-Amz-Date'] = policy.datetime;
    req.fields['Policy'] = policy.encode();
    req.fields['X-Amz-Signature'] = signature;
    print(22);

    try {
      final res = await req.send();
      //var ress = json.decode(res.toString());

      print('response -> ' + res.toString());

      await for (var value in res.stream.transform(utf8.decoder)) {
        print("repo-> " + value.toString());

        return value;
      }
    } catch (e) {
      print('##-> ' + e.toString());

      return e;
    }
  }
}

class Policy {
  String expiration;
  String region;
  String bucket;
  String key;
  String credential;
  String datetime;
  int maxFileSize;

  Policy(this.key, this.bucket, this.datetime, this.expiration, this.credential,
      this.maxFileSize,
      {this.region = 'us-east-1'});

  factory Policy.fromS3PresignedPost(
    String key,
    String bucket,
    String accessKeyId,
    int expiryMinutes,
    int maxFileSize, {
    String region,
  }) {
    final datetime = SigV4.generateDatetime();
    final expiration = (DateTime.now())
        .add(Duration(minutes: expiryMinutes))
        .toUtc()
        .toString()
        .split(' ')
        .join('T');
    final cred =
        '$accessKeyId/${SigV4.buildCredentialScope(datetime, region, 's3')}';
    final p = Policy(key, bucket, datetime, expiration, cred, maxFileSize,
        region: region);
    return p;
  }

  String encode() {
    final bytes = utf8.encode(toString());
    return base64.encode(bytes);
  }

  @override
  String toString() {
    return '''
{ "expiration": "${this.expiration}",
  "conditions": [
    {"bucket": "${this.bucket}"},
    ["starts-with", "\$key", "${this.key}"],
    {"acl": "public-read"},
    ["content-length-range", 1, ${this.maxFileSize}],
    {"x-amz-credential": "${this.credential}"},
    {"x-amz-algorithm": "AWS4-HMAC-SHA256"},
    {"x-amz-date": "${this.datetime}" }
  ]
}
''';
  }
}
