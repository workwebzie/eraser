
import 'package:http/http.dart' as http;

class Api{

 static const  APIKEY = "LH7oaH3BXPfzbebZcsXTDnX7";


 static  var  BASEURL = Uri.parse("https://api.remove.bg/v1.0/removebg");

 static removeBg(String imagePath)async{
  var request = http.MultipartRequest("POST",BASEURL);

  request.headers.addAll({"X-API-Key":APIKEY});

  request.files.add(await http.MultipartFile.fromPath("image_file", imagePath) );


  final res= await request.send();
  print(res.statusCode);

  if(res.statusCode==200){
     

    http.Response image= await http.Response.fromStream(res);
    return image.bodyBytes;

  }else{
    print("error");
  }

 }
}