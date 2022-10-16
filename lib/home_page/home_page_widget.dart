import '../backend/backend.dart';
import '../components/create_modal_widget.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_media_display.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_video_player.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  height: 240,
                  child: CreateModalWidget(),
                ),
              );
            },
          ).then((value) => setState(() {}));
        },
        backgroundColor: Color(0xFF4B39EF),
        elevation: 8,
        child: Icon(
          Icons.create_rounded,
          color: Colors.white,
          size: 24,
        ),
      ),
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        automaticallyImplyLeading: false,
        title: Row(
          // mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (Theme.of(context).brightness == Brightness.light)
              Image.asset(
                'assets/images/logoSniff_dark@3x.png',
                width: 120,
                height: 50,
                fit: BoxFit.fitWidth,
              ),
            if (Theme.of(context).brightness == Brightness.dark)
              Image.asset(
                'assets/images/logoSniff_dark@3x.png',
                width: 240,
                height: 50,
                fit: BoxFit.fitWidth,
              ),
          ],
        ),
        actions: [
          // Padding(
          //   padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
          //   child: FlutterFlowIconButton(
          //     borderColor: Colors.transparent,
          //     borderRadius: 30,
          //     buttonSize: 46,
          //     icon: Icon(
          //       Icons.notifications_outlined,
          //       color: FlutterFlowTheme.of(context).grayIcon,
          //       size: 24,
          //     ),
          //     onPressed: () {
          //       print('IconButton pressed ...');
          //     },
          //   ),
          // ),
        ],
        centerTitle: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 158,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).alternate,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 3,
                    color: Color(0x3A000000),
                    offset: Offset(0, 1),
                  )
                ],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                ),
                shape: BoxShape.rectangle,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 5, 290, 8),
                    child: Text(
                      'Stories',
                      textAlign: TextAlign.start,
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Urbanist',
                            fontSize: 21,
                          ),
                    ),
                  ),
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: StreamBuilder<List<UserStoriesRecord>>(
                      stream: queryUserStoriesRecord(
                        queryBuilder: (userStoriesRecord) => userStoriesRecord.orderBy('storyPostedAt', descending: true),
                        limit: 20,
                      ),
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
                        List<UserStoriesRecord> listViewUserStoriesRecordList = snapshot.data!;
                        if (listViewUserStoriesRecordList.isEmpty) {
                          return Center(
                            child: Image.asset(
                              'assets/images/df3hg_',
                              width: 60,
                            ),
                          );
                        }
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          itemCount: listViewUserStoriesRecordList.length,
                          itemBuilder: (context, listViewIndex) {
                            final listViewUserStoriesRecord = listViewUserStoriesRecordList[listViewIndex];
                            return Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                              child: StreamBuilder<UsersRecord>(
                                stream: UsersRecord.getDocument(listViewUserStoriesRecord.user!),
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
                                  final columnUsersRecord = snapshot.data!;
                                  return InkWell(
                                    onTap: () async {
                                      context.pushNamed(
                                        'storyDetails',
                                        queryParams: {
                                          'initialStoryIndex': serializeParam(
                                            listViewIndex,
                                            ParamType.int,
                                          ),
                                        }.withoutNulls,
                                        extra: <String, dynamic>{
                                          kTransitionInfoKey: TransitionInfo(
                                            hasTransition: true,
                                            transitionType: PageTransitionType.bottomToTop,
                                            duration: Duration(milliseconds: 200),
                                          ),
                                        },
                                      );
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        // rounded image
                                        Container(
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context).secondaryBackground,
                                            shape: BoxShape.circle,
                                            // white wring around image
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 2,
                                            ),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                valueOrDefault<String>(
                                                  columnUsersRecord.photoUrl,
                                                  'https://filecache.mediaroom.com/mr5mr_paypal/183497/supporting%20relief%20efforts%20in%20Ukraine%20GettyImages-1238750704.jpg',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                          child: AutoSizeText(
                                            valueOrDefault<String>(
                                              columnUsersRecord.displayName,
                                              'Ellie May',
                                            ).maybeHandleOverflow(
                                              maxChars: 8,
                                              replacement: '…',
                                            ),
                                            style: FlutterFlowTheme.of(context).bodyText1.override(
                                                  fontFamily: 'Urbanist',
                                                  fontSize: 14,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 155, 0),
                  child: Text(
                    'Trending',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Urbanist',
                          fontSize: 22,
                        ),
                  ),
                ),
                FFButtonWidget(
                  onPressed: () async {
                    context.pushNamed('posts');
                  },
                  text: 'More ->',
                  options: FFButtonOptions(
                    width: 130,
                    height: 40,
                    color: FlutterFlowTheme.of(context).alternate,
                    textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                          fontFamily: 'Urbanist',
                          color: FlutterFlowTheme.of(context).primaryColor,
                        ),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
            Align(
              // alignment: AlignmentDirectional(-0.7, 0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: Material(
                  color: Colors.transparent,
                  elevation: 15,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                    width: 280,
                    height: 268,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF4B39EF).withOpacity(0.6),
                          // offset: Offset(0, 20),
                          blurRadius: 30,
                          spreadRadius: 5,
                        )
                      ],
                      gradient: LinearGradient(
                        colors: [FlutterFlowTheme.of(context).primaryColor, FlutterFlowTheme.of(context).secondaryColor],
                        stops: [0, 1],
                        begin: AlignmentDirectional(0, -1),
                        end: AlignmentDirectional(0, 10),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: AlignmentDirectional(0, 0.050000000000000044),
                    child: StreamBuilder<List<UserPostsRecord>>(
                      stream: queryUserPostsRecord(
                        queryBuilder: (userPostsRecord) => userPostsRecord.orderBy('timePosted', descending: true),
                        limit: 1,
                      ),
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
                        List<UserPostsRecord> socialFeedUserPostsRecordList = snapshot.data!;
                        if (socialFeedUserPostsRecordList.isEmpty) {
                          return Center(
                            child: Image.asset(
                              'assets/images/emptyPosts@2x.png',
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: 400,
                            ),
                          );
                        }
                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          children: List.generate(socialFeedUserPostsRecordList.length, (socialFeedIndex) {
                            final socialFeedUserPostsRecord = socialFeedUserPostsRecordList[socialFeedIndex];
                            return Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 8),
                              child: StreamBuilder<UsersRecord>(
                                stream: UsersRecord.getDocument(socialFeedUserPostsRecord.postUser!),
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
                                  final userPostUsersRecord = snapshot.data!;
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 4,
                                          color: Color(0x32000000),
                                          offset: Offset(0, 2),
                                        )
                                      ],
                                      gradient: LinearGradient(
                                        colors: [FlutterFlowTheme.of(context).primaryColor, Color(0xFFF5F5F5)],
                                        stops: [0, 1],
                                        begin: AlignmentDirectional(0, -1),
                                        end: AlignmentDirectional(0, 1),
                                      ),
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    child: InkWell(
                                      onTap: () async {
                                        context.pushNamed(
                                          'postDetails',
                                          queryParams: {
                                            'userRecord': serializeParam(
                                              userPostUsersRecord,
                                              ParamType.Document,
                                            ),
                                            'postReference': serializeParam(
                                              socialFeedUserPostsRecord.reference,
                                              ParamType.DocumentReference,
                                            ),
                                          }.withoutNulls,
                                          extra: <String, dynamic>{
                                            'userRecord': userPostUsersRecord,
                                          },
                                        );
                                      },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 2, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: () async {
                                                    context.pushNamed(
                                                      'viewProfilePageOther',
                                                      queryParams: {
                                                        'userDetails': serializeParam(
                                                          userPostUsersRecord,
                                                          ParamType.Document,
                                                        ),
                                                      }.withoutNulls,
                                                      extra: <String, dynamic>{
                                                        'userDetails': userPostUsersRecord,
                                                      },
                                                    );
                                                  },
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                                                        child: Card(
                                                          clipBehavior: Clip.antiAliasWithSaveLayer,
                                                          color: Color(0xFF4B39EF),
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(20),
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(1, 1, 1, 1),
                                                            child: Container(
                                                              width: 40,
                                                              height: 40,
                                                              clipBehavior: Clip.antiAlias,
                                                              decoration: BoxDecoration(
                                                                shape: BoxShape.circle,
                                                              ),
                                                              child: CachedNetworkImage(
                                                                imageUrl: valueOrDefault<String>(
                                                                  userPostUsersRecord.photoUrl,
                                                                  'https://filecache.mediaroom.com/mr5mr_paypal/183497/supporting%20relief%20efforts%20in%20Ukraine%20GettyImages-1238750704.jpg',
                                                                ),
                                                                fit: BoxFit.fitWidth,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                                        child: Text(
                                                          valueOrDefault<String>(
                                                            userPostUsersRecord.userName,
                                                            'myUsername',
                                                          ),
                                                          style: FlutterFlowTheme.of(context).subtitle1,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          FlutterFlowMediaDisplay(
                                            path: valueOrDefault<String>(
                                              socialFeedUserPostsRecord.postPhoto,
                                              'https://static01.nyt.com/images/2022/10/12/podcasts/12daily-1/12DAILY-ukraine-missles-audio-app-superJumbo-v2.jpg?quality=75&auto=webp',
                                            ),
                                            imageBuilder: (path) => CachedNetworkImage(
                                              imageUrl: path,
                                              width: MediaQuery.of(context).size.width,
                                              height: 150,
                                              fit: BoxFit.cover,
                                            ),
                                            videoPlayerBuilder: (path) => FlutterFlowVideoPlayer(
                                              path: path,
                                              width: 300,
                                              autoPlay: false,
                                              looping: true,
                                              showControls: true,
                                              allowFullScreen: true,
                                              allowPlaybackSpeedMenu: false,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(8, 4, 8, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                                                      child: Text(
                                                        dateTimeFormat('relative', socialFeedUserPostsRecord.timePosted!),
                                                        style: FlutterFlowTheme.of(context).bodyText1.override(
                                                              fontFamily: 'Urbanist',
                                                              color: FlutterFlowTheme.of(context).primaryDark,
                                                            ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 12, 12),
                                                    child: Text(
                                                      valueOrDefault<String>(
                                                        socialFeedUserPostsRecord.postDescription,
                                                        'I\'m back with a super quick Instagram redesign just for the fan. Rounded corners and cute icons, what else do we need, haha.⁣ ',
                                                      ),
                                                      style: FlutterFlowTheme.of(context).bodyText1.override(
                                                            fontFamily: 'Urbanist',
                                                            color: FlutterFlowTheme.of(context).primaryDark,
                                                            fontSize: 14,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 155, 0),
                    child: Text(
                      'Discover',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Urbanist',
                            fontSize: 22,
                          ),
                    ),
                  ),
                  FFButtonWidget(
                    onPressed: () async {
                      context.pushNamed('posts');
                    },
                    text: 'More ->',
                    options: FFButtonOptions(
                      width: 130,
                      height: 40,
                      color: FlutterFlowTheme.of(context).alternate,
                      textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                            fontFamily: 'Urbanist',
                            color: FlutterFlowTheme.of(context).primaryColor,
                          ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              // alignment: AlignmentDirectional(-0.7, 0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 20),
                child: Material(
                  color: Colors.transparent,
                  elevation: 15,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                    width: 280,
                    height: 282,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: Color(0x33000000),
                          offset: Offset(0, 2),
                        )
                      ],
                      gradient: LinearGradient(
                        colors: [FlutterFlowTheme.of(context).primaryColor, FlutterFlowTheme.of(context).secondaryColor],
                        stops: [0, 1],
                        begin: AlignmentDirectional(0, -1),
                        end: AlignmentDirectional(0, 10),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: AlignmentDirectional(0, 0.050000000000000044),
                    child: StreamBuilder<List<UserPostsRecord>>(
                      stream: queryUserPostsRecord(
                        queryBuilder: (userPostsRecord) => userPostsRecord.orderBy('timePosted', descending: true),
                        limit: 1,
                      ),
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
                        List<UserPostsRecord> socialFeedUserPostsRecordList = snapshot.data!;
                        if (socialFeedUserPostsRecordList.isEmpty) {
                          return Center(
                            child: Image.asset(
                              'assets/images/emptyPosts@2x.png',
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: 400,
                            ),
                          );
                        }
                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          children: List.generate(socialFeedUserPostsRecordList.length, (socialFeedIndex) {
                            final socialFeedUserPostsRecord = socialFeedUserPostsRecordList[socialFeedIndex];
                            return Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 8),
                              child: StreamBuilder<UsersRecord>(
                                stream: UsersRecord.getDocument(socialFeedUserPostsRecord.postUser!),
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
                                  final userPostUsersRecord = snapshot.data!;
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context).secondaryBackground,
                                      boxShadow: [
                                        BoxShadow(
                                          // color: Colors.blue.withOpacity(0.8),
                                          // offset: Offset(20, 20),
                                          blurRadius: 30,
                                          spreadRadius: 10,
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    child: InkWell(
                                      onTap: () async {
                                        context.pushNamed(
                                          'postDetails',
                                          queryParams: {
                                            'userRecord': serializeParam(
                                              userPostUsersRecord,
                                              ParamType.Document,
                                            ),
                                            'postReference': serializeParam(
                                              socialFeedUserPostsRecord.reference,
                                              ParamType.DocumentReference,
                                            ),
                                          }.withoutNulls,
                                          extra: <String, dynamic>{
                                            'userRecord': userPostUsersRecord,
                                          },
                                        );
                                      },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(0, 8, 2, 4),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: () async {
                                                    context.pushNamed(
                                                      'viewProfilePageOther',
                                                      queryParams: {
                                                        'userDetails': serializeParam(
                                                          userPostUsersRecord,
                                                          ParamType.Document,
                                                        ),
                                                      }.withoutNulls,
                                                      extra: <String, dynamic>{
                                                        'userDetails': userPostUsersRecord,
                                                      },
                                                    );
                                                  },
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                                                        child: Card(
                                                          clipBehavior: Clip.antiAliasWithSaveLayer,
                                                          color: Color(0xFF4B39EF),
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(20),
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(1, 1, 1, 1),
                                                            child: Container(
                                                              width: 40,
                                                              height: 40,
                                                              clipBehavior: Clip.antiAlias,
                                                              decoration: BoxDecoration(
                                                                shape: BoxShape.circle,
                                                              ),
                                                              child: CachedNetworkImage(
                                                                imageUrl: valueOrDefault<String>(
                                                                  userPostUsersRecord.photoUrl,
                                                                  'https://filecache.mediaroom.com/mr5mr_paypal/183497/supporting%20relief%20efforts%20in%20Ukraine%20GettyImages-1238750704.jpg',
                                                                ),
                                                                fit: BoxFit.fitWidth,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                                        child: Text(
                                                          valueOrDefault<String>(
                                                            userPostUsersRecord.userName,
                                                            'myUsername',
                                                          ),
                                                          style: FlutterFlowTheme.of(context).subtitle1,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          FlutterFlowMediaDisplay(
                                            path: valueOrDefault<String>(
                                              socialFeedUserPostsRecord.postPhoto,
                                              'https://static01.nyt.com/images/2022/10/12/podcasts/12daily-1/12DAILY-ukraine-missles-audio-app-superJumbo-v2.jpg?quality=75&auto=webp',
                                            ),
                                            imageBuilder: (path) => CachedNetworkImage(
                                              imageUrl: path,
                                              width: MediaQuery.of(context).size.width,
                                              height: 150,
                                              fit: BoxFit.cover,
                                            ),
                                            videoPlayerBuilder: (path) => FlutterFlowVideoPlayer(
                                              path: path,
                                              width: 300,
                                              autoPlay: false,
                                              looping: true,
                                              showControls: true,
                                              allowFullScreen: true,
                                              allowPlaybackSpeedMenu: false,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(8, 4, 8, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                                                  child: Text(
                                                    dateTimeFormat('relative', socialFeedUserPostsRecord.timePosted!),
                                                    style: FlutterFlowTheme.of(context).bodyText1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(2, 4, 0, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding: EdgeInsetsDirectional.fromSTEB(8, 0, 12, 12),
                                                    child: Text(
                                                      valueOrDefault<String>(
                                                        socialFeedUserPostsRecord.postDescription,
                                                        'I\'m back with a super quick Instagram redesign just for the fan. Rounded corners and cute icons, what else do we need, haha.⁣ ',
                                                      ),
                                                      style: FlutterFlowTheme.of(context).bodyText1,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
