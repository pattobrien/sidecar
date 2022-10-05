import 'package:path/path.dart' as p;

String vsCodeTaskPath(String projectPath) {
  return p.join(projectPath, '.vscode', 'tasks.json');
}

String vsCodeSettingsPath(String projectPath) {
  return p.join(projectPath, '.vscode', 'settings.json');
}

const vsCodeTaskContent = '''
{
    // See https://go.microsoft.com/fwlink/?LinkId=733558
    // for the documentation about the tasks.json format
    "version": "2.0.0",
    "tasks": [
        {
            "label": "sidecar rebuild",
            "type": "shell",
            "command": "sidecar rebuild",
            "isBackground": true,
            "presentation": {
                "reveal": "silent",
                "panel": "dedicated"
            },
        }
    ]
}
''';

String vsCodeSettingsContent(String workspacePath) => '''
{
    "triggerTaskOnSave.tasks": {
        "sidecar rebuild": [
            // "pubspec.yaml",
            "analysis_options.yaml",
        ],
    },
    "dart.analyzerAdditionalArgs": [
        "--port=10000",
        "--instrumentation-log-file=$workspacePath/.sidecar/logs/analysis_instrumentation.log"
    ],
    // "dart.analyzerInstrumentationLogFile": "$workspacePath/.sidecar/logs/analysis_instrumentation.txt",
}
''';
