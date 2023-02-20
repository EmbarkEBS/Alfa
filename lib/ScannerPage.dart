
import 'dart:convert';
import 'dart:io';

import 'package:churchIn/utils/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'helpers/encrypter.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage() ;

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {

  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String errortxt="";
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }


  @override
  Widget build(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 280.0
        : 300.0;
    return Material(
        child: Container(
          color: Colors.grey.withOpacity(0.5),
          child: Stack(
            children: [
              //SizedBox(height: 100,),

              /* Expanded(
                flex: 5,
                child: _buildQrView(context),
            ),*/
              QRView(

                //flex: 5,
                // child: _buildQrView(context),
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                    borderColor: Colors.blue,
                    borderRadius: 10,
                    borderLength: 40,
                    borderWidth: 7,
                    cutOutSize: scanArea),
                onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
              ),
              Column(

                children:[
                  Container(
                    //  color: Colors.grey.withOpacity(0.5),
                    padding: EdgeInsets.fromLTRB(10, 50, 0, 10),
                    //margin: EdgeInsets.fromLTRB(0, 0, 5,5),
                    child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //FlutterLogo(size: 100,),
                          SvgPicture.asset(
                            "assets/images/newlogo.svg",
                            width: 70,
                            height: 70,
                          ),
                        ]
                    ),
                  ),
                  Center(
                      child:Container(
                        padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                        child:(errortxt!="")?Text(errortxt,
                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 25),
                        ):Text("Place the QRCODE of your mobile \n"
                            "        camera on the blue box",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      )
                  )

                ],
                /*Container(

              // margin: EdgeInsets.fromLTRB(0, 0, 5,5),
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //FlutterLogo(size: 100,),
                    SvgPicture.asset(
                      "assets/images/logo.svg",
                      width: 50,
                      height: 50,
                    ),]
              ),
            ) ,*/
              ),
              /*Expanded(
              flex: 1,
              child: Center(
                child: (result != null)
                    ? Text(
                    'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                    : Text('Scan a code'),
              ),
            )*/
            ],
          ),
        )
    );
  }
  /*Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 280.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.deepPurple.shade900,
          borderRadius: 10,
          borderLength: 40,
          borderWidth: 7,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }*/

  void _onQRViewCreated(QRViewController controller) {
    //setState(() {
    this.controller = controller;
    // });
    controller.scannedDataStream.listen((scanData) async {
      this.controller
      !.pauseCamera();
      this.controller!.resumeCamera();
      setState(() {
      this.result = scanData;
      });
      if(scanData!=null){
      String? value =scanData!.code;
      List<String> txt=value!.split("_");//print(value.toString()+" gggggg");
      if(txt.length>1 && txt[0].toLowerCase()=="alpha"){
      final Map<String,dynamic> result = {
      "value":value!};
      //   Map<String,dynamic> result=json.decode(decryption(response.body));
      //if(result.containsKey("id") && result.containsKey("status") && result["status"]=="active" ){
      Navigator.pushNamed(context, "/menu",arguments: result);
      // no }

      }else{
      setState((){
      errortxt="Scan a valid QR";
      });
      }
      }
      this.controller!.resumeCamera();
      // controller?.dispose();

      });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    // log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}