import 'package:flutter/material.dart';
import 'date_helper.dart';
import 'package:intl/intl.dart';

class DateWidget extends StatelessWidget {
  final defaultDateFormat = 'dd';
  final defaultMonthFormat = 'MMM';
  final defaultWeekDayFormat = 'EEE';

  final DateTime date;
  final TextStyle monthTextStyle;
  final TextStyle selectedMonthTextStyle;
  final String monthFormat;
  final TextStyle dateTextStyle;
  final TextStyle selectedDateTextStyle;
  final String dateFormat;
  final TextStyle weekDayTextStyle;
  final TextStyle selectedWeekDayTextStyle;
  final String weekDayFormat;
  final VoidCallback onTap;
  final VoidCallback onLongTap;
  final Decoration defaultDecoration;
  final Decoration selectedDecoration;
  final Decoration disabledDecoration;
  final bool isSelected;
  final bool isDisabled;
  final EdgeInsetsGeometry padding;
  final List<LabelType> labelOrder;
  final bool isLabelUppercase;

  const DateWidget({
    Key key,
    @required this.date,
    this.onTap,
    this.onLongTap,
    this.isSelected = false,
    this.isDisabled = false,
    this.monthTextStyle,
    this.selectedMonthTextStyle,
    this.monthFormat,
    this.dateTextStyle,
    this.selectedDateTextStyle,
    this.dateFormat,
    this.weekDayTextStyle,
    this.selectedWeekDayTextStyle,
    this.weekDayFormat,
    this.defaultDecoration,
    this.selectedDecoration = const BoxDecoration(color: Colors.cyan),
    this.disabledDecoration = const BoxDecoration(color: Colors.grey),
    this.padding,
    this.labelOrder,
    this.isLabelUppercase = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context, nullOk: true)?.languageCode;

    final titleStyle = Theme.of(context).textTheme.headline6;
    final subTitleStyle = Theme.of(context).textTheme.subtitle2;

    final monthStyle = isSelected
        ? selectedMonthTextStyle ?? monthTextStyle ?? subTitleStyle
        : monthTextStyle ?? subTitleStyle;
    final dateStyle = isSelected
        ? selectedDateTextStyle ?? dateTextStyle ?? titleStyle
        : dateTextStyle ?? titleStyle;
    final dayStyle = isSelected
        ? selectedWeekDayTextStyle ?? weekDayTextStyle ?? subTitleStyle
        : weekDayTextStyle ?? subTitleStyle;

    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      onLongPress: isDisabled ? null : onLongTap,
      child: Container(
        decoration: isSelected
            ? selectedDecoration
            : isDisabled ? disabledDecoration : defaultDecoration,
        child: Padding(
          padding: padding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ...labelOrder.map((type) {
                Text text;
                switch (type) {
                  case LabelType.month:
                    text = Text(
                      isLabelUppercase
                          ? _monthLabel(locale).toUpperCase()
                          : _monthLabel(locale),
                      style: monthStyle,
                    );
                    break;
                  case LabelType.date:
                    text = Text(
                      DateFormat(dateFormat ?? defaultDateFormat, locale)
                          .format(date),
                      style: dateStyle,
                    );
                    break;
                  case LabelType.weekday:
                    text = Text(
                      isLabelUppercase
                          ? _weekDayLabel(locale).toUpperCase()
                          : _weekDayLabel(locale),
                      style: dayStyle,
                    );
                    break;
                }
                return text;
              }).toList(growable: false)
            ],
          ),
        ),
      ),
    );
  }


  String _monthLabel(String locale) {
    return DateFormat(monthFormat ?? defaultMonthFormat, locale).format(date);
  }


  String _weekDayLabel(String locale) {
    return DateFormat(weekDayFormat ?? defaultWeekDayFormat, locale)
        .format(date);
  }
}
