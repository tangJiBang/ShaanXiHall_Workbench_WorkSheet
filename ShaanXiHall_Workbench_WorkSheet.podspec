
Pod::Spec.new do |s|
s.name         = "ShaanXiHall_Workbench_WorkSheet"
s.version      = "0.0.1"
s.summary      = "A short description of ShaanXiHall_Workbench_WorkSheet."
s.description  = <<-DESC
                A short description of ShaanXiHall_Workbench_WorkSheet.
               DESC

s.homepage         = 'https://github.com/tangJiBang/ShaanXiHall_Workbench_WorkSheet.git'
s.license      = 'MIT'
s.author       = { "tangji" => "tangji@boco.com.cn" }
s.source       = { :git => 'https://github.com/tangJiBang/ShaanXiHall_Workbench_WorkSheet.git', :tag => s.version.to_s }
s.ios.deployment_target = '9.0'
s.requires_arc = true

# s.resources  = ["PROJECT/Source/**/*.{xib}","PROJECT/Resource/xcassets/ShaanxiTransmissionNetworkHiddenWorkSheet.xcassets"]
# s.resource_bundles = {
#     'ShaanxiTransmissionNetworkHiddenWorkSheet_xib' => ["PROJECT/Source/**/*.{xib}"],
#     'ShaanxiTransmissionNetworkHiddenWorkSheet_xcassets' => ["PROJECT/Resource/xcassets/ShaanxiTransmissionNetworkHiddenWorkSheet.xcassets"]
#   }
#s.source_files  = "PROJECT/Source/**/*.{h,m}"
#s.static_framework = true
s.vendored_frameworks = ["ShaanXiHall_Workbench_WorkSheet/Source/Frameworks/ShaanXiHall_Workbench_WorkSheet.framework"]

#Haidora
s.dependency 'HaidoraProgressHUDManager', '~> 0.1.1'
s.dependency 'HaidoraAlertViewManager', '~> 0.1.1'
s.dependency 'HaidoraRefresh', '~> 0.1.6'
s.dependency 'HaidoraActionView', '~> 1.1'
#Boco基础业务数据.(用户信息).
s.dependency 'BocoBusiness', '~> 0.1.5'
#Boco证书需要添加
#s.dependency 'BocoDemo', '~> 0.1.3'
#Boco库
s.dependency 'BocoFormManager', '~> 0.1.18'
#自动布局
s.dependency 'Masonry', '~> 1.1.0'
s.dependency 'SDAutoLayout', '~> 2.1.7' 
#其他
s.dependency 'YYModel', '~> 1.0.4'
s.dependency 'YYCache', '~> 1.0.4'
s.dependency 'IQKeyboardManager', '~> 4.0.13'
s.dependency 'FMDB', '~> 2.7.5'
s.dependency 'Aspects', '~> 1.4.1'
s.dependency 'YBPopupMenu', '~> 1.1.2'
s.dependency 'PromisesObjC', '~> 1.1.1'
s.dependency 'WMPageController', '~> 2.3.0'
s.dependency 'BocoRolePicker', '~> 0.2.3'
s.dependency 'YBPopupMenu', '~> 1.1.2'
s.dependency 'SCLAlertView-Objective-C', '~> 1.1.6'
s.dependency 'TZImagePickerController', '~> 1.8.9'
s.dependency 'BocoUpdate','~>1.0.2'
s.dependency 'DZNEmptyDataSet','~>1.7.2'
#加密
s.dependency 'BocoCryptoAssistant' , '~> 0.1.1'
s.dependency 'BocoCertificationAssistant' , '0.1.3'
s.dependency 'CocoaSecurity', '~> 1.2.4'
#Bmdp服务(jar请放在jars下面)
s.dependency 'BocoJTI', '~> 0.4.18'
s.dependency 'BocoJTIRetrofit', '~> 0.1.4'

end


