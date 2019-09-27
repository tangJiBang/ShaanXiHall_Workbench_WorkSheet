//
//  SXTNHWSMacros.h
//  ShaanxiTransmissionNetworkHiddenWorkSheet
//
//  Created by tangji on 2019/7/4.
//  Copyright © 2019 Boco. All rights reserved.
//

#ifndef SXTNHWSMacros_h
#define SXTNHWSMacros_h

#undef  HABM_ASSIGN_SINGLETON
#define HABM_ASSIGN_SINGLETON(__classname)\
-(__classname *)sharedInstance;\
+(__classname *)sharedInstance;

#undef  HABM_DEFINE_SINGLETON
#define HABM_DEFINE_SINGLETON(__classname)\
static __classname *shared##__classname = nil;\
-(__classname *)sharedInstance\
{\
return [__classname sharedInstance];\
}\
+(__classname *)sharedInstance\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^\
{\
shared##__classname = [[[self class] alloc] init];\
});\
return shared##__classname;\
}


#define Default_TimeFormat @"YYYY-MM-dd HH:mm:ss"

#define IDENTFIER @"CELL"
#define IDENTFIERTWO @"CELLTWO"


#define String_Equal(string1,string2) [string1 isEqualToString:string2]

#define Dictory_Null(dict,key) [dict valueForKey:key] == [NSNull null]?@"":[dict valueForKey:key]

#define Dictory_NullOrNo(dict,key) [dict valueForKey:key] == [NSNull null] || ![dict.allKeys containsObject:key]?@"":[dict valueForKey:key]

#define Dictory_responseObject(dict,key) [dict valueForKey:key] == [NSNull null] || ![dict.allKeys containsObject:key]?nil:[dict valueForKey:key]

#define String_Splice(string1,string2)  [NSString stringWithFormat:@"%@%@", string1, string2]

#define SXTNHWSShowAlerView(content) [HDAlertViewManager alertWithTitle:@"提示" message:content cancelTitle:@"确定"]

#define SXTNHWSWeakSelf __weak __typeof(self) weakSelf = self
#define SXTNHWSStrongSelf __strong __typeof(self) strongSelf = self


#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height

#define SXTNHWS_Color(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]

#define SXTNHWS_FloatColor(r,g,b) [UIColor colorWithRed:r green:g blue:b alpha:1.0f]

#define magrn 10.0f

#define kBtnTag 300

#define SXTNHWSUserName     [BocoUserAgent sharedInstance].currentUser.userName
#define SXTNHWSUserId [BocoUserAgent sharedInstance].currentUser.userId

#define String_null(str)  str?str:@""

#define SXTNHWS_MAIN_COLOR [UIColor colorWithRed:0.11f green:0.51f blue:0.82f alpha:1.0f]

#define iOS7Later ([UIDevice currentDevice].systemVersion.floatValue >= 7.0f)
#define iOS8Later ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f)
#define iOS9Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)
#define iOS9_1Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.1f)


#define FONT9 [UIFont systemFontOfSize:9.0f]
#define FONT10 [UIFont systemFontOfSize:10.0f]
#define FONT11 [UIFont systemFontOfSize:11.0f]
#define FONT12 [UIFont systemFontOfSize:12.0f]
#define FONT13 [UIFont systemFontOfSize:13.0f]
#define FONT14 [UIFont systemFontOfSize:14.0f]
#define FONT15 [UIFont systemFontOfSize:15.0f]
#define FONT16 [UIFont systemFontOfSize:16.0f]
#define FONT17 [UIFont systemFontOfSize:17.0f]


/**机型判断适配*/
//iPhoneX / iPhoneXS
#define  isIphoneX_XS     (ScreenWidth == 375.f && ScreenHeight == 812.f ? YES : NO)
//iPhoneXR / iPhoneXSMax
#define  isIphoneXR_XSMax    (ScreenWidth == 414.f && ScreenHeight == 896.f ? YES : NO)
//异性全面屏
#define   isFullScreen    (isIphoneX_XS || isIphoneXR_XSMax)

// Status bar height.
#define  StatusBarHeight     (isFullScreen ? 44.f : 20.f)

// Navigation bar height.
#define  NavigationBarHeight  44.f

// Tabbar height.
#define  TabbarHeight         (isFullScreen ? (49.f+34.f) : 49.f)

// Tabbar safe bottom margin.
#define  TabbarSafeBottomMargin         (isFullScreen ? 34.f : 0.f)

// Status bar & navigation bar height.
#define  StatusBarAndNavigationBarHeight  (isFullScreen ? 88.f : 64.f)


#endif /* SXTNHWSMacros_h */
