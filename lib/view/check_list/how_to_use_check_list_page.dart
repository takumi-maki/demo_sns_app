import 'package:flutter/material.dart';

import '../../utils/widget_utils.dart';

class HowToUseCheckList extends StatefulWidget {
  const HowToUseCheckList({Key? key}) : super(key: key);

  @override
  State<HowToUseCheckList> createState() => _HowToUseCheckListState();
}

class _HowToUseCheckListState extends State<HowToUseCheckList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUtils.createAppBar('成長のチェックリストについて'),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [

              Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Image.asset('assets/images/hiyoko_pen_skeleton.png', height: 100)
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                child: const Text(
                  '　成長のチェックリストは、わが子の成長の段階と、次のステップを知るために使います。月齢は目安です。'
                  '早ければ良いというわけではありません。',
                )
              ),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
                  child: const Divider(color: Colors.black54)
              ),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                  child: Row(
                    children: [
                      Icon(Icons.bookmark, color: Theme.of(context).colorScheme.secondary),
                      const SizedBox(width: 8.0),
                      Flexible(
                        child: Text('成長のチェックリストの使い方',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              decorationColor: Theme.of(context).colorScheme.secondary,
                              decorationThickness: 2.4
                            )),
                      ),
                    ],
                  )
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                child: RichText(
                    text: const TextSpan(
                      style: TextStyle(color: Colors.black87),
                      children: [
                        TextSpan(text:'　まず、成長のチェックリストで、'
                          'わが子の月齢がどのような段階にあるのかを確認しましょう。チェックリストは',
                        ),
                        TextSpan(
                          text: '「体の大きな動き(からだ)」 「手の動き(手のうごき)」 '
                              '「ことばの成長と理解(ことば)」 「生活習慣(せいかつ)」 ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: 'の、4つのジャンルにわかれています。'),
                      ]
                    )
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                child: const Text(
                  '　たとえば、わが子が生後5ヶ月だったとしましょう。チェックリストの5ヶ月を横に見ていきます。'
                  '「そろそろ、寝返りを打つころで、自分の手を見るようになり、話している人の目を見るようになり、'
                  '鏡に映るものに興味をしめすらしい」と、わが子の今の段階が見えてきます。',
                )
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
                child: const Divider(color: Colors.black54)
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                child: Row(
                  children: [
                    Icon(Icons.bookmark, color: Theme.of(context).colorScheme.secondary),
                    const SizedBox(width: 8.0),
                    Flexible(
                      child: Text('子どもの成長は早ければ良いというものではない',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationColor: Theme.of(context).colorScheme.secondary,
                          decorationThickness: 2.4
                        )),
                    ),
                  ],
                )
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                child: const Text(
                  '　「うちの子8カ月なのに、もう、つかまり立ちしようとしているわ！なんて早いんでしょう！'
                  '歩行器に座らせたら歩くんじゃないかしら？」、これは誤りです。'
                  '「子どもの成長は早ければ良い！」という考えは捨てましょう。'
                )
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 6.0),
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Colors.black87),
                    children: [
                      TextSpan(text: '「次の段階へのステップは、その前の段階をいかに充実して経験してきたかにかかっている」',
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      TextSpan(text: 'これは、モンテッソーリの「スモールステップス」の考え方です。'),
                    ]
                  )
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                child: const Text(
                  '　ハイハイの期間が長くても、それには理由があるのです。今は、両手で床をしっかり押して、'
                  'お尻を上げて、ハイハイを一生懸命練習している最中なのです。'
                  'この段階が充実してこそ、次のつかまり立ちに移っていけるのです。大人が早くて歩いて欲しいからといって、'
                  '抱き上げて歩行器に入れれば、偶然、歩くかもしれませんが、「つかまり立ち → 伝い歩き → 一人立ち」という、'
                  '発達のステップを飛ばしてしまうことになります。その結果、仮に歩くことができるようになったとしても、'
                  '体幹が育たず、バランスもとれずに、その先のステップで必ず弊害が出てきてしまうのです。',
                )
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Colors.black87),
                    children: [
                      TextSpan(text: '　ですから、'),
                      TextSpan(
                        text: '成長のチェックリストは、わが子の今を見つめ、'
                          '今を充実して過ごしてあげられるように活用してください。',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]
                  )
                ),
              ),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                  child: const Text(
                    '　その上で、次の成長段階に目を向けます。時が来れば、子どもは自分の判断で、'
                    '次のステップへと進みます。それは大人が強制できるものではありません。大人にできるのは、'
                    '「子どもが一人でできるようにお手伝いすること」だけなのです。',
                  )
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                child: const Text(
                  '　今、ハイハイを一生懸命していたら、次のつかまり立ちに移行しやすいように、'
                  '適切な高さで安定性の良い棚などを、そっと置いておいてあげる。これが環境を整えるということなのです。'
                  'このようにチェックリストは次の成長のステップを知るために活用してください。',
                  style: TextStyle(),
                )
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 50.0),
                child: const Text(
                  '( 出典: 藤崎達宏、'
                  '『０～３歳までの実践版 モンテッソーリ教育で才能をぐんぐん伸ばす！』、'
                  '三笠書房、 2018、p.246、(ISBN: 9784837927525) )',
                  style: TextStyle(color: Colors.black54),
                )
              ),
            ]
          ),
        ),
      ),
    );
  }
}
