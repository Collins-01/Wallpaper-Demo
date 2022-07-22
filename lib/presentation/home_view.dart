import 'package:flutter/material.dart';
import 'package:wallpaper_demo/presentation/loader_view.dart';
import 'package:wallpaper_demo/services/wallpaper_service.dart';
import '../extensions/extensions.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final _wallpaperService = WallPaperService();
  Stream<String>? _progressStream;
  String progress = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return LoaderView(
      progress: progress,
      isLoading: isLoading,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: IconButton(
                  onPressed: () {
                    controller.clear();
                  },
                  icon: const Icon(Icons.clear),
                ),
              ),
              Center(
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Please paste your url here!!";
                        }
                        final url = Uri.tryParse(val);
                        if (url == null) {
                          return "Please past a valid image url";
                        }
                        // if (!val.endsWith(".jpeg") ||
                        //     !val.endsWith(".png") ||
                        //     !val.endsWith(".jpg")) {
                        //   return "Pasted url is not an image url";
                        // }
                        return null;
                      },
                      controller: controller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.download),
          onPressed: () async {
            //validates form fields
            if (formKey.currentState!.validate()) {
              //download
              _setLoading(true);
              _progressStream =
                  _wallpaperService.downloadImage(controller.text);
              _progressStream?.listen((e) {
                print("Progress: $e");
                setState(() {
                  progress = e;
                });
              }, onDone: () async {
                _setLoading(false);
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text("Image Downloaded!!"),
                    ),
                  );
                await _wallpaperService.setWallPaper(
                  height: context.deviceHeight,
                  width: context.deviceWith,
                );
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text("Wallpaper Successfully Updated!!"),
                    ),
                  );
              }, onError: (e) {
                _setLoading(false);
              });
            }
            return;
          },
        ),
      ),
    );
  }

  _setLoading(bool v) {
    setState(() {
      isLoading = v;
    });
  }
}
