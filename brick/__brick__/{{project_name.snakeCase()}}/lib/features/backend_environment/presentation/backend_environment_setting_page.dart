import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{project_name.snakeCase()}}/constant/app_sizes.dart';
import 'package:{{project_name.snakeCase()}}/constant/theme/theme.dart';
import 'package:{{project_name.snakeCase()}}/features/backend_environment/application/host_controller.dart';
import 'package:{{project_name.snakeCase()}}/features/backend_environment/domain/backend_env.dart';
import 'package:{{project_name.snakeCase()}}/l10n/l10n.dart';
import 'package:{{project_name.snakeCase()}}/routing/app_router.dart';
import 'package:{{project_name.snakeCase()}}/utils/validators/local_host_validator_mixin.dart';

class BackendEnvironmentSettingPage extends ConsumerStatefulWidget {
  const BackendEnvironmentSettingPage({super.key});
  // * Keys for testing using find.byKey()
  static const appBarKey = Key('appBar');
  static const localHostRadioKey = Key('localHostRadio');
  static const localHostTextFieldKey = Key('localHostTextField');
  static const saveKey = Key('save');
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BackendEnvironmentSettingPageState();
}

class _BackendEnvironmentSettingPageState
    extends ConsumerState<BackendEnvironmentSettingPage>
    with LocalHostValidatorMixin {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController localHostTextEditingController;
  final indexOfLocalHost = BackendEnv.values.length + 1;
  var hostIndex = 0;
  var enableLocalHost = false;

  // local variable used to apply AutovalidateMode.onUserInteraction and show
  // error hints only when the form has been submitted
  var _submitted = false;

  @override
  void initState() {
    super.initState();
    final hostController = ref.read(hostControllerProvider);
    localHostTextEditingController =
        TextEditingController(text: hostController.localHost);
    hostIndex = hostController.backendEnv?.index ?? indexOfLocalHost;
    enableLocalHost = hostController.isLocal;
  }

  @override
  void dispose() {
    localHostTextEditingController.dispose();
    super.dispose();
  }

  void onRadioValueChanged(int? index) {
    if (index != null) {
      setState(() {
        hostIndex = index;
        enableLocalHost = index == indexOfLocalHost;
      });
    }
  }

  void _save() async {
    setState(() => _submitted = true);
    _formKey.currentState?.validate();
    if (enableLocalHost &&
        !canSubmitLocalHost(localHostTextEditingController.text)) {
      return;
    }
    var hostKey = enableLocalHost
        ? localHostTextEditingController.text
        : BackendEnv.values.firstWhere((env) => env.index == hostIndex).hostKey;
    await ref.read(hostControllerProvider.notifier).update(hostKey: hostKey);
    return ref.read(appRouterProvider).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final envLabel = [
      l10n.backendEnvRelease,
      l10n.backendEnvDemo,
      l10n.backendEnvDevelop
    ];
    final colorScheme = context.colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        key: BackendEnvironmentSettingPage.appBarKey,
        title: Text(l10n.backendEnvAppBarTitle),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 600,
            child: Padding(
              padding: const EdgeInsets.all(Sizes.p16),
              child: Card(
                color: colorScheme.surface,
                child: Padding(
                  padding: const EdgeInsets.all(Sizes.p16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ...BackendEnv.values.map<Widget>(
                        (env) => Row(
                          children: [
                            Radio<int>(
                              key: Key(env.name),
                              activeColor: colorScheme.primary,
                              value: env.index,
                              groupValue: hostIndex,
                              onChanged: onRadioValueChanged,
                            ),
                            GestureDetector(
                              child: Text(
                                envLabel[env.index],
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              onTap: () => onRadioValueChanged(env.index),
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Radio<int>(
                            key:
                                BackendEnvironmentSettingPage.localHostRadioKey,
                            activeColor: colorScheme.primary,
                            value: indexOfLocalHost,
                            groupValue: hostIndex,
                            onChanged: onRadioValueChanged,
                          ),
                          GestureDetector(
                            child: Text(
                              l10n.backendEnvLocal,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            onTap: () => onRadioValueChanged(indexOfLocalHost),
                          )
                        ],
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: Sizes.p8),
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            key: BackendEnvironmentSettingPage
                                .localHostTextFieldKey,
                            enabled: enableLocalHost,
                            controller: localHostTextEditingController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (localHost) =>
                                !_submitted && !enableLocalHost
                                    ? null
                                    : localHostErrorText(localHost ?? '', l10n),
                            decoration: InputDecoration(
                              hintText:
                                  enableLocalHost ? '192.168.0.1:8000' : '',
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: Colors.grey.shade500),
                              helperText: l10n.backendEnvLocalDescription,
                              helperMaxLines: 5,
                              enabled: enableLocalHost,
                            ),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ),
                      gapH16,
                      SizedBox(
                        height: Sizes.p48,
                        child: ElevatedButton(
                          key: BackendEnvironmentSettingPage.saveKey,
                          onPressed: _save,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorScheme.secondaryContainer,
                            foregroundColor: colorScheme.onSecondaryContainer,
                          ),
                          child: Text(
                            l10n.save,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline6!,
                          ),
                        ),
                      ),
                      gapH8,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
