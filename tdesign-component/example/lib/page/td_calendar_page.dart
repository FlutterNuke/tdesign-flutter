import 'package:flutter/material.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import '../../base/example_widget.dart';
import '../annotation/demo.dart';

class TCalendarPage extends StatelessWidget {
  const TCalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ExamplePage(
      title: tdTitle(context),
      desc: '按照日历形式展示数据或日期的容器。',
      exampleCodeGroup: 'calendar',
      children: [
        ExampleModule(title: '组件类型', children: [
          ExampleItem(
            ignoreCode: true,
            center: false,
            builder: (BuildContext context) {
              return const CodeWrapper(builder: _buildSimple);
            },
          ),
        ]),
        ExampleModule(title: '组件样式', children: [
          ExampleItem(
            desc: '可以自由定义想要的风格',
            ignoreCode: true,
            center: false,
            builder: (BuildContext context) {
              return const CodeWrapper(builder: _buildStyle);
            },
          ),
          ExampleItem(
            desc: '自定义日期单元格',
            ignoreCode: true,
            center: false,
            builder: (BuildContext context) {
              return const CodeWrapper(builder: _buildCustomCell);
            },
          ),
          ExampleItem(
            desc: '不使用Popup',
            ignoreCode: true,
            center: false,
            builder: (BuildContext context) {
              return const CodeWrapper(builder: _buildBlock);
            },
          ),
        ]),
      ],
      test: const [],
    );
  }
}

@Demo(group: 'calendar')
Widget _buildSimple(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final selected = ValueNotifier<List<int>>(
      [DateTime.now().millisecondsSinceEpoch + 30 * 24 * 60 * 60 * 1000]);
  return ValueListenableBuilder(
    valueListenable: selected,
    builder: (context, value, child) {
      final date = DateTime.fromMillisecondsSinceEpoch(value[0]);
      return TCellGroup(
        cells: [
          TCell(
            title: '单个选择日历',
            arrow: true,
            note: '${date.year}-${date.month}-${date.day}',
            onClick: (cell) {
              TCalendarPopup(
                context,
                visible: true,
                onConfirm: (value) {
                  print('onConfirm：$value');
                  selected.value = value;
                },
                onClose: () {
                  print('onClose');
                },
                child: TCalendar(
                  title: '请选择日期',
                  value: value,
                  height: size.height * 0.6 + 176,
                  onCellClick: (value, type, tdate) {
                    print('onCellClick: $value');
                  },
                  onCellLongPress: (value, type, tdate) {
                    print('onCellLongPress: $value');
                  },
                  onHeaderClick: (index, week) {
                    print('onHeaderClick: $week');
                  },
                  onChange: (value) {
                    print('onChange: $value');
                  },
                ),
              );
            },
          ),
          TCell(
            title: '多个选择日历',
            arrow: true,
            onClick: (cell) {
              TCalendarPopup(
                context,
                visible: true,
                child: TCalendar(
                  title: '请选择日期',
                  type: CalendarType.multiple,
                  value: [DateTime.now().millisecondsSinceEpoch],
                  height: size.height * 0.6 + 176,
                ),
              );
            },
          ),
          TCell(
            title: '区间选择日历',
            arrow: true,
            onClick: (cell) {
              TCalendarPopup(
                context,
                visible: true,
                child: TCalendar(
                  title: '请选择日期区间',
                  type: CalendarType.range,
                  value: [
                    DateTime.now().millisecondsSinceEpoch,
                    DateTime.now()
                        .add(const Duration(days: 6))
                        .millisecondsSinceEpoch,
                  ],
                  height: size.height * 0.6 + 176,
                ),
              );
            },
          ),
          TCell(
            title: '单个选择日历和时间',
            arrow: true,
            note:
                '${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}',
            onClick: (cell) {
              TCalendarPopup(
                context,
                visible: true,
                onConfirm: (value) {
                  print('onConfirm:$value');
                  selected.value = value;
                },
                onClose: () {
                  print('onClose');
                },
                child: TCalendar(
                  title: '请选择日期和时间',
                  value: value,
                  height: size.height * 0.92,
                  useTimePicker: true,
                  // pickerHeight: 100,
                  // pickerItemCount: 2,
                  onCellClick: (value, type, tdate) {
                    print('onCellClick: $value');
                  },
                  onCellLongPress: (value, type, tdate) {
                    print('onCellLongPress: $value');
                  },
                  onHeaderClick: (index, week) {
                    print('onHeaderClick: $week');
                  },
                  onChange: (value) {
                    print('onChange: $value');
                  },
                ),
              );
            },
          ),
          TCell(
            title: '区间选择日历和时间',
            arrow: true,
            onClick: (cell) {
              TCalendarPopup(
                context,
                visible: true,
                onConfirm: (value) {
                  print('onConfirm: $value');
                },
                onClose: () {
                  print('onClose');
                },
                child: TCalendar(
                  title: '请选择日期和时间区间',
                  height: size.height * 0.92,
                  type: CalendarType.range,
                  value: [
                    DateTime.now().millisecondsSinceEpoch,
                    DateTime.now()
                        .add(const Duration(days: 3))
                        .millisecondsSinceEpoch,
                  ],
                  useTimePicker: true,
                  onCellClick: (value, type, tdate) {
                    print('onCellClick: $value');
                  },
                  onCellLongPress: (value, type, tdate) {
                    print('onCellLongPress: $value');
                  },
                  onHeaderClick: (index, week) {
                    print('onHeaderClick: $week');
                  },
                  onChange: (value) {
                    print('onChange: $value');
                  },
                ),
              );
            },
          ),
        ],
      );
    },
  );
}

@Demo(group: 'calendar')
Widget _buildStyle(BuildContext context) {
  final size = MediaQuery.of(context).size;
  const map = {
    1: '初一',
    2: '初二',
    3: '初三',
    14: '情人节',
    15: '元宵节',
  };
  return TCellGroup(
    cells: [
      TCell(
        title: '自定义文案',
        arrow: true,
        onClick: (cell) {
          TCalendarPopup(
            context,
            visible: true,
            child: TCalendar(
              title: '请选择日期',
              height: size.height * 0.6 + 176,
              minDate: DateTime(2022, 1, 1).millisecondsSinceEpoch,
              maxDate: DateTime(2022, 2, 15).millisecondsSinceEpoch,
              format: (day) {
                day?.suffix = '¥60';
                if (day?.date.month == 2) {
                  if (map.keys.contains(day?.date.day)) {
                    day?.suffix = '¥100';
                    day?.prefix = map[day.date.day];
                    day?.style = TextStyle(
                      fontSize: TTheme.of(context).fontTitleMedium?.size,
                      height: TTheme.of(context).fontTitleMedium?.height,
                      fontWeight:
                          TTheme.of(context).fontTitleMedium?.fontWeight,
                      color: TTheme.of(context).errorColor6,
                    );
                    if (day?.typeNotifier.value == DateSelectType.selected) {
                      day?.style = day.style
                          ?.copyWith(color: TTheme.of(context).fontWhColor1);
                    }
                  }
                }
                return null;
              },
            ),
          );
        },
      ),
      TCell(
        title: '自定义按钮',
        arrow: true,
        onClick: (cell) {
          late final TCalendarPopup calendar;
          calendar = TCalendarPopup(
            context,
            visible: true,
            confirmBtn: Padding(
              padding:
                  EdgeInsets.symmetric(vertical: TTheme.of(context).spacer16),
              child: TButton(
                theme: TButtonTheme.danger,
                shape: TButtonShape.round,
                text: 'ok',
                isBlock: true,
                size: TButtonSize.large,
                onTap: () {
                  print(calendar.selected);
                  calendar.close();
                },
              ),
            ),
            child: TCalendar(
              title: '请选择日期',
              value: [DateTime.now().millisecondsSinceEpoch],
              height: size.height * 0.6 + 176,
            ),
          );
        },
      ),
      TCell(
        title: '自定义日期区间',
        arrow: true,
        onClick: (cell) {
          TCalendarPopup(
            context,
            visible: true,
            child: TCalendar(
              title: '请选择日期',
              minDate: DateTime(2000, 1, 1).millisecondsSinceEpoch,
              maxDate: DateTime(3000, 1, 1).millisecondsSinceEpoch,
              value: [DateTime(2024, 10, 1).millisecondsSinceEpoch],
              height: size.height * 0.6 + 176,
            ),
          );
        },
      ),
    ],
  );
}

@Demo(group: 'calendar')
Widget _buildBlock(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final selected = ValueNotifier<List<int>>(
    [DateTime.now().millisecondsSinceEpoch + 30 * 24 * 60 * 60 * 1000],
  );
  return Column(
    // spacing: TTheme.of(context).spacer16,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        // spacing: TTheme.of(context).spacer16,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TButton(
            text: '加一个月',
            theme: TButtonTheme.primary,
            onTap: () {
              selected.value = [selected.value[0] + 30 * 24 * 60 * 60 * 1000];
            },
          ),
          const SizedBox(width: 16),
          TButton(
            text: '减一个月',
            theme: TButtonTheme.primary,
            onTap: () {
              selected.value = [selected.value[0] - 30 * 24 * 60 * 60 * 1000];
            },
          ),
        ],
      ),
      const SizedBox(height: 16),
      ValueListenableBuilder(
        valueListenable: selected,
        builder: (context, value, child) {
          return TCalendar(
            title: '请选择日期',
            value: value,
            height: size.height * 0.6 + 176,
            animateTo: true,
            // 不使用popup时，useSafeArea无效
            useSafeArea: true,
          );
        },
      ),
    ],
  );
}

@Demo(group: 'calendar')
Widget _buildCustomCell(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final selected = ValueNotifier<List<int>>(
      [DateTime.now().millisecondsSinceEpoch + 30 * 24 * 60 * 60 * 1000]);
  return ValueListenableBuilder(
    valueListenable: selected,
    builder: (context, value, child) {
      final date = DateTime.fromMillisecondsSinceEpoch(value[0]);
      return TCellGroup(
        cells: [
          TCell(
            title: '自定义日期单元格',
            arrow: true,
            note: '${date.year}-${date.month}-${date.day}',
            onClick: (cell) {
              TCalendarPopup(
                context,
                visible: true,
                onConfirm: (value) {
                  print('onConfirm:$value');
                  selected.value = value;
                },
                onClose: () {
                  print('onClose');
                },
                child: TCalendar(
                    title: '请选择日期',
                    value: value,
                    height: size.height * 0.6 + 176,
                    onCellClick: (value, type, tdate) {
                      print('onCellClick: $value');
                    },
                    onCellLongPress: (value, type, tdate) {
                      print('onCellLongPress: $value');
                    },
                    onHeaderClick: (index, week) {
                      print('onHeaderClick: $week');
                    },
                    onChange: (value) {
                      print('onChange: $value');
                    },
                    cellWidget: (context, tdate, selectType) {
                      if (selectType == DateSelectType.selected) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${tdate.date.day}',
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            const Text('文案文案',
                                style: TextStyle(
                                    fontSize: 6, color: Colors.white)),
                            const Text('自定义',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white)),
                          ],
                        );
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${tdate.date.day}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          const Text('文案文案', style: TextStyle(fontSize: 8)),
                          const Text('自定义', style: TextStyle(fontSize: 8)),
                        ],
                      );
                    }),
              );
            },
          ),
        ],
      );
    },
  );
}
