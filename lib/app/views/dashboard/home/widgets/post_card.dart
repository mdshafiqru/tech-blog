// ignore_for_file: prefer_const_constructors

import 'package:blog/app/constants/api_string.dart';
import 'package:blog/app/controllers/dashboard/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/helper_function.dart';
import '../../../../models/auth/user.dart';
import '../../../../models/dashboard/post.dart';
import '../../../../models/dashboard/post_category.dart';
import '../../posts/edit_post/edit_post_view.dart';
import '../post_details_view.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.post,
    required this.index,
    required this.deletedPosts,
    required this.savedPosts,
  });

  final Post post;
  final int index;
  final bool deletedPosts;
  final bool savedPosts;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => PostDetailsView(post: post));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        elevation: 3,
        child: Padding(
          padding: EdgeInsets.all(8.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _title(context),
              SizedBox(height: 5.w),
              _name(),
              _category(),
              SizedBox(height: 20.w),
              _description(),
              SizedBox(height: 5.w),
              _thumbnail(),
              SizedBox(height: 5.w),
              _likeComment(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _likeComment() {
    bool isLiked = post.isLiked ?? false;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: MaterialButton(
            onPressed: () {
              Get.find<PostController>().likeUnlike(post.id ?? "", index);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite, size: 22.w, color: isLiked ? kBaseColor : Colors.black87),
                SizedBox(width: 5.w),
                Text("${post.likeCount}", style: TextStyle(fontSize: 15.sp)),
              ],
            ),
          ),
        ),
        Text(
          "|",
          style: TextStyle(fontSize: 20.sp),
        ),
        Expanded(
          child: MaterialButton(
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.comment, size: 22.w, color: Colors.black87),
                SizedBox(width: 5.w),
                Text("${post.commentCount}", style: TextStyle(fontSize: 15.sp)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _thumbnail() {
    var thumbnail = post.thumbnail ?? "";

    var thumbnailLink = imageBaseUrl + thumbnail;

    return thumbnail.isEmpty
        ? Container()
        : SizedBox(
            child: Image.network(
              thumbnailLink,
              width: double.infinity,
              height: 180.w,
              fit: BoxFit.cover,
            ),
          );
  }

  Text _description() {
    return Text(
      post.description ?? "",
      style: TextStyle(fontSize: 14.sp),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.justify,
    );
  }

  Widget _name() {
    var user = post.user != null ? post.user as User : User();
    var avatar = user.avatar ?? "";
    var avatarLink = imageBaseUrl + avatar;

    return Row(
      children: [
        if (avatar.isEmpty) Icon(Icons.person, size: 18.sp),
        if (avatar.isNotEmpty)
          Container(
            width: 15.w,
            height: 15.w,
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(avatarLink),
                fit: BoxFit.cover,
              ),
            ),
          ),
        SizedBox(width: 5.w),
        Text(
          user.name ?? "",
          style: TextStyle(fontSize: 12.sp),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _category() {
    var category = post.category != null ? post.category as PostCategory : PostCategory();

    return Row(
      children: [
        Expanded(child: Text(category.name ?? "", style: TextStyle(fontSize: 12.sp))),
        Text(getCustomDate(post.createdAt ?? ""), style: TextStyle(fontSize: 12.sp)),
      ],
    );
  }

  Widget _title(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            post.title ?? "",
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        PopupMenuButton(
          onSelected: (value) {
            switch (value) {
              case 'save':
                Get.find<PostController>().savePost(post.id ?? "");
                break;
              case 'remove':
                Get.find<PostController>().removeSavedPost(post.id ?? "", index);
                break;
              case 'edit':
                Get.to(() => EditPostView(post: post));
                break;
              case 'delete':
                Get.find<PostController>().deletePost(post.id ?? "", index);
                break;
              case 'delete_permanent':
                Get.find<PostController>().deletePostPermanently(post.id ?? "", index);
                break;
              default:
            }
          },
          itemBuilder: (context) {
            User owner = post.user != null ? post.user as User : User();

            return <PopupMenuItem>[
              if (owner.id != userId && !savedPosts)
                PopupMenuItem(
                  value: 'save',
                  child: Text("Save", style: TextStyle(fontSize: 13.sp)),
                ),
              if (owner.id != userId && savedPosts)
                PopupMenuItem(
                  value: 'remove',
                  child: Text("Remove", style: TextStyle(fontSize: 13.sp)),
                ),
              if (owner.id == userId && !deletedPosts)
                PopupMenuItem(
                  value: 'edit',
                  child: Text("Edit", style: TextStyle(fontSize: 13.sp)),
                ),
              if (owner.id == userId && !deletedPosts)
                PopupMenuItem(
                  value: 'delete',
                  child: Text("Delete", style: TextStyle(fontSize: 13.sp)),
                ),
              if (owner.id == userId && deletedPosts)
                PopupMenuItem(
                  value: 'delete_permanent',
                  child: Text("Delete Permanently", style: TextStyle(fontSize: 13.sp)),
                ),
            ];
          },
        ),
      ],
    );
  }
}
