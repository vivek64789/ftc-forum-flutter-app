import 'package:flutter/material.dart';
import 'package:ftc_forum/widgets/reply_card.dart';
import 'package:ftc_forum/widgets/write_comment.dart';

class RepliesThread extends StatelessWidget {
  const RepliesThread({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WriteComment(size: size),
        SizedBox(
          height: size.height * 0.6,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              ReplyCard(
                reply: "Programming is something that you don't know",
                date: "2022-03-4",
                onPress: () {},
                profileUrl:
                    "https://lh3.googleusercontent.com/gRLrC5v7WmqByiBdDvIaXF3x5m82KG6VbM1KT699kq6SJPLEXXMGPbgqYx2H5RhWUO9QR0jwqnfCcNgTCZdw1XLN0mVbxoYVe4HOlU0VBrkoBeC8TlA5qkFVOmenPJtZuDHUKz8oAYMQW4LXp4hBCv863hHNxylHgKZecbTmwr_UjxAj4zL2EA6no9jmCbzG2GW_96bcpz_0WQgy0p3UutgbF_8GbaEMAruRgX8FCPk4-v5EWcJW9n_UAxhTcIblDqybIb9uzrvHXOnf1mdv3vkAsx00OeX-jfVTqRdIGXZ6o_Ubv2wflswfMVgqHuh8pxz_N1yuMWPHk8xwJgzwCseuDS8wF0G80IU-grKYx98pxjiOo_zb4VmYwfVf6vbgl4cLe2VEFmLypoXni-BWSo4dXBgcHqgqBWdOoLq-pJDl0jeT9EsRbv5awSQ1cXX48O3Q4KwzmtqDk0i-7dFi7EIDOMiW0q8vZn1dsQ1J5AoRuxUmxK_Tqu0LoHL1hEN7FMVEz04OmmuFTbTD4CIaAS-7mCR8opBtSCPql0yDMhXAmWTIzJN3sbkDElWYwod8PS57m7Txve4w8zZf4YdvLeZYRzhqyDNSFWDvwlTf7mcSH8jIs__bRYQ9xfLsZu_nhS3wJOV7PCE-jXFL0jQohg66UyODLx7Art2zgMmBRLi-72SzaaaSxZN-4TxADjpxKsp0LgKdCURmEYvYAHVRNOSgiOkREzM932DNW9SmoBL0mjNXTl-EfbIe74kmRFGPUAN9roZ5SB-izLUJlIjXq_fV6dUrPWFhSL9ms5ahRfRao4JIkd2jUMBof6EeJFZereP_wIwCcN4TNQrOGCub0aE_9Hk-jfhhVVPbrJcVfyf4NDRR9gyBuvAtC6TSRYN7ElozgPbWsMtxPy49BVVjLcqt9QJ_4I7wQuQKpzUsjtJ8AMXwa1hykSnvhRVUVKGP8_Z0z1PX7m5vCv2du4bIXDq450pspUz_HCZUwiVDyepq07-v3-Bm7oQB9nVW9G6peBpLtQJ6iNTML7rWKv07EXq42E7EqgK4WhNt-1MAyG8pMI_C8RZpC-KJmQU=w1624-h2000-no?authuser=0",
                bgColor: Theme.of(context).scaffoldBackgroundColor,
                comments: "3",
                downvotes: "4",
              ),
              ReplyCard(
                reply: "Programming is something that you don't know",
                date: "2022-03-4",
                onPress: () {},
                profileUrl:
                    "https://lh3.googleusercontent.com/gRLrC5v7WmqByiBdDvIaXF3x5m82KG6VbM1KT699kq6SJPLEXXMGPbgqYx2H5RhWUO9QR0jwqnfCcNgTCZdw1XLN0mVbxoYVe4HOlU0VBrkoBeC8TlA5qkFVOmenPJtZuDHUKz8oAYMQW4LXp4hBCv863hHNxylHgKZecbTmwr_UjxAj4zL2EA6no9jmCbzG2GW_96bcpz_0WQgy0p3UutgbF_8GbaEMAruRgX8FCPk4-v5EWcJW9n_UAxhTcIblDqybIb9uzrvHXOnf1mdv3vkAsx00OeX-jfVTqRdIGXZ6o_Ubv2wflswfMVgqHuh8pxz_N1yuMWPHk8xwJgzwCseuDS8wF0G80IU-grKYx98pxjiOo_zb4VmYwfVf6vbgl4cLe2VEFmLypoXni-BWSo4dXBgcHqgqBWdOoLq-pJDl0jeT9EsRbv5awSQ1cXX48O3Q4KwzmtqDk0i-7dFi7EIDOMiW0q8vZn1dsQ1J5AoRuxUmxK_Tqu0LoHL1hEN7FMVEz04OmmuFTbTD4CIaAS-7mCR8opBtSCPql0yDMhXAmWTIzJN3sbkDElWYwod8PS57m7Txve4w8zZf4YdvLeZYRzhqyDNSFWDvwlTf7mcSH8jIs__bRYQ9xfLsZu_nhS3wJOV7PCE-jXFL0jQohg66UyODLx7Art2zgMmBRLi-72SzaaaSxZN-4TxADjpxKsp0LgKdCURmEYvYAHVRNOSgiOkREzM932DNW9SmoBL0mjNXTl-EfbIe74kmRFGPUAN9roZ5SB-izLUJlIjXq_fV6dUrPWFhSL9ms5ahRfRao4JIkd2jUMBof6EeJFZereP_wIwCcN4TNQrOGCub0aE_9Hk-jfhhVVPbrJcVfyf4NDRR9gyBuvAtC6TSRYN7ElozgPbWsMtxPy49BVVjLcqt9QJ_4I7wQuQKpzUsjtJ8AMXwa1hykSnvhRVUVKGP8_Z0z1PX7m5vCv2du4bIXDq450pspUz_HCZUwiVDyepq07-v3-Bm7oQB9nVW9G6peBpLtQJ6iNTML7rWKv07EXq42E7EqgK4WhNt-1MAyG8pMI_C8RZpC-KJmQU=w1624-h2000-no?authuser=0",
                bgColor: Theme.of(context).scaffoldBackgroundColor,
                comments: "3",
                downvotes: "4",
              ),
              ReplyCard(
                reply: "Programming is something that you don't know",
                date: "2022-03-4",
                onPress: () {},
                profileUrl:
                    "https://lh3.googleusercontent.com/gRLrC5v7WmqByiBdDvIaXF3x5m82KG6VbM1KT699kq6SJPLEXXMGPbgqYx2H5RhWUO9QR0jwqnfCcNgTCZdw1XLN0mVbxoYVe4HOlU0VBrkoBeC8TlA5qkFVOmenPJtZuDHUKz8oAYMQW4LXp4hBCv863hHNxylHgKZecbTmwr_UjxAj4zL2EA6no9jmCbzG2GW_96bcpz_0WQgy0p3UutgbF_8GbaEMAruRgX8FCPk4-v5EWcJW9n_UAxhTcIblDqybIb9uzrvHXOnf1mdv3vkAsx00OeX-jfVTqRdIGXZ6o_Ubv2wflswfMVgqHuh8pxz_N1yuMWPHk8xwJgzwCseuDS8wF0G80IU-grKYx98pxjiOo_zb4VmYwfVf6vbgl4cLe2VEFmLypoXni-BWSo4dXBgcHqgqBWdOoLq-pJDl0jeT9EsRbv5awSQ1cXX48O3Q4KwzmtqDk0i-7dFi7EIDOMiW0q8vZn1dsQ1J5AoRuxUmxK_Tqu0LoHL1hEN7FMVEz04OmmuFTbTD4CIaAS-7mCR8opBtSCPql0yDMhXAmWTIzJN3sbkDElWYwod8PS57m7Txve4w8zZf4YdvLeZYRzhqyDNSFWDvwlTf7mcSH8jIs__bRYQ9xfLsZu_nhS3wJOV7PCE-jXFL0jQohg66UyODLx7Art2zgMmBRLi-72SzaaaSxZN-4TxADjpxKsp0LgKdCURmEYvYAHVRNOSgiOkREzM932DNW9SmoBL0mjNXTl-EfbIe74kmRFGPUAN9roZ5SB-izLUJlIjXq_fV6dUrPWFhSL9ms5ahRfRao4JIkd2jUMBof6EeJFZereP_wIwCcN4TNQrOGCub0aE_9Hk-jfhhVVPbrJcVfyf4NDRR9gyBuvAtC6TSRYN7ElozgPbWsMtxPy49BVVjLcqt9QJ_4I7wQuQKpzUsjtJ8AMXwa1hykSnvhRVUVKGP8_Z0z1PX7m5vCv2du4bIXDq450pspUz_HCZUwiVDyepq07-v3-Bm7oQB9nVW9G6peBpLtQJ6iNTML7rWKv07EXq42E7EqgK4WhNt-1MAyG8pMI_C8RZpC-KJmQU=w1624-h2000-no?authuser=0",
                bgColor: Theme.of(context).scaffoldBackgroundColor,
                comments: "3",
                downvotes: "4",
              ),
              ReplyCard(
                reply: "Programming is something that you don't know",
                date: "2022-03-4",
                onPress: () {},
                profileUrl:
                    "https://lh3.googleusercontent.com/gRLrC5v7WmqByiBdDvIaXF3x5m82KG6VbM1KT699kq6SJPLEXXMGPbgqYx2H5RhWUO9QR0jwqnfCcNgTCZdw1XLN0mVbxoYVe4HOlU0VBrkoBeC8TlA5qkFVOmenPJtZuDHUKz8oAYMQW4LXp4hBCv863hHNxylHgKZecbTmwr_UjxAj4zL2EA6no9jmCbzG2GW_96bcpz_0WQgy0p3UutgbF_8GbaEMAruRgX8FCPk4-v5EWcJW9n_UAxhTcIblDqybIb9uzrvHXOnf1mdv3vkAsx00OeX-jfVTqRdIGXZ6o_Ubv2wflswfMVgqHuh8pxz_N1yuMWPHk8xwJgzwCseuDS8wF0G80IU-grKYx98pxjiOo_zb4VmYwfVf6vbgl4cLe2VEFmLypoXni-BWSo4dXBgcHqgqBWdOoLq-pJDl0jeT9EsRbv5awSQ1cXX48O3Q4KwzmtqDk0i-7dFi7EIDOMiW0q8vZn1dsQ1J5AoRuxUmxK_Tqu0LoHL1hEN7FMVEz04OmmuFTbTD4CIaAS-7mCR8opBtSCPql0yDMhXAmWTIzJN3sbkDElWYwod8PS57m7Txve4w8zZf4YdvLeZYRzhqyDNSFWDvwlTf7mcSH8jIs__bRYQ9xfLsZu_nhS3wJOV7PCE-jXFL0jQohg66UyODLx7Art2zgMmBRLi-72SzaaaSxZN-4TxADjpxKsp0LgKdCURmEYvYAHVRNOSgiOkREzM932DNW9SmoBL0mjNXTl-EfbIe74kmRFGPUAN9roZ5SB-izLUJlIjXq_fV6dUrPWFhSL9ms5ahRfRao4JIkd2jUMBof6EeJFZereP_wIwCcN4TNQrOGCub0aE_9Hk-jfhhVVPbrJcVfyf4NDRR9gyBuvAtC6TSRYN7ElozgPbWsMtxPy49BVVjLcqt9QJ_4I7wQuQKpzUsjtJ8AMXwa1hykSnvhRVUVKGP8_Z0z1PX7m5vCv2du4bIXDq450pspUz_HCZUwiVDyepq07-v3-Bm7oQB9nVW9G6peBpLtQJ6iNTML7rWKv07EXq42E7EqgK4WhNt-1MAyG8pMI_C8RZpC-KJmQU=w1624-h2000-no?authuser=0",
                bgColor: Theme.of(context).scaffoldBackgroundColor,
                comments: "3",
                downvotes: "4",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
