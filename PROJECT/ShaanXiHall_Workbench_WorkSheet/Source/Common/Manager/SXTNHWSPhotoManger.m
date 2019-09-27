//
//  SXTNHWSPhotoManger.m
//  ShaanxiTransmissionNetworkHiddenWorkSheet
//
//  Created by tangji on 2019/8/12.
//  Copyright © 2019 Boco. All rights reserved.
//

#import "SXTNHWSPhotoManger.h"

#import "SXTNHWSHelper.h"

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import <TZImagePickerController/TZImagePickerController.h>

@interface SXTNHWSPhotoManger ()

<
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
TZImagePickerControllerDelegate
>

@property (nonatomic, strong)UIImagePickerController *imagePickerVc;
@property (nonatomic, assign)SXTNHWSPhotoBlock finish;

@end

@implementation SXTNHWSPhotoManger

HABM_DEFINE_SINGLETON(SXTNHWSPhotoManger)

/**
 *选图片
 */
- (void)SXTNHWSAlbumPhoto:(SXTNHWSPhotoBlock) finish
{
    if (finish) {
        self.finish = finish;
    }
    //判断相册权限
    if ([self checkPhotoLibraryPermissions]) {
        [self pushImagePickerController];
    }else{
        [SXTNHWSHelper showAlertControllerTitle:@"无法使用相测"
                                        message:@"请在iPhone的""设置-隐私-相册""中允许访问相册"
                                           sure:^{
                                               //跳转设置
                                           }
                                         cancel:^{
                                             
                                         }];
    }
}

/**
 *拍照
 */
- (void)SXTNHWSTakePhoto:(SXTNHWSPhotoBlock) finish
{
    if (finish) {
        self.finish = finish;
    }
    //判断相机权限
    if ([self checkPhotoCameraPermissions]) {
        //判断相册权限
        if ([self checkPhotoLibraryPermissions]) {
            [self pushImagePickerController];
        }else{
            [SXTNHWSHelper showAlertControllerTitle:@"无法使用相测"
                                            message:@"请在iPhone的""设置-隐私-相册""中允许访问相册"
                                               sure:^{
                                                   //跳转设置
                                                   [self jumpSystemOsUi];
                                               }
                                             cancel:^{
                                                 
                                             }];
        }
    }else{
        [SXTNHWSHelper showAlertControllerTitle:@"无法使用相机"
                                        message:@"请在iPhone的""设置-隐私-相机""中允许访问相机"
                                           sure:^{
                                               //跳转设置
                                               [self jumpSystemOsUi];
                                           }
                                         cancel:^{
                                               
                                           }];
    }
}

- (void)jumpSystemOsUi
{
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:@"App-Prefs:root=Photos"];
    if (@available(iOS 10, *)) {
        if ([application canOpenURL:URL]) {
            [application openURL:URL options:@{} completionHandler:^(BOOL success) {
            }];
        }
    }else{
        if ([application canOpenURL:URL]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
                [application openURL:URL];
#pragma clang diagnostic pop
            }
    }
}

- (void)pushImagePickerController
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVc.sourceType = sourceType;
        NSMutableArray *mediaTypes = [NSMutableArray array];
//        if (self.showTakeVideoBtnSwitch.isOn) {
//            [mediaTypes addObject:(NSString *)kUTTypeMovie];
//        }
//        if (self.showTakePhotoBtnSwitch.isOn) {
//            [mediaTypes addObject:(NSString *)kUTTypeImage];
//        }
        if (mediaTypes.count) {
            _imagePickerVc.mediaTypes = mediaTypes;
        }
        [[SXTNHWSHelper activityViewController] presentViewController:_imagePickerVc animated:YES completion:nil];
    } else {
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}

- (void)pushTZImagePickerController
{
    SXTNHWSWeakSelf;
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9
                                                                                        columnNumber:0
                                                                                            delegate:self
                                                                                   pushPhotoPickerVc:YES];
 
//    imagePickerVc.scaleAspectFillCrop = YES;
//    imagePickerVc.statusBarStyle = UIStatusBarStyleLightContent;
    // 设置是否显示图片序号
//    imagePickerVc.showSelectedIndex = YES;
#pragma mark - 到这里为止
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        if (weakSelf.finish) {
            weakSelf.finish(photos);
        }
    }];
    
    [[SXTNHWSHelper activityViewController] presentViewController:imagePickerVc
                                                         animated:YES
                                                       completion:nil];
}

- (BOOL)checkPhotoLibraryPermissions
{
    
    PHAuthorizationStatus photoAuthorStatus = [PHPhotoLibrary authorizationStatus];
    BOOL status = YES;
    switch (photoAuthorStatus) {
            case PHAuthorizationStatusAuthorized://用户已经授权应用访问照片数据
            NSLog(@"Authorized");
            status = YES;
            break;
            case PHAuthorizationStatusDenied://用户已经明确否认了这一照片数据的应用程序访问
            status = YES;
            NSLog(@"Denied");
            break;
            case PHAuthorizationStatusNotDetermined://此应用程序没有被授权访问的照片数据
            NSLog(@"not Determined");
            break;
            case PHAuthorizationStatusRestricted://默认还没做出选择
            NSLog(@"Restricted");
            break;
        default:
            break;
    }
    return status;
}

- (BOOL)checkPhotoCameraPermissions
{
    
    AVAuthorizationStatus AVstatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];//相机权限
//    AVAuthorizationStatus AVstatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];//麦克风权限
    BOOL status = YES;
    switch (AVstatus) {
            case AVAuthorizationStatusAuthorized://允许状态
            NSLog(@"Authorized");
            status = YES;
            break;
            case AVAuthorizationStatusDenied://不允许
            NSLog(@"Denied");
            status = NO;
            break;
            case AVAuthorizationStatusNotDetermined://系统还未知是否访问，第一次开启相机时
            NSLog(@"not Determined");
            status = YES;
            break;
            case AVAuthorizationStatusRestricted://受限制的
            NSLog(@"Restricted");
            status = NO;
            break;
        default:
            break;
    }
    return status;
}

#pragma mark delegate
#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage * infoImage = [info objectForKey:UIImagePickerControllerEditedImage];
    if (self.finish) {
        self.finish(infoImage);
    }
}



#pragma mark setter/getter
- (UIImagePickerController *)imagePickerVc
{
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor = [SXTNHWSHelper activityViewController].navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = [SXTNHWSHelper activityViewController].navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (@available(iOS 9, *)) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
#pragma clang diagnostic pop
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
        
    }
    return _imagePickerVc;
}

@end
