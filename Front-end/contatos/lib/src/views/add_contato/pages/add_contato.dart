import 'dart:convert';
import 'package:contatos/src/services/components/custom_text_form_field.dart';
import 'package:contatos/src/services/load.dart';
import 'package:contatos/src/views/add_contato/controllers/add_contato_controller.dart';
import 'package:contatos/src/views/home/models/contatos_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:intl/intl.dart' as date;

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
    if (imagem!.isEmpty || imagem == "imageDefault") {
      return const AssetImage("assets/imgs/foto.png");
    }

    return MemoryImage(base64Decode(imagem));
  }

  Future<void> criarContato(AddContatoController controller) async {
    ContatosModel model = ContatosModel(
      nome: controllerNome.text,
      favorito: controller.star(),
      image: controller.image.value.isEmpty ? "imageDefault" : controller.image.value,
      sobrenome: controllerSobrenome.text,
      telephone: controllerTelefone.text,
      dtaNascimento: controllerDtaNascimento.text,
      nota: controllerNotas.text,
      createdAt: date.DateFormat('yyyy-MM-dd:HH:mm:ss').format(DateTime.now()),
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
                                onPressed: () => controller.image.value = "imageDefault",
                                child: const Icon(Icons.delete),
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
                      textInputAction: TextInputAction.next,
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
                      textInputAction: TextInputAction.next,
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
                      textInputAction: TextInputAction.next,
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
                      controller: controllerTelefone,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
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

                  // Notas
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                    child: CustomTextField(
                      controller: controllerNotas,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
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
