import 'package:flutter/material.dart';
import 'package:pikapi/basic/Entities.dart';
import 'package:pikapi/screens/components/ComicInfoCard.dart';
import 'LinkToComicInfo.dart';
import 'ContentBuilder.dart';

class ComicListBuilder extends StatelessWidget {
  final Future<List<ComicSimple>> future;
  final Future Function() reload;

  ComicListBuilder(this.future, this.reload);

  @override
  Widget build(BuildContext context) {
    return ContentBuilder(
      future: future,
      onRefresh: reload,
      successBuilder:
          (BuildContext context, AsyncSnapshot<List<ComicSimple>> snapshot) {
        return RefreshIndicator(
          onRefresh: reload,
          child: ListView(
            children: [
              ...snapshot.data!.map((e) => LinkToComicInfo(
                    comicId: e.id,
                    child: ComicInfoCard(e),
                  )),
              MaterialButton(
                onPressed: reload,
                child: Container(
                  padding: EdgeInsets.all(30),
                  child: Text('刷新'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
