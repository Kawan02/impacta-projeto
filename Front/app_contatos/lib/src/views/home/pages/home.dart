import 'package:app_contatos/src/services/components/custom_text_form_field.dart';
import 'package:app_contatos/src/services/load.dart';
import 'package:app_contatos/src/views/home/controllers/contatos_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final controller = Get.put(ContatosController());
  final textController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  Future<void> consultar() async {
    // FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      return;
    }

    // return;
  }

  ImageProvider<Object> imagem(String? imagem) {
    if (imagem == null || imagem.isEmpty) {
      return const AssetImage("assets/imgs/foto.png");
    }
    return const AssetImage("assets/imgs/foto.png");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Form(
                        key: _formKey,
                        child: CustomTextField(
                          controller: textController,
                          // inputFormatters: [cepFormatter],
                          validator: (controller) {
                            if (controller == null || controller.isEmpty) {
                              return "Esse campo é obrigatorio";
                            }

                            return null;
                          },
                          prefixIcon: const Icon(Icons.person),
                          labelText: "Pesquise por nome",
                          hintText: "Digite um nome aqui...",
                          suffixIcon: IconButton(
                            padding: const EdgeInsets.only(right: 5),
                            onPressed: () async {
                              await consultar();
                            },
                            icon: const Icon(
                              Icons.search,
                              color: Colors.white,
                              size: 25,
                              semanticLabel: "Pesquisar",
                            ),
                          ),
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GetX<ContatosController>(
              init: Get.find<ContatosController>(),
              initState: (state) async {
                await state.controller!.fetchUsers();
              },
              builder: (controller) {
                if (controller.isLoading.value) return const Load();

                return Expanded(
                  child: ListView.builder(
                    itemCount: controller.contatos.length,
                    itemBuilder: (context, index) {
                      final contatos = controller.contatos[index];

                      return ListTile(
                        title: Text(
                          "${contatos.nome!} ${contatos.sobrenome!}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: imagem(contatos.image!),
                              ),
                            ),
                          ),
                        ),
                        subtitle: Text(
                          contatos.telephone!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        trailing: IconButton(
                          onPressed: () async {
                            // Botão de editar
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
        floatingActionButton: GetBuilder<ContatosController>(
          builder: (controller) {
            return FloatingActionButton(
              hoverColor: Colors.blue[800],
              backgroundColor: Colors.blue[800],
              splashColor: Colors.blue[800],
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              onPressed: () {
                // Botão de adicionar contatos
                controller.fetchUsers();
              },
              tooltip: 'Adicionar contatos',
              child: const Icon(
                Icons.person_add_rounded,
                color: Colors.white,
              ),
            );
          },
        ));
  }
}
