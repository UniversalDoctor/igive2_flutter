import 'package:flutter/material.dart';

class TermsConditions extends StatelessWidget {
  
  final Color color;

  const TermsConditions({this.color});

  @override
  Widget build(BuildContext context) {

    _styles(double size, String fontFamily){
      return TextStyle(
        fontFamily: fontFamily,
        fontSize: size, 
        color: color != null ?
          color
          :
          Colors.black
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          "Last updated February 20, 2020",
          textAlign: TextAlign.left,
          style: _styles(12, 'Monserrat'),
        ),
        SizedBox(height: 10.0,),
        Text(
          "Agreement to the Terms and Conditions",
          textAlign: TextAlign.justify,
          style: _styles(16, 'MontserratSemiBold'),
        ),
        SizedBox(height: 10.0,),
        Text(
          "This Terms of Use Agreement and our Privacy Statement (together, these “Terms“) describe the terms and conditions on which Universal Projects and Tools S.L. and/or iBreve Ltd (collectively, “Our Company”) offers you access to the websites, applications and digital services on or to which these Terms are linked or referenced (collectively, the “Services“). Before accessing and using the Services, please read these Terms carefully.",
          textAlign: TextAlign.justify,
          style: _styles(14, 'Montserrat'),
        ),

        SizedBox(height: 40.0,),
        Text(
          "Scope of iGive2 Services",
          textAlign: TextAlign.justify,
          style: _styles(16, 'MontserratSemiBold'),
        ),
        SizedBox(height: 10.0,),
        Text(
          "The iGive2 project was created in 2019 and is a collaboration by Universal Projects and Tools S.L. & iBreve Ltd. The objective of this project is to build a platform that helps researchers and citizens to better manage & prevent chronic diseases. iGive2 Services include, but are not limited to:",
          textAlign: TextAlign.justify,
          style: _styles(14, 'Montserrat'),
        ),
        SizedBox(height: 10.0,),
        Text(
          "> Providing guided meditation exercises\n> Providing physical activity exercise\n> Providing health living tips\n> Providing the possibility to create groups & set activity challenges\n> Providing the possibility to participate in Research projects",
          textAlign: TextAlign.justify,
          style: _styles(14, 'Montserrat'),
        ),

        SizedBox(height: 40.0,),
        Text(
          "Personal Data",
          textAlign: TextAlign.justify,
          style: _styles(16, 'MontserratSemiBold'),
        ),
        SizedBox(height: 10.0,),
        Text(
          "Universal Projects and Tools S.L.(C/ Luis Antúnez 6, 08006 Barcelona, Spain) and iBreve Ltd (Ground Floor, 8-9 Marino Mart, Fairview Dublin 3, Ireland) are the data controller.Users’ data may, subject to their explicit consent in this regard and in accordance with the General Terms and Conditions of Use, be used as follows:",
          textAlign: TextAlign.justify,
          style: _styles(14, 'Montserrat'),
        ),
        SizedBox(height: 10.0,),
        Text(
          "> To benefit from the iGive2 Services that interest them and for which they wish to register\n> To create personal community groups\n> To participate in research groups",
          textAlign: TextAlign.justify,
          style: _styles(14, 'Montserrat'),
        ),

        SizedBox(height: 10.0,),
        Text(
          "Users’ data may also be processed to allow them to receive corporate or promotional information from iGive2, on topics of interest to them, on the basis of voluntary, active and specific consent on their part. For example, they may receive information on studies and surveys to enable them to participate if they so wish and/or to be put in contact with the organizations responsible for carrying out such studies and/or surveys.",
          textAlign: TextAlign.justify,
          style: _styles(14, 'Montserrat'),
        ),
        SizedBox(height: 10.0,),
        Text(
          "Users may withdraw their consent at any time without providing a reason. In this case, they acknowledge that they will no longer be able to benefit from the services available from iGive2 and/or receive corporate and promotional information. The withdrawal of Users’ consent shall not affect the lawfulness of the processing carried out prior to the withdrawal of such consent.",
          textAlign: TextAlign.justify,
          style: _styles(14, 'Montserrat'),
        ),
        SizedBox(height: 10.0,),
        Text(
          "iGive2 may also produce statistics within the context of its activities and Services which it implements after aggregating data from Users so they can no longer be identified and to ensure their anonymity.",
          textAlign: TextAlign.justify,
          style: _styles(14, 'Montserrat'),
        ),
        SizedBox(height: 10.0,),
        Text(
          "The personal data of Users are strictly intended for iGive2 and may only be used by Members authorized specifically for this purpose, as and when using the Services.",
          textAlign: TextAlign.justify,
          style: _styles(14, 'Montserrat'),
        ),
        SizedBox(height: 10.0,),
        Text(
          "As such, Users are expressly informed that it is recommended to choose a username/pseudonym associated with a non-identifying photo as an “avatar”, rather than their real identity, in order to protect their privacy within the community. Users thus assess, at their own risk, whether to appear on iGive2 and to participate in the various Services offered in a way that identifies them, or alternatively to choose information that allows them to preserve their anonymity. Any User not wishing to be identified on iGive2 is informed and accepts that the risk of identification by other Users registered in the same community as him or her, exists, depending on the nature and accuracy of the information that he or she consents to share within the community.",
          textAlign: TextAlign.justify,
          style: _styles(14, 'Montserrat'),
        ),
        SizedBox(height: 10.0,),
        Text(
          "Where applicable, the User's data may be used for health studies and health evaluations, subject to his or her specific objection to each study brought previously to his or her attention. Our Company guarantees that the personal data of Users will not be sent to any unauthorized third party.",
          textAlign: TextAlign.justify,
          style: _styles(14, 'Montserrat'),
        ),
        SizedBox(height: 10.0,),
        Text(
          "Before your data is shared with research parties it will be pseudo anonymised according to GDPR laws. iGive2 is not responsible for the use third parties does from the data. Users anonymity is protected thanks to iGive2 to data treatment but we can not control bad uses of data once third parties have it.",
          textAlign: TextAlign.justify,
          style: _styles(14, 'Montserrat'),
        ),
        SizedBox(height: 10.0,),
        Text(
          "Users' data regarding the use of the Services offered via iGive2 are kept for the duration necessary for the use of these services. If our Company detects inactivity in a User's personal account for 2 years, Our Company will send a message to the User informing them of the closure of their account and the deletion of this personal data from our database.",
          textAlign: TextAlign.justify,
          style: _styles(14, 'Montserrat'),
        ),
        SizedBox(height: 10.0,),
        Text(
          "In accordance with the aforementioned Regulations, Users are entitled to the following: ",
          textAlign: TextAlign.justify,
          style: _styles(14, 'Montserrat'),
        ),
        SizedBox(height: 10.0,),
        RichText(
          textAlign: TextAlign.justify,
          text: TextSpan(
            text: 'The right to access',
            style: _styles(14, 'MontserratBold'),
            children: <TextSpan>[
              TextSpan(
                text: ' - You have the right to request Our Company for copies of your personal data.',
                style: _styles(14, 'Montserrat'),
              ),
            ]
          ),
        ),
        SizedBox(height: 10.0,),
        RichText(
          textAlign: TextAlign.justify,
          text: TextSpan(
            text: 'The right to rectification',
            style: _styles(14, 'MontserratBold'),
            children: <TextSpan>[
              TextSpan(
                text: ' - You have the right to request that Our Company correct any information you believe is inaccurate. You also have the right to request Our Company to complete information you believe is incomplete.',
                style: _styles(14, 'Montserrat'),
              ),
            ]
          ),
        ),
        SizedBox(height: 10.0,),
        RichText(
          textAlign: TextAlign.justify,
          text: TextSpan(
            text: 'The right to erasure',
            style: _styles(14, 'MontserratBold'),
            children: <TextSpan>[
              TextSpan(
                text: ' - You have the right to request that Our Company erase your personal data.',
                style: _styles(14, 'Montserrat'),
              ),
            ]
          ),
        ),
        SizedBox(height: 10.0,),
        RichText(
          textAlign: TextAlign.justify,
          text: TextSpan(
            text: 'The right to restrict processing',
            style: _styles(14, 'MontserratBold'),
            children: <TextSpan>[
              TextSpan(
                text: ' - You have the right to request that Our Company restrict the processing of your personal data.',
                style: _styles(14, 'Montserrat'),
              ),
            ]
          ),
        ),
        SizedBox(height: 10.0,),
        RichText(
          textAlign: TextAlign.justify,
          text: TextSpan(
            text: 'The right to object to processing',
            style: _styles(14, 'MontserratBold'),
            children: <TextSpan>[
              TextSpan(
                text: "- You have the right to object to Our Company's processing of your personal data.",
                style: _styles(14, 'Montserrat'),
              ),
            ]
          ),
        ),
        SizedBox(height: 10.0,),
        RichText(
          textAlign: TextAlign.justify,
          text: TextSpan(
            text: 'The right to data portability',
            style: _styles(14, 'MontserratBold'),
            children: <TextSpan>[
              TextSpan(
                text: " - You have the right to request that Our Company transfer the data that we have collected to another organization, or directly to you.",
                style: _styles(14, 'Montserrat'),
              ),
            ]
          ),
        ),
        SizedBox(height: 40.0,),
        Text(
          "iGive2 content is not medical or professional advice",
          textAlign: TextAlign.justify,
          style: _styles(16, 'MontserratSemibold'),
        ),
        SizedBox(height: 10.0,),
        Text(
          "If you make a request, we have one month to respond to you. If you would like to exercise any of these rights, please contact us at our email: info@ibreve.com",
          textAlign: TextAlign.justify,
          style: _styles(14, 'Montserrat'),
        ),
        SizedBox(height: 10.0,),
        Text(
          "iGive2 has not been approved by the european medicines agency nor by any certified body. This means that iGive2 has not proven yet as an effective treatment for any disease and is not considered a medical device.",
          textAlign: TextAlign.justify,
          style: _styles(14, 'Montserrat'),
        ),
        SizedBox(height: 10.0,),
        Text(
          "Thus iGive2 content, including all health-related information, is for informational purposes only. Please confirm all iGive2 content with other sources and with your physician and professional health care providers (HCP). It is not intended as a substitute for, nor does it replace, professional medical advice, diagnosis or treatment.",
          textAlign: TextAlign.justify,
          style: _styles(14, 'Montserrat'),
        ),
        SizedBox(height: 10.0,),
        Text(
          "The iGive2 App is intended as a CDS software tool for use by Health Care Providers and/or researchers (Users). It is not intended to definitively diagnose or direct the treatment of medical condition or disease, and it is not intended to be used as the sole or primary basis for a clinical patient diagnosis.",
          textAlign: TextAlign.justify,
          style: _styles(14, 'Montserrat'),
        ),
        SizedBox(height: 10.0,),
        Text(
          "The contents of the iGive2 App (the “Content”) including, without limitation, text, graphics, images, and information provided by the iGive2 App, are for informational purposes only. The Content is not intended to be a substitute for professional medical advice, diagnosis, and treatment.  iGive2 does not recommend or endorse any specific product, services, or HCPs.",
          textAlign: TextAlign.justify,
          style: _styles(14, 'Montserrat'),
        ),
        SizedBox(height: 10.0,),
        Text(
          "Individuals should always seek the advice of a physician or other qualified HCP with any questions they may have regarding medical conditions or symptoms. Individuals should never disregard professional medical advice or delay in seeking it because of something they may have heard or read about the iGive2 App. Reliance on any information provided by the iGive2 App including, without limitation, information provided by iGive2, iGive2 employees, or other representatives of iGive2 appearing on the App, is solely at any user’s own risk. If an individual believes they may have a medical emergency, he or she should call their physician or emergency number immediately.",
          textAlign: TextAlign.justify,
          style: _styles(14, 'Montserrat'),
        ),
        SizedBox(height: 40.0,),
        Text(
          "Notice Regarding Children’s Online Privacy Protection Act (COPPA)",
          textAlign: TextAlign.justify,
          style: _styles(16, 'MontserratSemiBold'),
        ),
        SizedBox(height: 10.0,),
        Text(
          "The iGive2 App is not directed to or intended for use by individuals including, without limitation, persons younger than 18 years old.",
          textAlign: TextAlign.justify,
          style: _styles(14, 'Montserrat'),
        ),
        SizedBox(height: 40.0,),
        Text(
          "Geographic Use Restriction",
          textAlign: TextAlign.justify,
          style: _styles(16, 'MontserratSemiBold'),
        ),
        SizedBox(height: 10.0,),
        Text(
          "Following GDPR rules all data from iGive2 users will be stored in secure servers between the European Union.",
          textAlign: TextAlign.justify,
          style: _styles(14, 'Montserrat'),
        ),
        SizedBox(height: 40.0,),
        Text(
          "Using the iGive2 App",
          textAlign: TextAlign.justify,
          style: _styles(16, 'MontserratSemiBold'),
        ),
        SizedBox(height: 10.0,),
        Text(
          "When using the iGive2 App, a Users must follow and comply with all instructions or policies provided by iGive2 regarding use of the App. In pre-registering to use the App, the Users must true, accurate, current, and complete information.",
          textAlign: TextAlign.justify,
          style: _styles(14, 'Montserrat'),
        ),
        SizedBox(height: 10.0,),
        Text(
          "iGive2 may assume that any use of a User’s registered account and/or communications received by iGive2 from the User’s account, was made by the User unless iGive2 is notified promptly that it was not. The User is entirely responsible for maintaining the confidentiality of information submitted to iGive2, including password(s), and for any activity that occurs under the User’s account as a result of failure to maintain the security and confidentiality of such information. A Users may be held liable for any privacy or other claims asserted or damages incurred by any party, including iGive2, resulting from use of his/her/its account.",
          textAlign: TextAlign.justify,
          style: _styles(14, 'Montserrat'),
        ),
        SizedBox(height: 10.0,),
        Text(
          "Users may not, nor may he/she permit any person to, modify, reverse engineer, disassemble, decompile or otherwise derive or attempt to derive source code from the iGive2 App. A Usersmay not combine any aspect of the App into another program or create or attempt to create derivative works based on the App. Users may not copy, modify, distribute, sell, or lease any component of the App without iGive2 written authorization.",
          textAlign: TextAlign.justify,
          style: _styles(14, 'Montserrat'),
        ),
        SizedBox(height: 10.0,),
        Text(
          "iGive2 may suspend or terminate a Trial or a User other use of the iGive2 App if the User does not comply with these Terms of Use or instructions and policies relating to the use of the App, or if we suspect misuse of the Services by your account.\niGive2 is constantly changing and improving the iGive2 App. We may add, remove, or change features or functionalities of the App, and we may suspend or stop providing the App at any time at our sole discretion.",
          textAlign: TextAlign.justify,
          style: _styles(14, 'Montserrat'),
        ),
        SizedBox(height: 40.0,),
        Text(
          "Limitation of iGive2’s Liability",
          textAlign: TextAlign.justify,
          style: _styles(16, 'MontserratSemiBold'),
        ),
        SizedBox(height: 10.0,),
        Text(
          "iGive2 MAY NOT BE HELD LIABLE FOR ANY DIRECT, INDIRECT, PUNITIVE, INCIDENTAL, SPECIAL, OR CONSEQUENTIAL DAMAGES INCLUDING, WITHOUT LIMITATION, FOR CLAIMS FOR PERSONAL INJURY/WRONGFUL DEATH CAUSED BY USE OR MISUSE OF THE iGive2 APP OR THE CONTENT, OR FOR LOST PROFITS RESULTING FROM DELAYED OR LOST DATA OR OTHER INTERRUPTION OF BUSINESS, ARISING FROM OR RELATED TO USE OR OPERATION OF THE iGive2 APP, OR FROM ANY ACTIONS WE MAY TAKE OR FAIL TO TAKE AS A RESULT OF COMMUNICATIONS AN HCP SENDS TO US. THIS LIMITATION APPLIES IRRESPECTIVE OF THE BASIS OF LIABILITY (i.e., WHETHER BASED ON CONTRACT, TORT, STRICT LIABILITY, OR OTHERWISE). IF A JURISDICTION DOES NOT PERMIT SUCH AN EXCLUSION OR SUCH A LIMITATION ON LIABILITY, THIS EXCLUSION OR LIMITATION ON LIABILITY WILL BE TO THE MAXIMUM EXTENT PERMITTED BY LAW. IN ALL CASES, iGive2 SHALL NOT BE LIABLE FOR ANY LOSS OR DAMAGE THAT WAS NOT REASONABLY FORESEEABLE BY US.",
          textAlign: TextAlign.justify,
          style: _styles(14, 'Montserrat'),
        ),
        SizedBox(height: 10.0,),
        Text(
          "WE MUST BE NOTIFIED OF ANY CLAIMS ARISING FROM OR OTHERWISE RELATING TO USE OF THE iGive2 APP WITHIN ONE YEAR AFTER THE EVENT GIVING RISE TO SUCH A CLAIM OCCURRED, EVEN IF THE BASIS FOR SUCH ACTION WAS NOT KNOWN OR DISCOVERED DURING SUCH ONE-YEAR PERIOD.",
          textAlign: TextAlign.justify,
          style: _styles(14, 'Montserrat'),
        ),
        SizedBox(height: 40.0,),
        Text(
          "Copyright",
          textAlign: TextAlign.justify,
          style: _styles(16, 'MontserratSemiBold'),
        ),
        SizedBox(height: 10.0,),
        Text(
          "All intellectual property rights in the literary and artistic works, typographical layout, sounds, audio-visual items, pathology tracking software, data and other works in iGive2 is the property of Our Company, and is protected by international laws on copyright and other intellectual property rights. No material from this site may not be reproduced, modified, distributed, transmitted, republished, displayed or distributed without the prior written permission of Our Company.",
          textAlign: TextAlign.justify,
          style: _styles(14, 'Montserrat'),
        ),
      ],
    );
  }
}