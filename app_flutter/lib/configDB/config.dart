import 'package:flutter_dotenv/flutter_dotenv.dart';

final URL = dotenv.env['HOST_NAME_DEPLOY'];
final PORT = dotenv.env['PORT'];

final IPCONFIG_image = "${URL}/upload/";

final configRegister = '${URL}/api/signup';
final configLogin = '${URL}/api/signin';

final configGetAllproduct = '${URL}/api/product';
final configGetAllCategory = '${URL}/api/category';


// const IPCONFIG = "192.168.84.94";

// const IPCONFIG_image = "http://${IPCONFIG}:3000/upload/";

// const configRegister = 'http://${IPCONFIG}:3000/api/signup';
// const configLogin = 'http://${IPCONFIG}:3000/api/signin';

// const configGetAllproduct = 'http://${IPCONFIG}:3000/api/product';
// const configGetAllCategory = 'http://${IPCONFIG}:3000/api/category';
