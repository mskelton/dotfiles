---@diagnostic disable: undefined-global

local stateless_widget = [[
import 'package:flutter/material.dart';

class $1 extends StatelessWidget {
  const $1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container($0);
  }
}
]]

local stateful_widget = [[
import 'package:flutter/material.dart';

class $1 extends StatefulWidget {
  const $1({Key? key}) : super(key: key);

  @override
  State<$1> createState() => _${1}State();
}

class _${1}State extends State<$1> {
  @override
  Widget build(BuildContext context) {
    return Container($0);
  }
}
]]

return {
	parse("cl", "print($0);"),
	parse("sl", stateless_widget),
	parse("sf", stateful_widget),
}
