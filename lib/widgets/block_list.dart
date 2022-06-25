import 'package:flutter/material.dart';
import '../models/block.dart';
import 'block_card.dart';

class BlockList extends StatelessWidget {
  List<Block> _blockList = [];
  final Function _deleteBlock;

  BlockList(this._blockList, this._deleteBlock);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: _blockList.isEmpty
          ? LayoutBuilder(builder: (context, constraints) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'No Link Added Yet!',
                    style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Comfortaa'),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.05),
                  Container(
                    height: constraints.maxHeight * 0.4,
                    child: Image.asset('assets/images/empty_list_image.png',
                        fit: BoxFit.contain),
                  )
                ],
              );
            })
          : ListView.builder(
              itemCount: _blockList.length,
              itemBuilder: (ctx, index) {
                return BlockCard(_blockList[index], _deleteBlock);
              },
            ),
    );
  }
}
