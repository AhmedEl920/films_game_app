import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game_app/core/constant/app_color.dart';
import 'package:game_app/core/constant/app_image.dart';

class GameRulesWidget extends StatelessWidget {
  const GameRulesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'قواعد اللعبة',
          style: textTheme.titleLarge?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
                  fontFamily: 'Amiri',
                  fontSize: 26,

          ),
        ),
    
        SizedBox(height: 8.h),
    
        RichText(
          textAlign: TextAlign.justify,
          text: TextSpan(

            style: textTheme.bodyMedium!.copyWith(fontFamily: 'Amiri',),
            children: [
              TextSpan(
                text: 'المكونات : ',
                style: textTheme.titleMedium!.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Amiri',
                ),
              ),
              const TextSpan(
                text:
                    'كروت صفراء للفريق الأول + كروت زرقاء للفريق الثاني + كروت حظ.',
                    style: TextStyle(fontFamily: 'Amiri',color: AppColors.black),
                    
                    
              ),
            ],
          ),
        ),
    
        SizedBox(height: 8.h),
    
        RichText(
          textAlign: TextAlign.justify,

          text: TextSpan(
            style: textTheme.bodyMedium!.copyWith(fontFamily: 'Amiri',),
            children: [
              TextSpan(
                text: 'طريقة اللعب : ',
                style: textTheme.titleMedium!.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Amiri',
                ),
              ),
              const TextSpan(
                text:
                    'يظهر للفريق كارت يقرأ محتواه، ثم يختار لاعبًا من الفريق المنافس ويبلغه بمحتوى الكارت. بعد ذلك يبدأ اللاعب المختار في تمثيل محتوى الكارت لفريقه بدون أي كلام. يجب على الفريق معرفة محتوى الكارت سواء كان فيلمًا أو مسلسلًا أو مسرحية قبل انتهاء الوقت المحدد.',
                    style: TextStyle(fontFamily: 'Amiri',color: AppColors.black),
              
              ),
            ],
          ),
        ),
    
        SizedBox(height: 8.h),
    
        RichText(
          textAlign: TextAlign.justify,
          text: TextSpan(
            style: textTheme.bodyMedium!.copyWith(fontFamily: 'Amiri',),
            children: [
              TextSpan(
                text: 'ازاي تكسب أنت وفريقك وتكونوا ملوك اللعبة : ',
                style: textTheme.titleMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TextSpan(
                text:
                    'يجب على الممثل أن يوصل محتوى الكارت لفريقه في الوقت المحدد. إذا نجح الفريق في معرفة الإجابة قبل انتهاء الوقت يحصل على نقطة، وتُضاف إلى رصيد الفريق. كما يجب على الممثل الالتزام بأوامر كارت الحظ إذا ظهر له أثناء أي جولة.',
                    style: TextStyle(fontFamily: 'Amiri',color: AppColors.black),
              
              ),
            ],
          ),
        ),
    
        SizedBox(height: 8.h),
    
        RichText(
          textAlign: TextAlign.justify,

          text: TextSpan(
            style: textTheme.bodyMedium!.copyWith(fontFamily: 'Amiri',),
            children: [
              TextSpan(
                text: 'كروت الحظ : ',
                style: textTheme.titleMedium!.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Amiri',
                ),
              ),
              const TextSpan(
                text:
                    'يتم تنفيذ كروت الحظ عندما يسحب الفريق كارتًا تظهر عليه علامة الحظ. عندها يسحب الفريق كارت الحظ ويطبّق التعليمات الموجودة عليه. يجب على الممثل الالتزام بأوامر كارت الحظ طوال الوقت المحدد، وإلا تُعتبر الجولة خاسرة.',
                    style: TextStyle(fontFamily: 'Amiri',color: AppColors.black),
              
              ),
            ],
          ),
        ),
    
        SizedBox(height: 12.h),
    
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AppImage.cardImage,
              width: 24.w,
              height: 24.h,
            ),
            SizedBox(width: 8.w),
            Text(
              'علامة كارت الحظ',
              style: textTheme.bodyMedium!.copyWith(
                fontFamily: 'Amiri',
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        SizedBox(height: 50.h),

      ],
      
    );
  }
}