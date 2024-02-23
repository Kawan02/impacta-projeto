import 'dart:convert';
import 'package:app_contatos/src/services/components/custom_text_form_field.dart';
import 'package:app_contatos/src/services/load.dart';
import 'package:app_contatos/src/views/add_contato/controllers/add_contato_controller.dart';
import 'package:app_contatos/src/views/home/models/contatos_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AddContatosPage extends StatelessWidget {
  AddContatosPage({super.key});

  final List<String> favoritosOpcoes = ["Sim", "Não"];
  final TextEditingController controllerNome = TextEditingController();
  final TextEditingController controllerSobrenome = TextEditingController();
  final TextEditingController controllerTelefone = TextEditingController();
  final TextEditingController controllerDtaNascimento = TextEditingController();
  final TextEditingController controllerNotas = TextEditingController();
  final celularFormatter = MaskTextInputFormatter(mask: "(##) #####-####", filter: {"#": RegExp(r"[0-9]")});
  final dataFormatter = MaskTextInputFormatter(mask: "##/##/####", filter: {"#": RegExp(r"[0-9]")});
  final controller = Get.find<AddContatoController>();

  final GlobalKey<FormState> _formKey = GlobalKey();

  ImageProvider<Object> imagem(String? imagem) {
    if (imagem == null || imagem.isEmpty) {
      return const AssetImage("assets/imgs/foto.png");
    }

    return MemoryImage(base64Decode(imagem));
  }

  Future<void> criarContato(AddContatoController controller) async {
    ContatosModel model = ContatosModel(
      nome: controllerNome.text,
      favorito: controller.favorito.value,
      image: controller.image.value,
      sobrenome: controllerSobrenome.text,
      telephone: controllerTelefone.text,
      amigo: controller.selectedItem.value,
      dtaNascimento: controllerDtaNascimento.text,
      nota: controllerNotas.text,
    );

    if (_formKey.currentState!.validate()) {
      await controller.createContato(model);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cadastrar Contato",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
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
                shrinkWrap: true,
                children: [
                  // Foto de perfil
                  Column(
                    children: [
                      Container(
                          padding: const EdgeInsets.only(top: 15, bottom: 20),
                          width: size.width * 0.5,
                          height: size.height * 0.3,
                          child: GetX<AddContatoController>(
                            builder: (controller) {
                              if (controller.isLoading.value) return const Load();

                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    alignment: Alignment.center,
                                    image: imagem(controller.image.value),
                                  ),
                                ),
                              );
                            },
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Ir na galeria
                          GetBuilder<AddContatoController>(
                            init: Get.find<AddContatoController>(),
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
                          GetBuilder<AddContatoController>(
                            init: Get.find<AddContatoController>(),
                            builder: (controller) {
                              return FloatingActionButton.small(
                                heroTag: "btnRemoveFoto",
                                backgroundColor: Colors.red.shade600,
                                tooltip: "Remover foto",
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Icon(Icons.delete),
                                onPressed: () => controller.image.value = "",
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
                      controller: controllerNome,
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
                      controller: controllerSobrenome,
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
                      controller: controllerDtaNascimento,
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

                  // GetX<AddContatoController>(
                  //   init: Get.find<AddContatoController>(),
                  //   builder: (controller) {
                  //     return GestureDetector(
                  //       child: Icon(
                  //         Icons.star,
                  //         color: !controller.favorito.value ? Colors.white : Colors.yellow,
                  //       ),
                  //       onTap: () => controller.favoritos(),
                  //     );
                  //   },
                  // ),

                  // Telefone
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25, left: 10, right: 10),
                    child: CustomTextField(
                      controller: controllerTelefone,
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
                  GetX<AddContatoController>(
                    init: Get.find<AddContatoController>(),
                    builder: (controller) {
                      return DropdownButtonFormField<String>(
                        isExpanded: true,
                        padding: const EdgeInsets.only(bottom: 25, left: 10, right: 10),
                        elevation: 0,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        hint: const Text("Adicionar a listas de favoritos"),
                        value: controller.selectedItem.value.isEmpty ? null : controller.selectedItem.value,
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
                      controller: controllerNotas,
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
                    child: Obx(() {
                      return SizedBox(
                        height: 45,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: controller.isLoading.value ? Colors.grey : Colors.blue[800],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          onPressed: controller.isLoading.value ? null : () async => await criarContato(controller),
                          icon: Visibility(
                            visible: !controller.isLoading.value,
                            child: const Icon(Icons.done),
                          ),
                          label: controller.isLoading.value
                              ? const Load()
                              : const Text(
                                  "Criar contato",
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      );
                    }),
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
