import 'package:flutter/cupertino.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../annotation/demo.dart';
import '../base/example_widget.dart';

class TTreeSelectPage extends StatefulWidget {
  const TTreeSelectPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TDTreeSelectPageState();
}

class _TDTreeSelectPageState extends State<TTreeSelectPage> {
  String? inputText;
  List<dynamic> values1 = [
    1,
    11,
  ];
  List<dynamic> values2 = [
    1,
    [11, 12, 13],
  ];
  List<dynamic> values3 = [1, 11, 111];

  @override
  Widget build(BuildContext context) {
    return ExamplePage(
      title: tdTitle(),
      desc: '适用于选择树形的数据结构',
      exampleCodeGroup: 'tree',
      children: [
        ExampleModule(
          title: '组件类型',
          children: [
            ExampleItem(desc: '基础树形选择', builder: _buildDefaultTreeSelect),
            ExampleItem(desc: '多选树形选择', builder: _buildMultipleTreeSelect),
          ],
        ),
        ExampleModule(
          title: '组件状态',
          children: [
            ExampleItem(desc: '三级树形选择', builder: _buildThirdTreeSelect),
          ],
        ),
      ],
      test: [
        ExampleItem(desc: '局部多选', builder: _buildPartMultipleTreeSelect),
        ExampleItem(desc: '局部多选', builder: _buildPartMultipleTreeSelect2),
      ],
    );
  }

  @Demo(group: 'tree')
  Widget _buildDefaultTreeSelect(BuildContext context) {
    var options = <TSelectOption>[];

    for (var i = 1; i <= 10; i++) {
      options.add(TSelectOption(label: '选项$i', value: i, children: []));

      for (var j = 1; j <= 10; j++) {
        options[i - 1].children.add(TSelectOption(
              label: '选项$i.$j',
              value: i * 10 + j,
              children: [],
            ));
      }
    }

    return TTreeSelect(
      options: options,
      defaultValue: values1,
      onChange: (val, level) {
        print('$val, $level');
      },
    );
  }

  @Demo(group: 'tree')
  Widget _buildMultipleTreeSelect(BuildContext context) {
    var options = <TSelectOption>[];

    for (var i = 1; i <= 10; i++) {
      options.add(TSelectOption(label: '选项$i', value: i, children: []));

      for (var j = 1; j <= 10; j++) {
        options[i - 1].children.add(
            TSelectOption(label: '选项$i.$j', value: i * 10 + j, children: []));
      }
    }

    return TTreeSelect(
      options: options,
      defaultValue: values2,
      multiple: true,
      onChange: (val, level) {
        print('$val, $level');
      },
    );
  }

  @Demo(group: 'tree')
  Widget _buildThirdTreeSelect(BuildContext context) {
    var options = <TSelectOption>[];
    for (var i = 1; i <= 3; i++) {
      options.add(TSelectOption(
        label: '${i == 1 ? '超长一级选项名称超长一级选项名称' : '选项$i'}',
        value: i,
        maxLines: 10,
        //columnWidth: i == 1 ? 106 : null,
        children: [],
      ));

      for (var j = 1; j <= 3; j++) {
        options[i - 1].children.add(TSelectOption(
              label: '${j == 1 ? '特别长的二级选项特别长的二级选项特别长的二级选项' : '选项$i.$j'}',
              value: i * 10 + j,
              maxLines: 2,
              columnWidth: j == 1 ? 180 : null,
              children: [],
            ));

        for (var k = 1; k <= 3; k++) {
          options[i - 1].children[j - 1].children.add(TSelectOption(
                label:
                    '${k == 1 ? '非常长的三级选项名称非常长的三级选项名称非常长的三级选项名称' : '选项$i.$j.$k'}',
                value: i * 100 + j * 10 + k,
                maxLines: 2,
                //columnWidth: k == 1 ? 102 : null,
              ));
        }
      }
    }
    return TTreeSelect(
      options: options,
      defaultValue: values3,
      onChange: (val, level) {
        print('$val, $level');
      },
    );
  }

  @Demo(group: 'tree')
  Widget _buildPartMultipleTreeSelect(BuildContext context) {
    var options = <TSelectOption>[];

    for (var i = 1; i <= 2; i++) {
      options.add(TSelectOption(
          label: '${i == 1 ? '单选' : '多选'}', value: i, children: []));

      for (var j = 1; j <= 10; j++) {
        options[i - 1].children.add(TSelectOption(
            label: '选项$i.$j',
            value: i * 10 + j,
            children: [],
            multiple: i == 2));
      }
    }

    return TTreeSelect(
      options: options,
      defaultValue: values1,
      onChange: (val, level) {
        print('$val, $level');
      },
    );
  }

  @Demo(group: 'tree')
  Widget _buildPartMultipleTreeSelect2(BuildContext context) {
    var options = <TSelectOption>[];

    for (var i = 1; i <= 2; i++) {
      options.add(TSelectOption(
          label: '${i == 1 ? '单选' : '多选'}', value: i, children: []));

      for (var j = 1; j <= 10; j++) {
        options[i - 1].children.add(TSelectOption(
            label: '选项$i.$j',
            value: i * 10 + j,
            children: [],
            multiple: i == 2));
      }
    }

    return TTreeSelect(
      options: options,
      defaultValue: values1,
      style: TTreeSelectStyle.outline,
      onChange: (val, level) {
        print('$val, $level');
      },
    );
  }
}
