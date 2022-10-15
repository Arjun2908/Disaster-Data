import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_media_display.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_video_player.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PostsWidget extends StatefulWidget {
  const PostsWidget({Key? key}) : super(key: key);

  @override
  _PostsWidgetState createState() => _PostsWidgetState();
}

class _PostsWidgetState extends State<PostsWidget> with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var hasIconTriggered = false;
  final animationsMap = {
    'iconOnActionTriggerAnimation': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: false,
      effects: [
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 1.2,
          end: 1,
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    setupAnimations(
      animationsMap.values.where((anim) => anim.trigger == AnimationTrigger.onActionTrigger || !anim.applyInitialState),
      this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).alternate,
          automaticallyImplyLeading: true,
          leading: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
            child: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30,
              borderWidth: 1,
              buttonSize: 60,
              icon: Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () async {
                context.pop();
              },
            ),
          ),
          title: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
            child: Text(
              'Trending Posts',
              style: FlutterFlowTheme.of(context).title2.override(
                    fontFamily: 'Urbanist',
                    color: Colors.white,
                    fontSize: 22,
                  ),
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 32),
                  child: StreamBuilder<List<UserPostsRecord>>(
                    stream: queryUserPostsRecord(
                      queryBuilder: (userPostsRecord) => userPostsRecord.orderBy('timePosted', descending: true),
                      limit: 50,
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
                                        blurRadius: 4,
                                        color: Color(0x32000000),
                                        offset: Offset(0, 2),
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
                                      mainAxisSize: MainAxisSize.max,
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
                                              FlutterFlowIconButton(
                                                borderColor: Colors.transparent,
                                                borderRadius: 30,
                                                buttonSize: 46,
                                                icon: Icon(
                                                  Icons.keyboard_control,
                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                  size: 20,
                                                ),
                                                onPressed: () {
                                                  print('IconButton pressed ...');
                                                },
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
                                            height: 300,
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
                                                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
                                                    child: Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      children: [
                                                        Container(
                                                          width: 41,
                                                          height: 41,
                                                          child: Stack(
                                                            children: [
                                                              if (!socialFeedUserPostsRecord.likes!.toList().contains(currentUserReference))
                                                                Align(
                                                                  alignment: AlignmentDirectional(0, 0.25),
                                                                  child: InkWell(
                                                                    onTap: () async {
                                                                      final userPostsUpdateData = {
                                                                        'likes': FieldValue.arrayUnion([currentUserReference]),
                                                                      };
                                                                      await socialFeedUserPostsRecord.reference.update(userPostsUpdateData);
                                                                      if (animationsMap['iconOnActionTriggerAnimation'] != null) {
                                                                        setState(() => hasIconTriggered = true);
                                                                        SchedulerBinding.instance
                                                                            .addPostFrameCallback((_) async => await animationsMap['iconOnActionTriggerAnimation']!.controller.forward(from: 0.0));
                                                                      }
                                                                    },
                                                                    child: Icon(
                                                                      Icons.favorite,
                                                                      color: Color(0xFF95A1AC),
                                                                      size: 25,
                                                                    ),
                                                                  ),
                                                                ),
                                                              if (socialFeedUserPostsRecord.likes!.toList().contains(currentUserReference))
                                                                Align(
                                                                  alignment: AlignmentDirectional(0, 0.25),
                                                                  child: InkWell(
                                                                    onTap: () async {
                                                                      final userPostsUpdateData = {
                                                                        'likes': FieldValue.arrayRemove([currentUserReference]),
                                                                      };
                                                                      await socialFeedUserPostsRecord.reference.update(userPostsUpdateData);
                                                                    },
                                                                    child: Icon(
                                                                      Icons.favorite,
                                                                      color: Color(0xFF4B39EF),
                                                                      size: 25,
                                                                    ),
                                                                  ).animateOnActionTrigger(animationsMap['iconOnActionTriggerAnimation']!, hasBeenTriggered: hasIconTriggered),
                                                                ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                                                          child: Text(
                                                            valueOrDefault<String>(
                                                              functions.likes(socialFeedUserPostsRecord).toString(),
                                                              '0',
                                                            ),
                                                            style: FlutterFlowTheme.of(context).bodyText2.override(
                                                                  fontFamily: 'Lexend Deca',
                                                                  color: Color(0xFF8B97A2),
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.normal,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      Icon(
                                                        Icons.mode_comment_outlined,
                                                        color: Color(0xFF95A1AC),
                                                        size: 24,
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                                                        child: Text(
                                                          socialFeedUserPostsRecord.numComments!.toString(),
                                                          style: FlutterFlowTheme.of(context).bodyText2.override(
                                                                fontFamily: 'Lexend Deca',
                                                                color: Color(0xFF8B97A2),
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.normal,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsetsDirectional.fromSTEB(0, 2, 8, 0),
                                                    child: Text(
                                                      dateTimeFormat('relative', socialFeedUserPostsRecord.timePosted!),
                                                      style: FlutterFlowTheme.of(context).bodyText1,
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.ios_share,
                                                    color: Color(0xFF95A1AC),
                                                    size: 24,
                                                  ),
                                                ],
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
                                                  padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 12),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
