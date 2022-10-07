import 'package:flutter/material.dart';
import 'package:todo/core/extencion/build_context_extencion.dart';
import 'package:todo/features/app/components/components.dart';
import 'package:todo/features/main_page/entities/task.dart';

class Body extends StatefulWidget {
  final List<Task> tasks;

  const Body({
    required this.tasks,
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.appColors.mainGrey,
      child: ListView.builder(
        itemCount: widget.tasks.length,
        itemBuilder: (BuildContext context, int index) {
          return AppCheckboxListTile(
            title: widget.tasks[index].title,
            description: widget.tasks[index].body,
            onChanged: (value) {
              setState(() {});
              widget.tasks[index] =
                  widget.tasks[index].copyWith(isCompleted: value!.toString());
            },
            checkboxListTileStyle: CheckboxListTileStyle(
              textStyle: widget.tasks[index].isCompleted == 'true'
                  ? context.appTextStyles.inter14LineThrough
                  : context.appTextStyles.inter14Reg,
            ),
            initialValue: widget.tasks[index].isCompleted == 'true',
          );
        },
      ),
    );
  }
}
