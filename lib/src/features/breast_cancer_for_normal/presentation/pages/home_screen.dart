import 'package:flutter/material.dart';

import '../widgets/awareness/awareness_title.dart';
import '../widgets/custom_texts.dart';
import '../widgets/go_to_screen_with_slide_transition.dart';
import 'starting_self_check_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isportrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final shapeHeight = screenSize.width * (isportrait ? 0.30 : 0.13);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        padding: EdgeInsets.symmetric(
          vertical: shapeHeight - 5,
          horizontal: 10,
        ),
        children: [
          const SizedBox(height: 30),
          const TextTitle(data: "Hello", fontSize: 24),
          const SizedBox(height: 30),
          const TextNormal(
            data:
                "You understand that every day counts when it comes to early breast cancer detection."
                " it's great that you take responsibility for your health and check your breasts regularly.",
            fontSize: 20,
          ),
          const SizedBox(height: 30),
          Align(
            child: ElevatedButton(
              onPressed: () => goToScreenWithSlideTransition(
                context,
                const StartingSelfCheckScreen(),
              ),
              style: const ButtonStyle(
                padding: MaterialStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 55)),
              ),
              child: const Text(
                "SELF-CHECK NOW",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Align(
            child: TextButton(
              onPressed: () {},
              child: const Text(
                "MY BREAST-CHECK HISTORY",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          const SizedBox(height: 50),
          const TextTitle(
            data:
                "Breast Cancer Awareness\nAnd\nWhy early detection is imprtant",
            fontSize: 22,
          ),
          const SizedBox(height: 30),
          for (int i = 0; i < _awarenessInfoes.length; i++)
            AwarenessTitle(_awarenessInfoes[i]),
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
////////////////// that data used for awareness information screen /////////////
////////////////////////////////////////////////////////////////////////////////

class AwarenessInfo {
  final String image;
  final String videoLink;
  final String title;
  final String description;

  const AwarenessInfo({
    required this.image,
    required this.videoLink,
    required this.title,
    required this.description,
  });
}

const List<AwarenessInfo> _awarenessInfoes = [
  AwarenessInfo(
    image: "assets/breast_cancer/awareness_1.jpeg",
    videoLink:
        "https://www.youtube.com/watch?v=Xpoxf4JRmeI&ab_channel=DearMamma-breastcancerawareness",
    title: "Dr. David Nabarro about The Awareness of Breast Cancer",
    description:
        "The reality is that early diagnosis and treatment of breast cancer does give us extraordinary results,"
        " and that too often the diagnosis is delayed and that leads unfortunately to an early death.",
  ),
  AwarenessInfo(
    image: "assets/breast_cancer/awareness_2.jpg",
    videoLink:
        "https://www.youtube.com/watch?v=KyeiZJrWrys&ab_channel=YouandBreastCancer",
    title: "Understanding Breast Cancer",
    description:
        "This animation explains what breast cancer is and how it develops."
        " You can learn about the signs and symptoms to watch for, and the factors that can increase the risk for getting breast cancer."
        " Breast cancer screening, diagnosis, and types of breast cancer are also explained."
        " You can also learn about the different ways that breast cancer is treated – including"
        " surgery, radiation, chemotherapy, hormone therapy, targeted therapy, combination treatments, and clinical trials.",
  ),
  AwarenessInfo(
    image: "assets/breast_cancer/awareness_3.jpg",
    videoLink:
        "https://www.youtube.com/watch?v=DbP0l4146WI&ab_channel=DrAhmadHassanSoliman",
    title: "ما هي أورام الثدي الحميدة أو الخبيثة | دكتور أحمد حسن سليمان",
    description: "يا دكتور أنا لقيت كلاكيع او تكتلات في الثدي !! أعمل ايه؟\n"
        "بعد الذهاب الي طبيب الاورام او طبيب الجراحة لتشخيص الحالة يطلب الطبيب آجراء بعض الفحوصات و الاشعة"
        "يتم التحقق من هوية تلك التكتلات او الكلاكيع الموجودة بالثدي للتأكد تماما من نوعها في حالة الشك في وجود شئ خبيث،"
        " هنا يحتاج الطبيب الي أخذ عينة من تلك التكتلات للتاكد تماما من نوعها وتحليلها",
  ),
  AwarenessInfo(
    image: "assets/breast_cancer/awareness_4.jpg",
    videoLink:
        "https://www.youtube.com/watch?v=yv42OJr5Osk&ab_channel=Dr.DimaAbduljabbar",
    title: "معلومات عن سرطان الثدي - د. ديما عبد الجبار",
    description:
        "معلومات مهمة توضيحية عن مرض سرطان الثدي تقديم دكتورة ديما عبد الجبار\n"
        "الفيديو يوضح الاخطاء الشائعة التي يقع ضحيتها مرضى سرطان الثدي مما تؤدي الى تفاقم المرض او تأخر وصعوبة العلاج",
  ),
  AwarenessInfo(
    image: "assets/breast_cancer/awareness_5.jpg",
    videoLink:
        "https://www.youtube.com/watch?v=l3RWXYxQaYo&ab_channel=AmericanUniversityofBeirutMedicalCenter%28AUBMC%29",
    title: "إرشادات وقائية لتجنب مرض سرطان الثدي",
    description:
        "الدكتور حازم عاصي، أخصائي أورام في المركز الطبي، يحدثنا عن كيفية تجنّب داء سرطان الثدي وطرق الوقاية منه",
  ),
];
