import 'package:path/path.dart' as p;

String vsCodeTaskPath(String projectPath) {
  return p.join(projectPath, '.vscode', 'tasks.json');
}

String vsCodeSettingsPath(String projectPath) {
  return p.join(projectPath, '.vscode', 'settings.json');
}

final vsCodeTaskContent = '''
{
    // See https://go.microsoft.com/fwlink/?LinkId=733558
    // for the documentation about the tasks.json format
    "version": "2.0.0",
    "tasks": [
        {
            "label": "sidecar init",
            "type": "shell",
            "command": "sidecar",
            "group": "test",
            "presentation": {
                "reveal": "always",
                "panel": "new"
            },
        }
    ]
}
''';

final vsCodeSettingsContent = '''
{
    "triggerTaskOnSave.tasks": {
        "sidecar init": [
            "pubspec.yaml",
            "analysis_options.yaml",
        ],
    },
}
''';
