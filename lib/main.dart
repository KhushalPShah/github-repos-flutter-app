// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'strings.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(GithubApp());

class GithubApp extends StatefulWidget {
  @override
  createState() => GithubAppState();
}

class GithubAppState extends State<GithubApp> {
  var _repos = [];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  _loadRepos() async {
    http.Response response = await http.get(Strings.URL);
    setState(() {
      _repos = json.decode(response.body);
    });
  }

  @override
  initState() {
    super.initState();
    _loadRepos();
  }

  Widget _buildRow(int i) {
    return ListTile(title: Text("${_repos[i]["name"]}", style: _biggerFont));
  }

  @override
  Widget build(BuildContext ctx) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(Strings.AppName),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: _repos.length,
          itemBuilder: (BuildContext ctx, int position) {
            return _buildRow(position);
          },
        ),
      ),
    );
  }
}
