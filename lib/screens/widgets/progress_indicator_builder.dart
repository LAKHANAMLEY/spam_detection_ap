import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:spam_delection_app/screens/loader.dart';

Widget progressIndicatorBuilder(
        BuildContext context, String url, DownloadProgress progress) =>
    Loader(
      value: progress.progress,
    );
