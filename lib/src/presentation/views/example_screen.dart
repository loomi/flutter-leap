import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loomi_flutter_boilerplate/src/presentation/widgets/custom_button.dart';
import 'package:loomi_flutter_boilerplate/src/presentation/widgets/search_bar_component.dart';
import 'package:loomi_flutter_boilerplate/src/utils/app_state.dart';
import 'package:loomi_flutter_boilerplate/src/utils/custom_colors.dart';
import 'package:loomi_flutter_boilerplate/src/utils/helpers/custom_error_helper.dart';
import 'package:loomi_flutter_boilerplate/src/utils/helpers/image_picker_helper.dart';
import 'package:loomi_flutter_boilerplate/src/utils/helpers/scroll_listener_helper.dart';
import 'package:loomi_flutter_boilerplate/src/utils/helpers/select_pictures_sheet_helper.dart';
import 'package:loomi_flutter_boilerplate/src/utils/helpers/show_confirmation_dialog_helper.dart';

import '../stores/example_store.dart';

class ExampleScreen extends StatefulWidget {
  const ExampleScreen({Key? key}) : super(key: key);

  static const routeName = "example_screen";

  @override
  _ExampleScreenState createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  final exampleStore = GetIt.I.get<ExampleStore>();

  final ScrollController controller = ScrollController();

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
        return Scaffold(
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
                          textColor: CustomColors.white,
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
