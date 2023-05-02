
import 'package:dktweb/ads/adsense_view.dart';
import 'package:dktweb/bloc/dkt_bloc.dart';
import 'package:dktweb/bloc/model/cateory_model.dart';
import 'package:dktweb/bloc/model/models.dart';
import 'package:dktweb/widgets/DrivingPage.dart';
import 'package:dktweb/widgets/animation_widget.dart';
import 'package:dktweb/widgets/app_bar.dart';
import 'package:dktweb/widgets/button_menu.dart';
import 'package:dktweb/widgets/question_answer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class QuestionAnswerPage extends StatefulWidget {
  final String? id;
  final String? category;
  final String lastPath;

  const QuestionAnswerPage({
    Key? key,
    this.id,
    this.category,
    required this.lastPath,
  }) : super(key: key);

  @override
  State<QuestionAnswerPage> createState() => _QuestionAnswerPageState();
}

class _QuestionAnswerPageState extends State<QuestionAnswerPage> {
  @override
  void initState() {
    context.read<DktBloc>().add(LoadCategoryEvent(widget.category ?? ''));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DktBloc>().state;

    return DrivingPage(
      lastpath: widget.lastPath,
      appBar: appBarBackButton(
        context,
        widget.category ?? '',
        widget.lastPath,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.modelList?.length ?? 0,
                itemBuilder: (context, index) {
                  DktModel model = state.modelList![index];
                  return
                    FadeTransactionWidget(
                    child: ShowQuestionAnswer(
                      model: model,
                      practiseOrTest: false,
                      index: index,
                      isTest: false,
                      lastPath: widget.lastPath,
                      totalQuestion: state.modelList?.length ?? 0,
                    ),
                  );
                }),
          ),
          // if (!kIsWeb) const AdmobBannerAdWidget(),
          ButtonMenu(
            context: context,
            id: widget.id == null ? int.parse(widget.id ?? '0') : 0,
            category: widget.category ?? '',
            lastPath: GoRouterState.of(context).location,
            categoryModel: state.categorys ?? [],
          ),
        ],
      ),
    );
  }
}
