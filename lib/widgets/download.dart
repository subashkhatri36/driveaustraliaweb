import 'package:dktweb/widgets/dkt_button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DownloadFileWidget extends StatelessWidget {
  const DownloadFileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Download Mobile App',textAlign: TextAlign.end,style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold,),),
        DktButton(onPressed: ()async{
          if (!await launchUrl(Uri.parse('https://play.google.com/store/apps/details?id=com.subashkhatri.dktweb'))) {
            throw Exception('Could not launch');
          }
        },
            text: 'Download')
      ],);
  }
}
