import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/post_provider.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/material.dart';

Widget postStatusWidget(BuildContext context, AuthProvider authProvider,
    PostProvider postProvider, bool isLoading, int status) {
  return Container(
    padding: const EdgeInsets.only(left: 10, right: 10),
    height: 50,
    width: double.infinity,
    child: Card(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            child: Image.network(authProvider.profileImage),
          ),
          const SizedBox(
            width: 10,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(status==1?"Opps! Failed":isLoading?"Posting....":"Posted",style: latoStyle700Bold,),

          Expanded(
            child: status == 1
                ? Row(
              crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: InkWell(
                              onTap: () {
                                postProvider.disCardPost();
                              },
                              child: const Text('Discard'))),
                      TextButton(
                          onPressed: () {},
                          child: InkWell(
                              onTap: () {
                                postProvider.addPost(postProvider.body);
                              },
                              child:const Text('Retry')))
                    ],
                  )
                : const Text(''),
          )
        ],
      ),
    ),
  );
}
