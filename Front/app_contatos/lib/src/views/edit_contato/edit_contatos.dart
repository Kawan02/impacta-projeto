import 'package:app_contatos/src/services/components/custom_text_form_field.dart';
import 'package:app_contatos/src/views/edit_contato/controllers/edit_contato_controller.dart';
import 'package:app_contatos/src/views/home/models/contatos_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class EditContatosPage extends StatelessWidget {
  final ContatosModel model;
  const EditContatosPage({
    super.key,
    required this.model,
  });

  ImageProvider<Object> imagem(String? imagem) {
    if (imagem == null || imagem.isEmpty) {
      return const AssetImage("assets/imgs/foto.png");
    }
    return const AssetImage("assets/imgs/foto.png");
  }

  // final ValueNotifier dropValue = ValueNotifier("");
  // String selectedItem = "";

  static List<String> favoritosOpcoes = ["Sim", "Não"];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Atualizar Contato",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[800],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 15, bottom: 20),
                width: size.width * 0.5,
                height: size.height * 0.3,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: imagem(model.image),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: FloatingActionButton.small(
                      backgroundColor: Colors.blue[800],
                      tooltip: "Adicionar foto",
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(Icons.photo_library_rounded),
                      onPressed: () {},
                    ),
                  ),
                  FloatingActionButton.small(
                    backgroundColor: Colors.red[800],
                    tooltip: "Remover foto",
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(Icons.delete),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              // padding: const EdgeInsets.only(bottom: 20),
              children: [
                // Foto de perfil

                // SizedBox(
                //   width: size.width * 0.5,
                //   height: size.height * 0.5,
                //   child: CircleAvatar(
                //     backgroundColor: Colors.transparent,
                //     child: Container(
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(15),
                //         image: DecorationImage(
                //           // alignment: Alignment.center,
                //           // fit: BoxFit.cover,
                //           image: imagem(model.image!),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // Nome
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
                  child: CustomTextField(
                    initialValue: model.nome,
                    keyboardType: TextInputType.text,
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
                  padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                  child: CustomTextField(
                    initialValue: model.sobrenome,
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
                // Telefone
                Padding(
                  padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                  child: CustomTextField(
                    initialValue: model.telephone,
                    keyboardType: TextInputType.number,
                    validator: (controller) {
                      if (controller == null || controller.isEmpty) {
                        return "O telefone é obrigatorio";
                      }

                      return null;
                    },
                    prefixIcon: const Icon(Icons.person),
                    labelText: "Telefone",
                    hintText: "Digite um telefone",
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),

                // DropDown de Favoritos
                GetX<EditContatoController>(
                  init: Get.find<EditContatoController>(),
                  builder: (controller) {
                    return DropdownButton<String>(
                      padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                      iconSize: 40,
                      borderRadius: BorderRadius.circular(18),
                      icon: const Icon(Icons.arrow_drop_down),
                      // elevation: 0,
                      isExpanded: true,
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
                      // onChanged: (escolha) {
                      //   setState(() {
                      //     selectedItem = escolha!;
                      //   });
                      // },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
