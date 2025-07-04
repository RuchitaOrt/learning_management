import 'dart:io';

import 'package:flutter/material.dart';
import 'package:learning_mgt/Utils/learning_colors.dart';
import 'package:learning_mgt/Utils/lms_styles.dart';
import 'package:learning_mgt/Utils/sizeConfig.dart';
import 'package:learning_mgt/provider/LandingScreenProvider.dart';
import 'package:learning_mgt/screens/HtmlDisplayScreen.dart';
import 'package:learning_mgt/widgets/CustomAppBar.dart';
import 'package:learning_mgt/widgets/GraphCard.dart';
import 'package:provider/provider.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';

class HomePage extends StatefulWidget {
  static const String route = "/homeScreen";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int activeCourses = 3;
  int enrolledCourses = 8;
  int completedCourses = 5;
  int pendingCourses = 2;
  String? selectedModule;

  @override
  Widget build(BuildContext context) {
    return Consumer<LandingScreenProvider>(builder: (context, provider, _) {
      return Scaffold(
        body: Container(
          decoration: AppDecorations.gradientBackground,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome Text
                /*Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Welcome, Ruchita!",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: LearningColors.black,
                      ),
                    ),
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: LearningColors.darkBlue,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ],
                ),*/
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  //margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: ()
                        {
//                           Navigator.push(
//   context,
//   MaterialPageRoute(
//     builder: (context) => HtmlDisplayScreen(decodedDescription: getStyledHtml("<figure class=\"image\">\n <img alt=\"Vrishabha Sankranti  2025\" src=\"https://s3.amazonaws.com/RudraCentre/ProductImages/Articles/Vrishabha_Sankranti__2025-main.jpg\"/>\n</figure>\n<p>\n Vrishabha Sankranti, an auspicious celestial event, marks the transition of the Sun into the zodiac sign of Taurus (Vrishabha Rashi), signifying stability, prosperity, and the nurturing aspects of life. In 2025, this sacred occasion will be observed on\n <strong>\n  Wednesday, May 14th\n </strong>\n . According to the Hindu solar calendar, Vrishabha Sankranti is a time of great spiritual and astrological significance, as it heralds a period of growth, abundance, and divine grace.\n <br/>\n Devotees across India and Nepal observe this day with sacred rituals, bathing in holy rivers, offering food to Brahmins, and worshipping Bhagwan Vishnu and Surya Dev (the Sun God) to invoke divine prosperity. As the Sun’s movement into Taurus symbolizes endurance and material stability,\n <br/>\n Vrishabha Sankranti encourages devotees to cultivate patience, perseverance, and gratitude in their spiritual and worldly pursuits. It serves as a reminder to embrace the divine rhythm of nature and align one's actions with dharma for a fulfilling and prosperous life.\n</p>\n<h2 id=\"festival-date,-time,-muhurat-&amp;-tithi\">\n <strong>\n  Festival Date, Time, Muhurat &amp; Tithi\n </strong>\n</h2>\n<p>\n Vrishabha Sankranti will be observed on\n <strong>\n  Thursday, May 15th, 2025.\n </strong>\n <br/>\n Dashami Tithi (10th lunar day) of the Vaishakha month as per the lunar calendar.\n</p>\n<p>\n <strong>\n  Key Timings for Vrishabha Sankranti 2025:\n </strong>\n</p>\n<ul>\n <li>\n  <strong>\n   Vrishabha Sankranti Punya Kaal Muhurat:\n  </strong>\n  11:45 AM to 1:30 PM (IST)\n  <br/>\n  <strong>\n   Duration:\n  </strong>\n  1 Hour 45 Minutes\n </li>\n <li>\n  <strong>\n   Sankranti Moment:\n  </strong>\n  11:45 AM (IST)\n </li>\n</ul>\n<p>\n <strong>\n  Tithi Timings:\n </strong>\n</p>\n<ul>\n <li>\n  <strong>\n   Dashami Tithi begins at\n  </strong>\n  10:20 AM on May 14th (IST)\n </li>\n <li>\n  <strong>\n   Dashami Tithi ends at\n  </strong>\n  08:55 AM on May 15th (IST)\n </li>\n</ul>\n<p>\n During the Punya Kaal Muhurat, devotees engage in charitable activities, holy dips, and sacred rituals to honor the Sun’s transition into Vrishabha Rashi (Taurus), seeking prosperity, abundance, and spiritual upliftment.\n <br/>\n <i>\n  Note: Sunrise and sunset vary by region and date due to India's geographical diversity. For exact timings, please refer to local astronomical data.\n </i>\n</p>\n<h2 id=\"significance-&amp;-importance-of-vrishabha-sankranti\">\n Significance &amp; Importance of Vrishabha Sankranti\n</h2>\n<figure class=\"image\">\n <img alt=\"Significance &amp; Importance of Vrishabha Sankranti\" src=\"https://s3.amazonaws.com/RudraCentre/ProductImages/Articles/Significance_&amp;_Importance_of_Vrishabha_Sankranti.jpg\"/>\n</figure>\n<p>\n Vrishabha Sankranti holds deep significance as it marks the transition of the Sun into Vrishabha Rashi (Taurus), symbolizing stability, nourishment, and the divine balance between material and spiritual pursuits. According to Vedic astrology, this shift influences the energy of the cosmos, bringing a sense of patience, endurance, and prosperity. The Sun, regarded as the divine sustainer of life, moves into a sign ruled by Venus (Shukra), a planet associated with beauty, abundance, and devotion. This transition is believed to create a harmonious environment, ideal for spiritual reflection and righteous actions.\n <br/>\n <br/>\n This occasion is considered an opportune time for performing charitable acts (daan), self-purification, and seeking divine blessings. Hindu scriptures emphasize that offering food, clothing, and essentials to the needy during this time brings immense spiritual merit (punya) and helps in neutralizing past karmic debts. Many devotees take a sacred dip in holy rivers, such as the Ganga or Yamuna, to cleanse their souls and invite divine grace into their lives.\n <br/>\n <br/>\n Vrishabha Sankranti is also closely linked to agricultural prosperity, as it signals the onset of a season that nurtures growth and sustenance. Farmers pray for bountiful harvests, and special prayers are offered to Surya Dev (the Sun God) and Bhudevi (Mother Earth) for fertility, abundance, and protection from natural calamities. The day is marked by worship of Bhagwan Vishnu and Goddess Lakshmi, seeking their blessings for wealth, stability, and harmony in family life.\n <br/>\n <br/>\n From a spiritual perspective, this festival encourages devotees to embrace the virtues of patience, gratitude, and perseverance. It serves as a reminder that just as the earth patiently nourishes all beings, one must cultivate inner strength and resilience to overcome challenges while remaining steadfast in dharma (righteous living). By engaging in selfless service and prayer on this day, devotees align themselves with the cosmic flow of prosperity and spiritual well-being.\n</p>\n<h2 id=\"stories-of-vrishabha-sankranti-festival\">\n Stories of Vrishabha Sankranti Festival\n</h2>\n<figure class=\"image\">\n <img alt=\"Stories of Vrishabha Sankranti Festival\" src=\"https://s3.amazonaws.com/RudraCentre/ProductImages/Articles/Stories_of_Vrishabha_Sankranti_Festival.jpg\"/>\n</figure>\n<p>\n The sacred occasion of Vrishabha Sankranti is deeply rooted in Vedic traditions and Puranic legends that highlight its profound spiritual significance. One of the most revered stories associated with this festival is linked to Surya Dev (the Sun God) and Vrishabha (the sacred bull, Nandi), the divine mount of Bhagwan Shiva.\n <br/>\n <br/>\n According to ancient scriptures, during this period, the Sun transitions into Vrishabha Rashi (Taurus), signifying stability, endurance, and the flow of divine energy into the earthly realm. It is believed that during this time, the celestial forces work to maintain cosmic balance, ensuring harmony between nature and human life. Vrishabha, the bull, is regarded as a symbol of dharma, patience, and hard work, embodying the virtues necessary for both spiritual and material growth.\n <br/>\n One legend narrates that in ancient times, when humanity strayed from righteousness, chaos and suffering spread across the land. The great sages and rishis prayed to Bhagwan Vishnu and Bhagwan Shiva for guidance. Moved by their devotion, Bhagwan Shiva sent Nandi, his divine bull, to restore order. Nandi traveled across the land, imparting wisdom on righteous living, devotion, and selfless service. It is said that when the Sun entered Vrishabha Rashi, Nandi’s mission was completed, and balance was restored. Since then, this period has been considered auspicious for practicing dharma, engaging in acts of charity, and seeking divine blessings.\n <br/>\n <br/>\n Another story associates Vrishabha Sankranti with the importance of gratitude and devotion. It is believed that in the ancient kingdom of Ayodhya, a humble farmer named Dharmapala was renowned for his unwavering faith in Surya Dev. Despite facing hardships, he never failed to wake up before sunrise, offer water to the Sun, and distribute food to the poor on Sankranti days. Pleased by his devotion, Surya Dev appeared before him on Vrishabha Sankranti and granted him divine wisdom and prosperity, ensuring that his lineage thrived for generations.\n <br/>\n <br/>\n Thus, Vrishabha Sankranti is a day of spiritual reflection, selfless service, and divine worship. It is observed with deep reverence by taking holy dips in sacred rivers, offering prayers to the Sun God, and engaging in acts of charity. The festival serves as a reminder that just as the Sun nurtures all beings without discrimination, one must cultivate the virtues of patience, devotion, and generosity to attain true spiritual fulfillment.\n</p>\n<h2 id=\"how-to-celebrate-vrishabha-sankranti\">\n <strong>\n  How to celebrate Vrishabha Sankranti\n </strong>\n</h2>\n<p>\n Vrishabha Sankranti is a sacred occasion that marks the transition of the Sun into Vrishabha Rashi (Taurus), signifying stability, prosperity, and divine blessings. This day is observed with ritual purity, acts of charity, spiritual practices, and devotion to invoke divine grace and ensure a fruitful life ahead.\n</p>\n<p>\n <strong>\n  Holy Bath and Purification\n </strong>\n <br/>\n On the morning of Vrishabha Sankranti, devotees wake up early and take a sacred bath in holy rivers, lakes, or at home while chanting mantras dedicated to Surya Dev (Bhagwan Sun). Bathing in sacred waters is believed to cleanse sins, remove past karmic burdens, and invite divine blessings. Applying Til (sesame) oil before bathing is considered auspicious as it symbolizes purification.\n</p>\n<p>\n</p>\n<p>\n <strong>\n  Worship of Surya Dev and Vishnu\n </strong>\n</p>\n<p style=\"text-align:center;\">\n <strong>\n  <img src=\"https://s3.amazonaws.com/RudraCentre/ProductImages/Articles/Worship_of_Surya_Dev_and_Vishnu.jpg\"/>\n </strong>\n</p>\n<p>\n The main puja on this day is dedicated to Surya Dev and Bhagwan Vishnu. Devotees offer water (Arghya) to the Sun during sunrise while reciting the Gayatri Mantra or Aditya Hridayam Stotra. This practice is believed to grant strength, wisdom, and success. After Arghya, a lamp (deepam) with ghee is lit, and prayers are offered to Vishnu with Tulsi leaves, sandalwood, flowers, and sacred offerings.\n</p>\n<p>\n</p>\n<p>\n <strong>\n  Performing Daan (Charity)\n </strong>\n</p>\n<p style=\"text-align:center;\">\n <img alt=\"Performing Daan (Charity)\" src=\"https://s3.amazonaws.com/RudraCentre/ProductImages/Articles/Performing_Daan_(Charity).jpg\"/>\n</p>\n<p>\n Charity holds immense significance on Vrishabha Sankranti. Donating clothes, food grains, jaggery, ghee, and essentials to the needy is believed to bring good fortune and remove obstacles from one’s life. Temples and ashrams often conduct mass food donations (Annadanam), where devotees feed the poor as an act of selfless service. Offering gold, silver, or cow donations (Gau Daan) to Brahmins and priests is considered highly meritorious.\n</p>\n<p>\n</p>\n<p>\n <strong>\n  Sankranti Punya Kaal Rituals\n </strong>\n <br/>\n The Punya Kaal (auspicious time) of Vrishabha Sankranti is the most sacred period for performing religious activities. Devotees engage in Japa (chanting), Homa (fire rituals), and Vishnu Sahasranama recitation. Some perform Pitru Tarpan (ancestral offerings) to seek blessings from their forefathers and help their souls attain higher realms.\n</p>\n<p>\n</p>\n<p>\n <strong>\n  Preparing and Offering Sattvic Food\n </strong>\n <br/>\n Devotees prepare special sattvic dishes made from grains, jaggery, and ghee, symbolizing abundance and nourishment. Traditional sweets such as kheer, laddoos, and sweet rice are prepared and offered to the deities before being consumed as prasadam. Some devotees observe a partial fast, consuming only fruits, milk, and sacred foods.\n</p>\n<p>\n</p>\n<p>\n <strong>\n  Temple Visits and Spiritual Discourses\n </strong>\n</p>\n<p style=\"text-align:center;\">\n <strong>\n  <img alt=\"Temple Visits and Spiritual Discourses\" src=\"https://s3.amazonaws.com/RudraCentre/ProductImages/Articles/Temple_Visits_and_Spiritual_Discourses.jpg\"/>\n </strong>\n</p>\n<p>\n Visiting temples dedicated to Surya Dev, Vishnu, or Shiva is considered highly auspicious on this day. Devotees participate in bhajans, kirtans, and discourses on Vedic teachings, enhancing their spiritual knowledge and devotion. Many temples organize special aartis and abhishekams to honor the divine presence.\n</p>\n<p>\n Vrishabha Sankranti is not just an astronomical transition but a sacred opportunity to realign oneself with divine energies. By observing purity, devotion, charity, and worship, devotees invite abundance, peace, and spiritual elevation into their lives. This festival reminds us of the interplay of cosmic forces and human consciousness, urging us to embrace righteousness and seek inner illumination.\n</p>\n<h3 id=\"vrishabha-sankranti-festival-puja-vidhi-(puja-procedure)\">\n <strong>\n  Vrishabha Sankranti Festival Puja Vidhi (Puja Procedure)\n </strong>\n</h3>\n<figure class=\"image\">\n <img alt=\"Vrishabha Sankranti Festival Puja Vidhi (Puja Procedure)\" src=\"https://s3.amazonaws.com/RudraCentre/ProductImages/Articles/Vrishabha_Sankranti_Vrat_Vidhi_(Fasting_Procedure).jpg\"/>\n</figure>\n<p>\n Vrishabha Sankranti marks the transition of the Sun into Vrishabha Rashi (Taurus), signifying growth, stability, and prosperity. This sacred occasion is observed with devotional rituals, Surya Puja, and charitable acts to invoke divine blessings.\n <br/>\n Performing the Vrishabha Sankranti Puja with sincerity brings spiritual upliftment, material well-being, and harmony.\n</p>\n<ul>\n <li>\n  <strong>\n   Purification and Sankalp (Sacred Resolve):\n  </strong>\n  The day begins with an early morning sacred bath in a holy river, lake, or at home with Ganga Jal. Bathing symbolizes spiritual cleansing and renewal. After purifying the body, devotees wear clean clothes and sit in a sacred space to take Sankalp (a solemn vow) before the Puja. This Sankalp involves praying for blessings, prosperity, and liberation from past sins.\n </li>\n <li>\n  <strong>\n   Worship of Surya Dev (Sun God):\n  </strong>\n  <br/>\n  <img src=\"https://s3.amazonaws.com/RudraCentre/ProductImages/Articles/Worship_of_Surya_Dev_(Sun_God).jpg\"/>\n  <br/>\n  Since Vrishabha Sankranti is closely associated with the Sun’s movement, offering Arghya (water oblation) to Surya Dev at sunrise is a significant ritual. Devotees stand facing the east, hold water in a copper vessel, mix it with sesame seeds and flowers, and slowly pour it while chanting Surya mantras like ‘Om Suryaya Namah’. This act is believed to enhance wisdom, health, and divine energy.\n </li>\n <li>\n  <strong>\n   Bhagwan Vishnu and Shiva Puja:\n  </strong>\n  After Surya Puja, devotees worship Bhagwan Vishnu and Bhagwan Shiva to seek divine grace. An image or idol of Vishnu is placed on the altar, and offerings of Tulsi leaves, yellow flowers, sandalwood, and sweets are made. Similarly, Shiva Linga Abhishekam is performed with milk, water, honey, and Bilva leaves. Reciting Vishnu Sahasranama and Rudram is highly auspicious on this day.\n </li>\n <li>\n  <strong>\n   Offering Naivedya and Prasadam:\n  </strong>\n  <br/>\n  <img alt=\"Offering Naivedya and Prasadam\" src=\"https://s3.amazonaws.com/RudraCentre/ProductImages/Articles/Offering_Naivedya_and_Prasadam.jpg\"/>\n  <br/>\n  A sacred offering of sattvic food, such as kheer, rice, jaggery, and fruits, is prepared and offered to the deities. Devotees light diyas (lamps) and incense sticks, symbolizing the dispelling of darkness. The prasadam is then distributed among family members and guests, promoting harmony and divine blessings.\n </li>\n <li>\n  <strong>\n   Performing Daan (Charity and Offerings):\n  </strong>\n  One of the most significant aspects of Vrishabha Sankranti Puja is Daan (charitable giving). Devotees donate clothes, food, grains, ghee, jaggery, and gold to Brahmins and the needy. Gau Daan (cow donation) is considered highly meritorious. Donating items on this day is believed to eliminate karmic debts and invite prosperity.\n </li>\n <li>\n  <strong>\n   Recitation of Sacred Texts and Bhajans:\n  </strong>\n  <br/>\n  <img alt=\"Recitation of Sacred Texts and Bhajans\" src=\"https://s3.amazonaws.com/RudraCentre/ProductImages/Articles/Recitation_of_Sacred_Texts_and_Bhajans.jpg\"/>\n  <br/>\n  Reading from Vedic scriptures like Bhagavad Gita, Vishnu Purana, or Surya Purana adds spiritual merit. Devotees also engage in bhajans, kirtans, and group prayers glorifying Bhagwan Vishnu, Surya Dev, and Bhagwan Shiva. Singing the Aditya Hridayam Stotra enhances the spiritual energy of the surroundings.\n </li>\n <li>\n  <strong>\n   Closing Aarti and Seeking Blessings:\n  </strong>\n  The Puja concludes with a grand Aarti using camphor and ghee lamps. Devotees pray for divine protection, success, and inner peace. The elders of the family bless the younger members, reinforcing love, respect, and gratitude.\n </li>\n</ul>\n<p>\n Vrishabha Sankranti Puja is a sacred occasion to realign with cosmic energies and seek divine blessings. Through ritual purity, Surya worship, acts of charity, and devotion, devotees invite prosperity, peace, and spiritual wisdom into their lives.\n <br/>\n The observance of this Puja strengthens the bond between the individual soul (Jivatma) and the Supreme Consciousness (Paramatma), leading to inner transformation and divine grace.\n</p>\n<h2 id=\"vrishabha-sankranti-puja-mantras\">\n Vrishabha Sankranti Puja Mantras\n</h2>\n<p>\n Chanting sacred mantras during Vrishabha Sankranti Puja enhances spiritual vibrations and invokes divine blessings. Below are some significant mantras dedicated to Surya Dev, Bhagwan Vishnu, and Bhagwan Shiva, who are revered on this auspicious day.\n</p>\n<p>\n <strong>\n  Surya Dev Mantra\n </strong>\n (For Energy, Health, and Prosperity)\n <br/>\n ॐ ह्रां ह्रीं ह्रौं सः सूर्याय नमः॥\n <br/>\n Om Hraam Hreem Hroum Sah Suryaya Namah॥\n <br/>\n (This mantra is chanted while offering Arghya to the Sun, seeking his divine radiance and protection.)\n</p>\n<p>\n</p>\n<p>\n <strong>\n  Bhagwan Vishnu Mantra\n </strong>\n (For Spiritual Upliftment and Protection)\n <br/>\n ॐ नमो नारायणाय॥\n <br/>\n Om Namo Narayanaya॥\n <br/>\n (Chanting this mantra purifies the mind and connects the devotee to the divine presence of Bhagwan Vishnu.)\n</p>\n<p>\n</p>\n<p>\n <strong>\n  Bhagwan Shiva Mantra\n </strong>\n (For Peace and Liberation)\n <br/>\n ॐ नमः शिवाय॥\n <br/>\n Om Namah Shivaya॥\n <br/>\n (A powerful mantra invoking Bhagwan Shiva’s divine grace for inner peace and spiritual enlightenment.)\n</p>\n<p>\n</p>\n<p>\n <strong>\n  Vrishabha Sankranti Kshama Prarthana\n </strong>\n (Prayer for Forgiveness)\n <br/>\n करचरण कृतं वाक्कायजं कर्मजं वा।\n <br/>\n श्रवणनयनजं वा मानसं वापराधम्॥\n</p>\n<p>\n Karacharana Kritam Vaakkaayajam Karmajambaa |\n <br/>\n Shravananaayanajam Vaa Maanasam Vaaparaadham॥\n <br/>\n</p>\n<p>\n <i>\n  (This mantra is recited at the end of the Puja, seeking forgiveness for any mistakes in the observance of rituals.)\n </i>\n</p>\n<p>\n Chanting these sacred mantras with devotion on Vrishabha Sankranti bestows divine energy, prosperity, and spiritual fulfillment, ensuring harmony with cosmic forces.\n</p>\n<h2 id=\"vrishabha-sankranti-vrat-vidhi-(fasting-procedure)\">\n <strong>\n  Vrishabha Sankranti Vrat Vidhi (Fasting Procedure)\n </strong>\n</h2>\n<p>\n Observing Vrishabha Sankranti Vrat is considered highly auspicious as it grants spiritual purification, divine blessings, and freedom from past sins. Devotees observe this fast with utmost sincerity, aligning themselves with the celestial transition of the Sun into Vrishabha Rashi (Taurus).\n <br/>\n <br/>\n On the day of Vrishabha Sankranti, devotees wake up early during Brahma Muhurta and take a holy bath in a sacred river or at home, invoking divine energies. They then take a Sankalpa (vow) to observe the fast with devotion. Many devotees observe a complete fast (Nirjala Vrat), refraining from food and even water, while others opt for a Phalahar Vrat, consuming only fruits, milk, and water. Offering Arghya (water oblation) to Surya Dev at sunrise and chanting the Surya Gayatri Mantra are essential rituals that help in removing obstacles and bestowing vitality.\n <br/>\n <br/>\n Throughout the day, devotees engage in Puja, charity (Daan-Dharma), and recitation of sacred scriptures such as Surya Ashtakam, Vishnu Sahasranama, and Bhagavad Gita. Feeding Brahmins, donating food, clothes, and offering a cow (Gau Daan) are highly meritorious. The fast is typically concluded in the evening after performing the Sandhya Aarti and offering Naivedya (sacred food) to the deities, ensuring that the observance is completed with reverence and purity.\n</p>\n<h2 id=\"vrishabha-sankranti-vrat-katha-(traditional-fasting-story)\">\n <strong>\n  Vrishabha Sankranti Vrat Katha (Traditional Fasting Story)\n </strong>\n</h2>\n<figure class=\"image\">\n <img alt=\"Vrishabha Sankranti Vrat Katha (Traditional Fasting Story)\" src=\"https://s3.amazonaws.com/RudraCentre/ProductImages/Articles/Vrishabha_Sankranti_Vrat_Katha_(Traditional_Fasting_Story).jpg\"/>\n</figure>\n<p>\n In the ancient kingdom of Shivapura, ruled a benevolent and devout king named Chandradeva. His realm was known for its fertile lands, thriving trade, and happy citizens. However, as fate would have it, a terrible misfortune struck. The rivers dried up, crops withered, and an eerie silence replaced the once joyous laughter of the people. The kingdom, once prosperous, now suffered from drought, famine, and disease. Despite his many offerings to the gods and selfless service to his subjects, the king found no relief from this calamity.\n <br/>\n <br/>\n One night, as King Chandradeva lay awake in despair, he had a divine vision. A radiant sage, none other than Rishi Kashyapa, appeared before him and spoke with a voice as deep as the ocean, 'O noble king, the balance of Dharma in your kingdom has been disturbed. The Sun, the source of all energy, has moved into Vrishabha Rashi, yet its transition has not been honored. The failure to observe the sacred Vrishabha Sankranti Vrat has resulted in this turmoil. If you wish to restore harmony, observe this vrat with sincerity, perform Surya Puja, and engage in selfless charity.'\n <br/>\n <br/>\n Awakening with newfound determination, King Chandradeva gathered his ministers, priests, and learned sages. As the day of Vrishabha Sankranti dawned, the king led his people to the holy river for a ceremonial bath, symbolizing the purification of the body and soul. Standing before the golden hues of the rising sun, he offered Arghya (water oblation) to Surya Dev, chanting sacred hymns that echoed through the sky. Vishnu Puja was performed with utmost devotion, and the king observed a strict fast, consuming only the sacred Charanamrit (holy water).\n</p>\n<p>\n <br/>\n However, the vrat was not complete without an act of Daana (charity). Remembering the sage’s words, Chandradeva offered food, clothing, and cows (Gau Daan) to Brahmins and the needy, praying that his kingdom might once again flourish. His selflessness and unwavering faith resonated through the cosmos, and soon, dark clouds gathered in the sky. The heavens, pleased by the vrat, opened up in a life-giving downpour, drenching the parched earth. The rivers gushed once more, fields turned lush green, and the air filled with the scent of renewal. The people rejoiced, their faith in Dharma reaffirmed.\n <br/>\n <br/>\n Just then, as the king stood amidst his joyous subjects, a blinding celestial light emerged. From it appeared Bhagwan Vishnu, his divine presence exuding serenity. With a voice as gentle as the wind, he declared, 'O noble king, your devotion has restored balance to the land. The observance of Vrishabha Sankranti Vrat brings abundance, spiritual upliftment, and liberation from sins. Let this sacred tradition continue, for those who honor it shall be freed from past karmas and blessed with prosperity, peace, and divine grace.'\n <br/>\n <br/>\n Overwhelmed with reverence, King Chandradeva vowed that Vrishabha Sankranti Vrat would forever be observed in his kingdom and beyond. To this day, devotees continue this sacred practice, offering prayers to Surya Dev, Bhagwan Vishnu, and Mother Earth, seeking their blessings for prosperity, good fortune, and spiritual enlightenment. The vrat serves as a reminder that righteous action, devotion, and selfless charity lead to divine grace and eternal well-being.\n</p>\n<h2 id=\"puja-utensils,-essentials\">\n <strong>\n  Puja Utensils, Essentials\n </strong>\n</h2>\n<p>\n Rudra Centre brings an extensive collection of Puja Articles which caters to all that is required for daily and special Puja Vidhis. We offer variants of designs and sizes in each category. The list includes handcrafted Puja Mandirs, Puja Pedestals, offering Bowls, Panchpatra, intricately carved Puja Thalis, Abhishek Vessels, in different materials, Pure Silver/German Silver articles like Kalash, set of Shodash Upachara and Several other Puja Articles, which we deliver at your doorstep.\n <br/>\n <a href=\"https://www.rudraksha-ratna.com/p/puja-articles\">\n  <strong>\n   Visit the complete collection:\n  </strong>\n </a>\n</p>\n<h3 id=\"surya-yantra-in-gold-polish\">\n Surya Yantra in Gold Polish\n</h3>\n<figure class=\"image\">\n <img alt=\"Surya Yantra in Gold Polish\" src=\"https://s3.amazonaws.com/RudraCentre/ProductImages/Articles/Surya_Yantra_in_Gold_Polish.jpg\"/>\n</figure>\n<p style=\"text-align:center;\">\n <a href=\"https://www.rudraksha-ratna.com/buy/shree-siddh-surya-yantra-in-gold-polish---3-inches\">\n  <strong>\n   Buy Now\n  </strong>\n </a>\n</p>\n<p>\n Surya Yantra enhances personal discipline, righteous and moral action and it makes the wearer powerful and ready to take action using the power of his whole physical, mental and emotional strength. It imparts sunny confidence to the wearer and makes he or she shine in all areas, and as a result, they are increasingly admired and respected by others.\n</p>\n<h3 id=\"rudraksha-malas\">\n Rudraksha Malas\n</h3>\n<p style=\"text-align:center;\">\n <img src=\"https://s3.amazonaws.com/RudraCentre/ProductImages/Articles/Rudraksha_Malas.jpg\"/>\n</p>\n<p style=\"text-align:center;\">\n <a href=\"https://www.rudraksha-ratna.com/p/rudraksha-kantha-rudraksha-mala\">\n  <strong>\n   Buy Now\n  </strong>\n </a>\n</p>\n<p>\n Rudraksha 1 Mukhi to 14 Mukhi Malas, made of the best quality, natural Rudraksha Beads, handpicked for optimum benefits. The Malas are mostly strung in Thread with knots in between the beads and a Silk Tassel with Sumeru Bead. They are worn and also used for Japa or chanting purposes. Other variants are Silver or Gold designer capped Malas.\n</p>\n<h3 id=\"vishnu-vishwaroop-brass-idol\">\n Vishnu Vishwaroop Brass Idol\n</h3>\n<figure class=\"image\">\n <img alt=\"Vishnu Vishwaroop Brass Idol\" src=\"https://s3.amazonaws.com/RudraCentre/ProductImages/Articles/Vishnu_Vishwaroop_Brass_Idol.jpg\"/>\n</figure>\n<p style=\"text-align:center;\">\n <a href=\"https://www.rudraksha-ratna.com/buy/vishnu-vishwaroop-brass-idol\">\n  <strong>\n   Buy Now\n  </strong>\n </a>\n</p>\n<p>\n The Vishnu Vishwaroop is intrinsically carved in brass. He is portrayed with multiple heads, standing on a pedestal and His hands holding powerful weapons. His right hand is placed in Abhaya Mudra while his left hand holds a lotus flower. He is shown resting on the coils of a thousand headed Sheshnag, surrounded by Ksheersagara. He is also seen to be wielding a mace in his right hand.\n</p>\n<p>\n Bhagwan Vishnu represents the aspect of the supreme reality that preserves and sustains the universe. Though there are multiple Vishvaroop theophanies, the most celebrated is in the Bhagavad Gita, narrated by Bhagwan Krishna to Pandava prince Arjuna on the battlefield of Kurukshetra. The 'Viraat' roop of Bhagwan Vishnu was revealed to Arjuna in Mahabharata.\n</p>\n<h3 id=\"surya-(sun)-puja-and-jaap\">\n Surya (Sun) Puja and Jaap\n</h3>\n<figure class=\"image\">\n <img alt=\"Surya (Sun) Puja and Jaap\" src=\"https://s3.amazonaws.com/RudraCentre/ProductImages/Articles/Surya_(Sun)_Puja_and_Jaap.jpg\"/>\n</figure>\n<p style=\"text-align:center;\">\n <a href=\"https://www.rudraksha-ratna.com/buy/surya-sun-puja-and-jaap\">\n  <strong>\n   Book Now\n  </strong>\n </a>\n</p>\n<p>\n Surya Puja and Jaap is a sacred ritual dedicated to Surya Narayana, the Sun God in Hinduism, who is regarded as the source of light, life, and vitality. This puja is performed to invoke the Sun’s divine blessings for health, prosperity, success, and spiritual enlightenment. As the cosmic force of energy, the Sun symbolizes knowledge, wisdom, and clarity of purpose. Through Surya Puja and Jaap, devotees seek to balance the Sun’s energies in their lives, unlocking leadership qualities, charisma, and inner strength.\n</p>\n<p>\n <strong>\n  Benefits of Surya Puja:\n </strong>\n</p>\n<ul>\n <li>\n  Brings good health, vitality, prosperity, and success.\n </li>\n <li>\n  Enhances spiritual connection and promotes physical well-being.\n </li>\n <li>\n  Offers clarity of mind, wisdom, and a deeper understanding of life.\n </li>\n <li>\n  Develops leadership qualities, confidence, and charisma.\n </li>\n</ul>\n<p>\n Puja service includes: Sthapana (Ganesh, Devi, Navgraha Kalash, Brahma), Swasti Vachan, Sankalpa, Ganesh Pujan, Invocation of major Gods and Goddesses, Abhishek and Pujan of Surya Dev, Mantra Japa (2100 times), Homa, Aarti and Pushpanjali.  Homa would be performed weekly in case of longer duration pujas.\n <br/>\n Rudra Centre Puja Services is the oldest and most trusted Online Puja Services provider in the world. Over 20 years we have organized Yagnas, Pujas, Homas and Kathas like Ati Rudra Mahayajna, Sahasra Chandi Homa, Akhand Ramayan Paath, Shiva Maha Puran Katha, 4 Prahar Mahashivratri Mahapuja with teams of 100’s of curated priests for the benefit of mankind and our global clientele.\n</p>\n<h2 id=\"conclusion\">\n Conclusion\n</h2>\n<p>\n Vrishabha Sankranti stands as a sacred celestial transition, marking the Sun’s movement into Vrishabha Rashi (Taurus), a moment of deep spiritual significance that aligns the cosmic forces with human consciousness. This auspicious occasion is more than just an astronomical event; it is a profound reminder of the eternal cycle of Dharma, Karma, and divine grace. It signifies prosperity, renewal, and the harmonious connection between the celestial and the terrestrial realms.\n <br/>\n <br/>\n The festival is observed with prayers, fasting, and charitable deeds, reinforcing the essential Vedic principles of self-discipline, gratitude, and generosity. Worshiping Surya Dev, the life-giving force of the universe, on this day is believed to remove obstacles, bestow longevity, and invite divine blessings into one’s life. The practice of holy baths in sacred rivers, offering Arghya to the Sun, and acts of charity such as Gau Daan (cow donation) and Annadaan (feeding the needy) are believed to purify the soul and open the doors to spiritual elevation and material abundance.\n <br/>\n <br/>\n Vrishabha Sankranti also serves as a powerful occasion for introspection and transformation. Just as the Sun progresses through its divine journey across the zodiac, devotees are encouraged to move forward in their spiritual path, shedding negativity and embracing the light of wisdom, devotion, and righteousness. Observing the vrat with sincerity and faith is said to wash away past sins, neutralize karmic debts, and lead one toward Moksha (liberation).\n <br/>\n This festival, steeped in both mythological grandeur and cosmic significance, embodies the essence of harmony between the universe, nature, and human existence. It teaches that when we align our lives with the principles of truth, devotion, and service, the divine blessings of Surya Dev, Bhagwan Shiva and Bhagwan Vishnu manifest in the form of prosperity, happiness, and inner enlightenment.\n <br/>\n <br/>\n By honoring Vrishabha Sankranti with devotion, one not only seeks material success but also attains spiritual upliftment and eternal divine grace, forging an unbreakable bond with the cosmic order.\n</p>\n")),
//   ),
// );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome,",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Ruchita!",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: LearningColors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: LearningColors.darkBlue,
                            child: const Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          // Verified badge
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blueAccent,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                              padding: const EdgeInsets.all(3),
                              child: const Icon(
                                Icons.verified, // You can also use Icons.shield or Icons.verified_user
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),


                const SizedBox(height: 12),

                // Overview Heading
                Text(
                  "Overview",
                  style: LMSStyles.tsblackTileBold,
                ),
                const SizedBox(height: 12),

                // Grid Cards
                /*GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 6,
                  childAspectRatio: 1.3,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    CourseCard(
                      title: "Active",
                      count: activeCourses,
                      icon: Icons.play_arrow,
                      color: Colors.orange,
                      total: 10,
                    ),
                    CourseCard(
                      title: "Enrolled",
                      count: enrolledCourses,
                      icon: Icons.school,
                      color: Colors.blue,
                      total: 10,
                    ),
                    CourseCard(
                      title: "Completed",
                      count: completedCourses,
                      icon: Icons.check_circle,
                      color: Colors.green,
                      total: 10,
                    ),
                    CourseCard(
                      title: "Pending",
                      count: pendingCourses,
                      icon: Icons.pending_actions,
                      color: Colors.red,
                      total: 10,
                    ),
                  ],
                ),*/

                GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.1,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    CourseCard(
                      title: "Result Percentile",
                      count: 87, // example: 87 percentile
                      total: 100,
                      icon: Icons.bar_chart_rounded,
                      color: Colors.deepPurple,
                      suffix: "%",
                    ),
                    CourseCard(
                      title: "Certificates Earned",
                      count: 4,
                      total: 10,
                      icon: Icons.verified_rounded,
                      color: Colors.green,
                    ),
                    CourseCard(
                      title: "Total Score",
                      count: 268,
                      total: 300,
                      icon: Icons.score,
                      color: Colors.blueAccent,
                    ),
                    CourseCard(
                      title: "Completed Courses",
                      count: 6,
                      total: 10,
                      icon: Icons.check_circle_outline,
                      color: Colors.orange,
                    ),
                  ],
                ),

                // Ongoing Courses Section
                const SizedBox(height: 12),
                Text(
                  "Ongoing Course",
                  style: LMSStyles.tsblackTileBold,
                ),
                const SizedBox(height: 12),
                CurrentCourseCard(
                  courseTitle: "Fundamental: Marine Navigation",
                  progress: 0.65,
                  currentModule: "Module 3: Navigation Techniques",
                  onModuleChanged: (value) {
                    setState(() {
                      selectedModule = value;
                    });
                  },
                ),
                /*SizedBox(
                  height: 130,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 2.0),
                        child: OngoingCourseCard(
                          courseTitle: "Fundamental :Marine Navigation",
                          progress: (index + 1) * 0.15,
                        ),
                      );
                    },
                  ),
                ),*/
                const SizedBox(height: 12),
                Text(
                  "Recommended Course",
                  style: LMSStyles.tsblackTileBold,
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height:Platform.isIOS?SizeConfig.blockSizeVertical * 35.5:SizeConfig.blockSizeVertical * 39,
                  // Platform.isIOS?MediaQuery.of(context).size.height * 0.36: MediaQuery.of(context).size.height * 0.39,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      final courses = [
                        {
                          'title': 'Advanced Navigation Navigation Navigation Navigation Navigation Navigation',
                          'content': '6 Modules · 2 Projects',
                          'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlbIDRuVn3XZxVDRbpIMoYUUx-hS9v63awWLH97LbfhPw4VkQUK8iquu2LDFpaazgfSHM&usqp=CAU',
                          'duration': '8h 45m · 1.5L+ Learners',
                        },
                        {
                          'title': 'Marine Safety',
                          'content': '6 Modules · 2 Projects',
                          'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQy5J_LGg_5D-OkkskgbBnZXbdFq9Kuovbvew&s',
                          'duration': '6h 30m · 1.2L+ Learners',
                        },
                        {
                          'title': 'Engine Maintenance',
                          'content': '6 Modules · 2 Projects',
                          'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPVDI288Kwzhlmxzvyx6b9RbA0i5qgRcI7UA&s',
                          'duration': '10h 15m · 1L+ Learners',
                        },
                        {
                          'title': 'Cargo Operations',
                          'content': '6 Modules · 2 Projects',
                          'image': 'https://source.unsplash.com/featured/?cargo,ship',
                          'duration': '7h 20m · 1L+ Learners',
                        },
                      ];

                      return RecommendedCourseItem(
                        title: courses[index]['title']!,
                        content: courses[index]['content']!,
                        image: courses[index]['image']!,
                        duration: courses[index]['duration']!,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),

                // Progress Graph
                Text(
                  "Progress Graph",
                  style:LMSStyles.tsblackTileBold,
                ),
                const SizedBox(height: 12),
             GraphCard()

              ],
            ),
          ),
        ),
      );
    });
  }
  String getStyledHtml(String htmlContent) {
    return """
    <html>
      <head>
        <style>
          body {
            font-family: sans-serif;
            padding: 16px;
            line-height: 1.6;
          }
          img {
            max-width: 100%;
            height: auto;
            display: block;
            margin: 12px 0;
          }
        </style>
      </head>
      <body>
        $htmlContent
      </body>
    </html>
    """;
  }

}

class CurrentCourseCard extends StatelessWidget {
  final String courseTitle;
  final double progress;
  final String currentModule;
  final ValueChanged<String?>? onModuleChanged;

  const CurrentCourseCard({
    super.key,
    required this.courseTitle,
    required this.progress,
    required this.currentModule,
    this.onModuleChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title and Play Button
          Text(
            courseTitle,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 14),

          /// Progress Indicator
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: LearningColors.primaryBlue550.withOpacity(0.15),
              color: LearningColors.darkBlue,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "${(progress * 100).toInt()}% completed",
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),

          /// Expanded Module List (Replacing Dropdown)
          /*Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: LearningColors.darkBlue.withOpacity(0.2),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Text(
                    'Modules',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
                Divider(color: Colors.grey.shade300, height: 1),
                ...[
                  "Module 1: Introduction",
                  "Module 2: Basic Navigation",
                  "Module 3: Navigation Techniques",
                  "Module 4: Advanced Concepts",
                  "Module 5: Final Assessment"
                ].map((module) {
                  final isSelected = module == currentModule;
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    title: Text(
                      module,
                      style: TextStyle(
                        color: isSelected ? LearningColors.darkBlue : Colors.black87,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                    trailing: isSelected
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : const Icon(Icons.circle_outlined, size: 20, color: Colors.grey),
                    onTap: () {
                      if (onModuleChanged != null) {
                        onModuleChanged!(module);
                      }
                    },
                  );
                }).toList(),
              ],
            ),
          ),*/

          /// Expandable Module List using ExpansionTile
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: LearningColors.darkBlue.withOpacity(0.2),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: ExpansionTile(
                title: Text(
                  currentModule,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                iconColor: LearningColors.darkBlue,
                collapsedIconColor: LearningColors.darkBlue,
                children: () {
                  final modules = [
                    "Module 1: Introduction",
                    "Module 2: Basic Navigation",
                    "Module 3: Navigation Techniques",
                    "Module 4: Advanced Concepts",
                    "Module 5: Final Assessment"
                  ];
                  final currentIndex = modules.indexOf(currentModule);

                  return modules.asMap().entries.map((entry) {
                    final index = entry.key;
                    final module = entry.value;

                    Color textColor;
                    Widget? trailingIcon;

                    if (index < currentIndex) {
                      textColor = LearningColors.darkBlue;
                      trailingIcon = const Icon(Icons.check_circle, color: LearningColors.darkBlue);
                    } else if (index == currentIndex) {
                      textColor = LearningColors.darkBlue;
                      trailingIcon = null;
                    } else {
                      textColor = LearningColors.neutral400;
                      trailingIcon = null;
                    }

                    return ListTile(
                      title: Text(
                        module,
                        style: TextStyle(
                          color: textColor,
                          fontWeight: index == currentIndex ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                      trailing: trailingIcon,
                      onTap: () {
                        if (onModuleChanged != null) {
                          onModuleChanged!(module);
                        }
                      },
                    );
                  }).toList();
                }(),
              ),
            ),
          ),

          /// Dropdown for Modules
          /*Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: LearningColors.darkBlue.withOpacity(0.2), width: 1.2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: currentModule,
                icon: Icon(Icons.keyboard_arrow_down_rounded, color: LearningColors.primaryBlue550),
                isExpanded: true,
                dropdownColor: Colors.white,
                borderRadius: BorderRadius.circular(12),
                style: TextStyle(
                  color: LearningColors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                items: [
                  "Module 1: Introduction",
                  "Module 2: Basic Navigation",
                  "Module 3: Navigation Techniques",
                  "Module 4: Advanced Concepts",
                  "Module 5: Final Assessment"
                ].map((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        value,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: onModuleChanged,
              ),
            ),
          ),*/

          const SizedBox(height: 20),

          /// Continue Watching
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 100,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    LearningColors.darkBlue.withOpacity(0.95),
                    LearningColors.primaryBlue550,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: LearningColors.darkBlue.withOpacity(0.3),
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.play_circle_fill_rounded,
                    size: 48,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Understanding Ships Operating in Polar Waters",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 2,
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          "Resume",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final String title;
  final int count;
  final int total;
  final IconData icon;
  final Color color;
  final String suffix;

  const CourseCard({
    super.key,
    required this.title,
    required this.count,
    required this.total,
    required this.icon,
    required this.color,
    this.suffix = "",
  });

  @override
  Widget build(BuildContext context) {
    double percent = (total == 0) ? 0 : count / total;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(color: color.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon top-right
          Align(
            alignment: Alignment.topRight,
            child: Icon(icon, color: color, size: 28),
          ),
          const Spacer(),
          Text(
            "$count$suffix",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            maxLines: 2,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              
              color: Colors.black87,
            ),
          ),
          const Spacer(),
          // Progress bar
          LinearProgressIndicator(
            value: percent.clamp(0.0, 1.0),
            backgroundColor: color.withOpacity(0.15),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 6,
            borderRadius: BorderRadius.circular(8),
          ),
        ],
      ),
    );
  }
}

class OngoingCourseCard extends StatelessWidget {
  final String courseTitle;
  final double progress;

  const OngoingCourseCard({
    super.key,
    required this.courseTitle,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            courseTitle,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const Spacer(),
          LinearProgressIndicator(
            value: progress,
            color: Colors.blue,
            backgroundColor: Colors.blue[100],
          ),
          const SizedBox(height: 8),
          Text("${(progress * 100).toInt()}% completed"),
        ],
      ),
    );
  }
}

class RecommendedCourseItem extends StatelessWidget {
  final String title;
  final String content;
  final String image;
  final String duration;

  const RecommendedCourseItem({
    super.key,
    required this.title,
    required this.content,
    required this.image,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          /// Image with "Recommended" tag
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  image,
                  height: MediaQuery.of(context).size.height * 0.18,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        LearningColors.darkBlue,
                        LearningColors.primaryBlue550,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'RECOMMENDED',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ],
          ),

          /// Title, Content,Duration, Button
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  content,
                  style: LMSStyles.tsWhiteNeutral300W3002.copyWith(fontSize: 14),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  title,
                  style: LMSStyles.tsblackTileBold2,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.schedule, size: 14, color: LearningColors.neutral500),
                    const SizedBox(width: 4),
                    Text(
                      duration,
                      style: LMSStyles.tsWhiteNeutral300W3002.copyWith(fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      backgroundColor: LearningColors.darkBlue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'View Course',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:learning_mgt/Utils/learning_colors.dart';
// import 'package:learning_mgt/Utils/sizeConfig.dart';
// import 'package:learning_mgt/provider/LandingScreenProvider.dart';
// import 'package:learning_mgt/widgets/CustomAppBar.dart';
// import 'package:provider/provider.dart';

// class HomePage extends StatefulWidget {
//     static const String route = "/homeScreen";
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int activeCourses = 3;
//   int enrolledCourses = 8;
//   int completedCourses = 5;

//   @override
//   Widget build(BuildContext context) {
//     return 
//      Consumer<LandingScreenProvider>(builder: (context, provider, _) {
//   return  Scaffold(
//       backgroundColor: Colors.grey[100],
//      appBar: PreferredSize(
//             preferredSize: const Size.fromHeight(kToolbarHeight),
//             child: CustomAppBar(
//               isSearchClickVisible: () {
//                 // provider.toggleSearchIconCategory();
//               },
//               isSearchValueVisible: provider.isSearchIconVisible,
//             ),
//           ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Row(
//           children: [
//             Expanded(
//               child: CourseCard(
//                 title: "Active",
//                 count: activeCourses,
//                 icon: Icons.play_arrow,
//                 color: Colors.orange,
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: CourseCard(
//                 title: "Enrolled",
//                 count: enrolledCourses,
//                 icon: Icons.school,
//                 color: Colors.blue,
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: CourseCard(
//                 title: "Completed",
//                 count: completedCourses,
//                 icon: Icons.check_circle,
//                 color: Colors.green,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//      });
//   }
// }

// class CourseCard extends StatelessWidget {
//   final String title;
//   final int count;
//   final IconData icon;
//   final Color color;

//   const CourseCard({
//     super.key,
//     required this.title,
//     required this.count,
//     required this.icon,
//     required this.color,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: SizeConfig.blockSizeVertical*17,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color:
//         // LearningColors.neutral100,
//          color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: color.withOpacity(0.2)),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
         
//           const SizedBox(height: 2),
//           Text(
//             "$count",
//             style: TextStyle(
//               fontSize: 26,
//               fontWeight: FontWeight.bold,
//               color: LearningColors.black,
//             ),
//           ),
//           SizedBox(height: SizeConfig.blockSizeVertical*2,),
//           Text(
//             "$title Course${count != 1 ? "s" : ""}",
//             style: TextStyle(color: LearningColors.black,fontSize: 12,),
//           ),
//         ],
//       ),
//     );
//   }
// }
