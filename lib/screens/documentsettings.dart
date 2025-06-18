import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learning_mgt/Utils/lms_styles.dart';
import 'package:learning_mgt/Utils/sizeConfig.dart';
import 'package:learning_mgt/provider/LandingScreenProvider.dart';
import 'package:learning_mgt/provider/personal_account_provider.dart';
import 'package:learning_mgt/widgets/CustomAppBar.dart';
import 'package:learning_mgt/widgets/CustomDrawer.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart'; // Import the file_picker package

class DocumentSetting extends StatefulWidget {
  static const String route = "/DocumentSetting";
  const DocumentSetting({Key? key}) : super(key: key);

  @override
  _DocumentSettingState createState() => _DocumentSettingState();
}

class _DocumentSettingState extends State<DocumentSetting> {
  // State variables to hold selected file information
  // You might want to store this in your provider if you need persistent data
  Map<String, PlatformFile?> _selectedFiles = {};
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  // Function to handle file picking
  Future<void> _pickFile(String documentType) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, // Allow custom file types
        allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'], // Specify allowed extensions
        allowMultiple: false, // Set to true if you want to allow multiple file selection
      );

      if (result != null) {
        PlatformFile file = result.files.first;
        setState(() {
          _selectedFiles[documentType] = file;
        });
        // You can now access file.path, file.name, file.size, file.bytes (for web/desktop)
        print('Selected file for $documentType: ${file.name}');
        print('File path: ${file.path}');
        // Further logic to upload the file to a server or process it
      } else {
        // User canceled the picker
        print('File selection canceled for $documentType');
      }
    } catch (e) {
      print('Error picking file for $documentType: $e');
      // Show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking file: $e')),
      );
    }
  }

  // --- DocumentUploadBox Widget (Copied for completeness, but you can keep it separate) ---
  Widget _buildDocumentUploadBox({
    required String documentName,
    VoidCallback? onViewTap,
    required VoidCallback onUploadTap, // Made required
    PlatformFile? selectedFile, // To show which file is selected
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  documentName,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black87,
                  ),
                ),
                if (selectedFile != null) // Show selected file name
                  Text(
                    selectedFile.name,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.remove_red_eye_outlined,
                color: Colors.grey.shade600),
            onPressed: onViewTap,
            tooltip: 'View Document',
          ),
          IconButton(
            icon: Icon(Icons.upload_file_outlined,
                color: Colors.grey.shade600),
            onPressed: onUploadTap,
            tooltip: 'Upload Document',
          ),
        ],
      ),
    );
  }
  // --- End DocumentUploadBox Widget ---

  @override
  Widget build(BuildContext context) {
    return Consumer<LandingScreenProvider>(builder: (context, provider, _) {
      return WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
          key: scaffoldKey,
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: CustomAppBar(
                  isSearchClickVisible: () {},
                  isSearchValueVisible: false,
                  onMenuPressed: () => scaffoldKey.currentState?.openEndDrawer(),
                ),
              ),
              endDrawer: CustomDrawer(),
          body: Container(
            width: SizeConfig.blockSizeHorizontal * 100,
            height: SizeConfig.blockSizeVertical * 100,
            decoration: AppDecorations.gradientBackground,
            child: Stack(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                      minHeight: 0.0, maxHeight: double.infinity),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: ListView(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      children: [simpleTransplantPlanWidget()],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget simpleTransplantPlanWidget() {
    return Consumer<PersonalAccountProvider>(
        builder: (context, personalprovider, child) {
      return Container(
        margin: EdgeInsets.all(4),
        child: Padding(
          padding: const EdgeInsets.only(left: 4, top: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 0, bottom: 0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios), 
                      onPressed: () {
                        Navigator.pop(context); 
                      },
                      padding: EdgeInsets.zero, 
                      constraints: BoxConstraints(),
                    ),
                    Text(
                      "Documents",
                      style:
                          LMSStyles.tsblackNeutralbold.copyWith(fontSize: 18),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),

              // Document Upload Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
                      child: Text(
                        "Upload Documents",
                        style: LMSStyles.tsblackNeutralbold.copyWith(fontSize: 16),
                      ),
                    ),
                    _buildDocumentUploadBox(
                      documentName: "Birth certificate",
                      selectedFile: _selectedFiles['Birth certificate'], // Pass selected file to update UI
                      onViewTap: () {
                        // Implement logic to view the birth certificate
                        // You'll need to check if _selectedFiles['Birth certificate'] is not null
                        PlatformFile? file = _selectedFiles['Birth certificate'];
                        if (file != null && file.path != null) {
                          // For example, open the file using url_launcher or another package
                          print('Viewing Birth certificate at: ${file.path}');
                        } else {
                          print('No Birth certificate selected to view.');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('No file selected to view.')),
                          );
                        }
                      },
                      onUploadTap: () => _pickFile('Birth certificate'), // Call _pickFile with document type
                    ),
                    _buildDocumentUploadBox(
                      documentName: "Passport",
                      selectedFile: _selectedFiles['Passport'],
                      onViewTap: () {
                        PlatformFile? file = _selectedFiles['Passport'];
                        if (file != null && file.path != null) {
                          print('Viewing Passport at: ${file.path}');
                        } else {
                          print('No Passport selected to view.');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('No file selected to view.')),
                          );
                        }
                      },
                      onUploadTap: () => _pickFile('Passport'),
                    ),
                    _buildDocumentUploadBox(
                      documentName: "Service Book",
                      selectedFile: _selectedFiles['Service Book'],
                      onViewTap: () {
                        PlatformFile? file = _selectedFiles['Service Book'];
                        if (file != null && file.path != null) {
                          print('Viewing Service Book at: ${file.path}');
                        } else {
                          print('No Service Book selected to view.');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('No file selected to view.')),
                          );
                        }
                      },
                      onUploadTap: () => _pickFile('Service Book'),
                    ),
                    _buildDocumentUploadBox(
                      documentName: "Upload your CDC",
                      selectedFile: _selectedFiles['CDC'],
                      onViewTap: () {
                        PlatformFile? file = _selectedFiles['CDC'];
                        if (file != null && file.path != null) {
                          print('Viewing CDC at: ${file.path}');
                        } else {
                          print('No CDC selected to view.');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('No file selected to view.')),
                          );
                        }
                      },
                      onUploadTap: () => _pickFile('CDC'),
                    ),
                    _buildDocumentUploadBox(
                      documentName: "COC",
                      selectedFile: _selectedFiles['COC'],
                      onViewTap: () {
                        PlatformFile? file = _selectedFiles['COC'];
                        if (file != null && file.path != null) {
                          print('Viewing COC at: ${file.path}');
                        } else {
                          print('No COC selected to view.');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('No file selected to view.')),
                          );
                        }
                      },
                      onUploadTap: () => _pickFile('COC'),
                    ),
                    _buildDocumentUploadBox(
                      documentName: "Log Book",
                      selectedFile: _selectedFiles['Log Book'],
                      onViewTap: () {
                        PlatformFile? file = _selectedFiles['Log Book'];
                        if (file != null && file.path != null) {
                          print('Viewing Log Book at: ${file.path}');
                        } else {
                          print('No Log Book selected to view.');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('No file selected to view.')),
                          );
                        }
                      },
                      onUploadTap: () => _pickFile('Log Book'),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
              ),
            ],
          ),
        ),
      );
    });
  }
}