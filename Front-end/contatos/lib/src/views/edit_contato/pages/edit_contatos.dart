import 'dart:convert';
import 'package:contatos/src/services/components/custom_text_form_field.dart';
import 'package:contatos/src/services/load.dart';
import 'package:contatos/src/views/edit_contato/controllers/edit_contato_controller.dart';
import 'package:contatos/src/views/home/models/contatos_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:intl/intl.dart' as date;

// ignore: must_be_immutable
class EditContatosPage extends StatelessWidget {
  final ContatosModel model;
  EditContatosPage({
    super.key,
    required this.model,
  });

  TextEditingController controllerNome = TextEditingController();
  TextEditingController controllerSobrenome = TextEditingController();
  TextEditingController controllerDtaNascimento = TextEditingController();
  TextEditingController controllerTelefone = TextEditingController();
  TextEditingController controllerNotas = TextEditingController();
  final List<String> favoritosOpcoes = ["Sim", "Não"];
  final celularFormatter = MaskTextInputFormatter(mask: "(##) #####-####", filter: {"#": RegExp(r"[0-9]")});
  final dataFormatter = MaskTextInputFormatter(mask: "##/##/####", filter: {"#": RegExp(r"[0-9]")});
  final GlobalKey<FormState> _formKey = GlobalKey();

  ImageProvider<Object> imagem(String? imagem, String? imagemSelecionada) {
    if ((imagemSelecionada!.isEmpty && imagem == "imageDefault") || imagemSelecionada == "imageDefault") {
      return const AssetImage("assets/imgs/foto.png");
    }

    if (imagemSelecionada.isNotEmpty) {
      return MemoryImage(base64Decode(imagemSelecionada));
    }

    return MemoryImage(base64Decode(imagem!));
  }

  Future<void> atualizarContato(EditContatoController controller) async {
    final editModel = ContatosModel(
      nome: controllerNome.text,
      favorito: controller.favorito.value,
      image: controller.image.value.isEmpty ? model.image! : controller.image.value,
      sobrenome: controllerSobrenome.text,
      telephone: controllerTelefone.text,
      amigo: controller.selectedItem.value.isEmpty ? model.amigo : controller.selectedItem.value,
      dtaNascimento: controllerDtaNascimento.text,
      nota: controllerNotas.text,
      updateAt: date.DateFormat('yyyy-MM-dd:HH:mm:ss').format(DateTime.now()),
    );

    if (_formKey.currentState!.validate()) {
      await controller.putContato(model.id!, editModel);
    }
  }

  Object tagImg(String? image) {
    if (image == null || image.isEmpty) {
      return "imgDefault";
    }
    return image;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Atualizar Contato",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey[800],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                children: [
                  // Foto de perfil
                  Column(
                    children: [
                      Hero(
                        tag: tagImg(model.image),
                        child: Container(
                          padding: const EdgeInsets.only(top: 15, bottom: 20),
                          width: size.width * 0.5,
                          height: size.height * 0.3,
                          child: GetX<EditContatoController>(
                            builder: (controller) {
                              if (controller.isLoading.value) return const Load();

                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    alignment: Alignment.center,
                                    image: imagem(model.image, controller.image.value),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Ir na galeria
                          GetBuilder<EditContatoController>(
                            init: Get.find<EditContatoController>(),
                            builder: (controller) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: FloatingActionButton.small(
                                  heroTag: "btnAddFoto",
                                  backgroundColor: Colors.blue[800],
                                  tooltip: "Adicionar foto",
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Icon(Icons.photo_library_rounded),
                                  onPressed: () async => await controller.getImagem(),
                                ),
                              );
                            },
                          ),
                          // Remover foto
                          GetBuilder<EditContatoController>(
                            init: Get.find<EditContatoController>(),
                            builder: (controller) {
                              return FloatingActionButton.small(
                                heroTag: "btnRemoveFoto",
                                backgroundColor: Colors.red.shade600,
                                tooltip: "Remover foto",
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Icon(Icons.delete),
                                onPressed: () => controller.image.value = "imageDefault",
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Nome
                  Padding(
                    padding: const EdgeInsets.only(top: 40, bottom: 30, left: 10, right: 10),
                    child: CustomTextField(
                      // initialValue: model.nome,
                      controller: controllerNome = TextEditingController(text: model.nome),
                      keyboardType: TextInputType.text,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (controller) {
                        if (controller == null || controller.isEmpty) {
                          return "O nome é obrigátorio";
                        }

                        return null;
                      },
                      prefixIcon: const Icon(Icons.person),
                      labelText: "Nome",
                      hintText: "Digite um nome aqui",
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                  // Sobrenome
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25, left: 10, right: 10),
                    child: CustomTextField(
                      controller: controllerSobrenome = TextEditingController(text: model.sobrenome),
                      keyboardType: TextInputType.text,
                      prefixIcon: const Icon(Icons.person),
                      labelText: "Sobrenome",
                      hintText: "Digite seu sobrenome",
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),

                  // Data de nascimento
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25, left: 10, right: 10),
                    child: CustomTextField(
                      controller: controllerDtaNascimento = TextEditingController(text: model.dtaNascimento),
                      keyboardType: TextInputType.text,
                      inputFormatters: [dataFormatter],
                      prefixIcon: const Icon(Icons.calendar_month),
                      labelText: "Data",
                      hintText: "Digite a data de nascimento",
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                  // Telefone
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25, left: 10, right: 10),
                    child: CustomTextField(
                      controller: controllerTelefone = TextEditingController(text: model.telephone),
                      keyboardType: TextInputType.number,
                      inputFormatters: [celularFormatter],
                      validator: (controller) {
                        if (controller == null || controller.isEmpty) {
                          return "O telefone é obrigátorio";
                        }

                        return null;
                      },
                      prefixIcon: const Icon(Icons.phone),
                      labelText: "Telefone",
                      hintText: "Digite um telefone",
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),

                  // DropDown de Favoritos
                  GetBuilder<EditContatoController>(
                    init: Get.find<EditContatoController>(),
                    builder: (controller) {
                      return DropdownButtonFormField<String>(
                        padding: const EdgeInsets.only(bottom: 25, left: 10, right: 10),
                        isExpanded: true,
                        elevation: 0,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        borderRadius: BorderRadius.circular(18),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                        iconSize: 40,
                        icon: const Icon(Icons.arrow_drop_down),
                        itemHeight: 50,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Selecione um item da lista";
                          }
                          return null;
                        },
                        iconEnabledColor: Colors.blue[800],
                        // hint: Visibility(
                        //   visible: model.amigo!.isEmpty,
                        //   replacement: Text(
                        //     model.amigo!,
                        //     style: const TextStyle(color: Colors.white),
                        //   ),
                        //   child: const Text("Adicionar a listas de favoritos"),
                        // ),
                        hint: const Text("Adicionar a listas de favoritos"),
                        value: controller.selectedItem.value.isEmpty ? model.amigo : controller.selectedItem.value,
                        items: favoritosOpcoes.map(
                          (opcao) {
                            return DropdownMenuItem<String>(
                              value: opcao,
                              child: Text(opcao),
                            );
                          },
                        ).toList(),
                        onChanged: (value) => controller.escolha(value),
                      );
                    },
                  ),
                  // Notas
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                    child: CustomTextField(
                      controller: controllerNotas = TextEditingController(text: model.nota),
                      keyboardType: TextInputType.text,
                      labelText: "Nota",
                      hintText: "Digite uma nota para esse contato",
                      minLines: 5,
                      maxLines: 10,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      scrollPhysics: const BouncingScrollPhysics(),
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
                    child: GetX<EditContatoController>(
                      init: Get.find<EditContatoController>(),
                      builder: (controller) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 45,
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: controller.isLoading.value ? Colors.grey : Colors.blue[800],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                                onPressed: () async => await atualizarContato(controller),
                                icon: Visibility(
                                  visible: !controller.isLoading.value,
                                  child: const Icon(Icons.done),
                                ),
                                label: controller.isLoading.value
                                    ? const Load()
                                    : const Text(
                                        "Atualizar contato",
                                        style: TextStyle(color: Colors.white),
                                      ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                              height: 40,
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red.shade600,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                                onPressed: () async {},
                                icon: const Icon(Icons.delete),
                                label: const Text(
                                  "Excluir contato",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
