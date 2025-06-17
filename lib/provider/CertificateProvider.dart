import 'package:flutter/material.dart';

class CertificateProvider {
  final String id;
  final String title;
  final String description;
  final String instituteID;
  final String courseDuration;
  final String downloadLink;
  DateTime? expiryDate;
  bool? isDownloaded;


  CertificateProvider(
     {
    required this.id,
    required this.title,
    required this.description,
    required this.instituteID,
    required this.downloadLink,
    required this.courseDuration,
    this.expiryDate,
    this.isDownloaded,

  });
}

class CertificateCourseprovider with ChangeNotifier {
  final Map<String, List<CertificateProvider>> _coursesByCategory = {
    'All': [
     CertificateProvider(
        id: '1',
        title: 'Macosnar Training Institute Corp.',
        description: 'Chart Plotting Techniques',
        instituteID: "#ACD121212",
        courseDuration: "25.5 hr",
        downloadLink: ""
        
        
      ), 
      CertificateProvider(
        id: '1',
         title: 'Macosnar Training Institute Corp.',
        description: 'Chart Plotting Techniques',
        instituteID: "#ACD121212",
        courseDuration: "25.5 hr",
        downloadLink: ""
        
        
      ), 
      CertificateProvider(
        id: '1',
        title: 'Macosnar Training Institute Corp.',
        description: 'Chart Plotting Techniques',
        instituteID: "#ACD121212",
        courseDuration: "25.5 hr",
        downloadLink: ""
        
        
      ), 
    ],


  };

  Map<String, List<CertificateProvider>> get coursesByCategory => _coursesByCategory;
}
