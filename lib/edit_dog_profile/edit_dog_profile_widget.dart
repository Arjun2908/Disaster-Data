import '../backend/backend.dart';
import '../backend/firebase_storage/storage.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/upload_media.dart';
import 'package:flutter/material.dart';

class EditDogProfileWidget extends StatefulWidget {
  const EditDogProfileWidget({
    Key? key,
    this.dogProfile,
  }) : super(key: key);

  final DogsRecord? dogProfile;

  @override
  _EditDogProfileWidgetState createState() => _EditDogProfileWidgetState();
}

class _EditDogProfileWidgetState extends State<EditDogProfileWidget> {
  bool isMediaUploading1 = false;
  String uploadedFileUrl1 = '';

  bool isMediaUploading2 = false;
  String uploadedFileUrl2 = '';

  TextEditingController? dogNameController;
  TextEditingController? dogBreedController;
  TextEditingController? incidentBioController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    dogBreedController = TextEditingController(text: widget.dogProfile!.dogType);
    dogNameController = TextEditingController(text: widget.dogProfile!.dogName);
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    dogBreedController?.dispose();
    dogNameController?.dispose();
    incidentBioController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DogsRecord>(
      stream: DogsRecord.getDocument(widget.dogProfile!.reference),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                color: FlutterFlowTheme.of(context).primaryColor,
              ),
            ),
          );
        }
        final editDogProfileDogsRecord = snapshot.data!;
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            automaticallyImplyLeading: false,
            leading: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30,
              buttonSize: 46,
              icon: Icon(
                Icons.arrow_back_rounded,
                color: FlutterFlowTheme.of(context).secondaryText,
                size: 24,
              ),
              onPressed: () async {
                context.pop();
              },
            ),
            title: Text(
              'Incident Report',
              style: FlutterFlowTheme.of(context).title2,
            ),
            actions: [],
            centerTitle: false,
            elevation: 0,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 16),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Text(
                                'Edit and make any changes and/or additions to the report',
                                style: FlutterFlowTheme.of(context).bodyText2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        children: [
                          Align(
                            alignment: AlignmentDirectional(-0.02, 0),
                            child: InkWell(
                              onTap: () async {
                                final selectedMedia = await selectMediaWithSourceBottomSheet(
                                  context: context,
                                  allowPhoto: true,
                                );
                                if (selectedMedia != null && selectedMedia.every((m) => validateFileFormat(m.storagePath, context))) {
                                  setState(() => isMediaUploading1 = true);
                                  var downloadUrls = <String>[];
                                  try {
                                    showUploadMessage(
                                      context,
                                      'Uploading file...',
                                      showLoading: true,
                                    );
                                    downloadUrls = (await Future.wait(
                                      selectedMedia.map(
                                        (m) async => await uploadData(m.storagePath, m.bytes),
                                      ),
                                    ))
                                        .where((u) => u != null)
                                        .map((u) => u!)
                                        .toList();
                                  } finally {
                                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                    isMediaUploading1 = false;
                                  }
                                  if (downloadUrls.length == selectedMedia.length) {
                                    setState(() => uploadedFileUrl1 = downloadUrls.first);
                                    showUploadMessage(context, 'Success!');
                                  } else {
                                    setState(() {});
                                    showUploadMessage(context, 'Failed to upload media');
                                    return;
                                  }
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).gray200,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: Image.network(
                                      '',
                                    ).image,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  shape: BoxShape.rectangle,
                                ),
                                child: Align(
                                  alignment: AlignmentDirectional(0.05, 0),
                                  child: InkWell(
                                    onTap: () async {
                                      final selectedMedia = await selectMediaWithSourceBottomSheet(
                                        context: context,
                                        allowPhoto: true,
                                      );
                                      if (selectedMedia != null && selectedMedia.every((m) => validateFileFormat(m.storagePath, context))) {
                                        setState(() => isMediaUploading2 = true);
                                        var downloadUrls = <String>[];
                                        try {
                                          showUploadMessage(
                                            context,
                                            'Uploading file...',
                                            showLoading: true,
                                          );
                                          downloadUrls = (await Future.wait(
                                            selectedMedia.map(
                                              (m) async => await uploadData(m.storagePath, m.bytes),
                                            ),
                                          ))
                                              .where((u) => u != null)
                                              .map((u) => u!)
                                              .toList();
                                        } finally {
                                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                          isMediaUploading2 = false;
                                        }
                                        if (downloadUrls.length == selectedMedia.length) {
                                          setState(() => uploadedFileUrl2 = downloadUrls.first);
                                          showUploadMessage(context, 'Success!');
                                        } else {
                                          setState(() {});
                                          showUploadMessage(context, 'Failed to upload media');
                                          return;
                                        }
                                      }
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.network(
                                        uploadedFileUrl2,
                                        width: MediaQuery.of(context).size.width * 0.9,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0.06, -1.15),
                            child: Text(
                              '\n\n\n\n\n\nAdd Image',
                              style: FlutterFlowTheme.of(context).bodyText2.override(
                                    fontFamily: 'Urbanist',
                                    color: FlutterFlowTheme.of(context).primaryColor,
                                  ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0.05, -0.52),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/Picture_icon_BLACK.svg/1200px-Picture_icon_BLACK.svg.png',
                                  width: MediaQuery.of(context).size.width * 0.2,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: dogNameController,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Title',
                                  labelStyle: FlutterFlowTheme.of(context).subtitle1,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                ),
                                style: FlutterFlowTheme.of(context).title2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                                child: TextFormField(
                                  controller: dogBreedController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Type',
                                    labelStyle: FlutterFlowTheme.of(context).bodyText1,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedErrorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                  ),
                                  style: FlutterFlowTheme.of(context).title3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                                child: TextFormField(
                                  controller: incidentBioController ??= TextEditingController(
                                    text: editDogProfileDogsRecord.dogAge,
                                  ),
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Incident Description',
                                    labelStyle: FlutterFlowTheme.of(context).bodyText2,
                                    hintStyle: FlutterFlowTheme.of(context).bodyText2,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedErrorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    contentPadding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                                  ),
                                  style: FlutterFlowTheme.of(context).bodyText1,
                                  textAlign: TextAlign.start,
                                  maxLines: 4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 60, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Click Save when you are done editing',
                                style: FlutterFlowTheme.of(context).bodyText2,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 40),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  final dogsUpdateData = createDogsRecordData(
                                    dogPhoto: editDogProfileDogsRecord.dogPhoto,
                                    dogName: dogNameController!.text,
                                    dogType: dogBreedController!.text,
                                    dogAge: editDogProfileDogsRecord.dogBio,
                                  );
                                  await widget.dogProfile!.reference.update(dogsUpdateData);
                                  context.pop();
                                },
                                text: 'Save Changes',
                                options: FFButtonOptions(
                                  width: 200,
                                  height: 50,
                                  color: FlutterFlowTheme.of(context).primaryColor,
                                  textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                                        fontFamily: 'Urbanist',
                                        color: Colors.white,
                                      ),
                                  elevation: 2,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
