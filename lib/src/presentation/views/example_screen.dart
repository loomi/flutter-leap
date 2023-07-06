import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loomi_flutter_boilerplate/src/presentation/widgets/custom_button.dart';
import 'package:loomi_flutter_boilerplate/src/presentation/widgets/custom_network_image.dart';

import 'package:loomi_flutter_boilerplate/src/presentation/widgets/search_bar_component.dart';
import 'package:loomi_flutter_boilerplate/src/utils/app_state.dart';
import 'package:loomi_flutter_boilerplate/src/utils/custom_colors.dart';
import 'package:loomi_flutter_boilerplate/src/utils/helpers/custom_error_helper.dart';
import 'package:loomi_flutter_boilerplate/src/utils/helpers/image_picker_helper.dart';
import 'package:loomi_flutter_boilerplate/src/utils/helpers/scroll_listener_helper.dart';
import 'package:loomi_flutter_boilerplate/src/utils/helpers/select_pictures_sheet_helper.dart';
import 'package:loomi_flutter_boilerplate/src/utils/helpers/show_confirmation_dialog_helper.dart';
import 'package:loomi_ui_flutter/loomi_ui.dart';

import '../stores/example_store.dart';

class ExampleScreen extends StatefulWidget {
  const ExampleScreen({Key? key}) : super(key: key);

  static const routeName = "example_screen";

  @override
  _ExampleScreenState createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  final exampleStore = GetIt.I.get<ExampleStore>();
  String? dropDownValue;
  bool check = false;
  final ScrollController controller = ScrollController();
  int counter = 0;
  bool selector = false;
  @override
  void initState() {
    exampleStore.getPaginatedData();
    listenToScrollController(
      scrollController: controller,
      onLoad: () async {
        await exampleStore.getPaginatedData(
          page: exampleStore.lastLoadedPage += 1,
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Example title"),
            ),
            body: exampleStore.appState == AppState.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    controller: controller,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CustomNetworkImage(
                            imageUrl:
                                "https://images.unsplash.com/photo-1661956600684-97d3a4320e45",
                            height: 300,
                            width: 300,
                            errorText: "Não foi possível carregar a imagem",
                            borderRadius: 30,
                            backgroundColor: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomButton(
                            backgroundColor: CustomColors.black,
                            expanded: true,
                            onTap: () {
                              openSelectPictureSheet(
                                context,
                                getImageCamera: () {
                                  getImageHelper(
                                    source: ImageSource.camera,
                                  );
                                },
                                getImageGallery: () {
                                  getImageHelper(
                                    source: ImageSource.gallery,
                                  );
                                },
                              );
                            },
                            text: "Pegar imagem",
                            buttonTextStyle:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: CustomColors.white,
                                    ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: LoomiTextFormField(
                            onChanged: (value) {
                              print(value);
                            },
                            height: 48,
                            keyboardType: TextInputType.number,
                            border: Border.all(
                              width: 1,
                              color: Colors.teal,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            placeholderText: "Texto",
                            placeholderStyle:
                                Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: CustomSelect(
                            value: dropDownValue,
                            onChanged: (value) {
                              setState(() {
                                dropDownValue = value;
                              });
                            },
                            list: ["RN", "SP", "RJ"]
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                    ),
                                  ),
                                )
                                .toList(),
                            border: Border.all(
                              width: 1,
                              color: Colors.teal,
                            ),
                            hintText: "Hint",
                            textStyle: Theme.of(context).textTheme.labelLarge,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: NumberCounter(
                            counter: counter,
                            border:
                                Border.all(color: CustomColors.grey, width: 2),
                            borderRadius: BorderRadius.circular(20),
                            subIconSize: const Size(25, 25),
                            addIconSize: const Size(25, 25),
                            addIconColor: CustomColors.grey.withOpacity(.5),
                            onChanged: (value) {
                              setState(() {
                                counter = value;
                              });
                            },
                            subIconColor: counter > 0
                                ? CustomColors.grey.withOpacity(.5)
                                : CustomColors.grey,
                            counterTextStyle: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  color: CustomColors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: GetIcon(CustomIcons.arrowBackOulined),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: RadioSelector(
                            leading: GetIcon(
                              CustomIcons.bellFilled,
                              color: selector
                                  ? CustomColors.white
                                  : Colors.teal.withOpacity(.5),
                            ),
                            selected: selector,
                            onTap: () {
                              setState(() {
                                selector = !selector;
                              });
                            },
                            text: "Label",
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8),
                          child: LoomiCustomLabel(
                            text: "Label",
                            height: 30,
                            backgroundColor: Colors.teal,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: CustomCheckbox(
                            check,
                            uncheckedBackgroundColor: Colors.white,
                            checkColor: Colors.teal,
                            uncheckedOuterBorder:
                                Border.all(color: Colors.teal, width: 3),
                            label: "Label",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(25),
                          child: SearchBarComponent(
                            hintText: "Pesquisar",
                            onChanged: (value) {
                              log("O valor só chegou agora: $value");
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomButton(
                            text: "showDialogHelper",
                            expanded: true,
                            onTap: () {
                              showConfirmationDialogHelper(
                                context: context,
                                confirmButtonText: "Confirmar",
                                title: "Aqui você insere o título",
                                body:
                                    "E aqui o contéudo todo e aqui o contéudo todo e aqui o contéudo todo e aqui o contéudo todo e aqui o contéudo todo",
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomButton(
                            text: "customErrorHelper",
                            expanded: true,
                            onTap: () {
                              customErrorHelper(context, e: Exception("erro"));
                            },
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: exampleStore.paginatedList.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, i) {
                            return PaginatedItem(
                              item: exampleStore.paginatedList[i],
                            );
                          },
                        ),
                        if (exampleStore.appState == AppState.loadingMore)
                          const Padding(
                            padding: EdgeInsets.all(10),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}

class PaginatedItem extends StatelessWidget {
  const PaginatedItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final String item;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      height: 100,
      width: 50,
      margin: const EdgeInsets.all(10),
      child: Center(
        child: Text(
          item,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
