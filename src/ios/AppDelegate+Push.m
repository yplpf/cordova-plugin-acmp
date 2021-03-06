//
//  AppDelegate+Push.m
//  PluginTest
//
//  Created by wangxianjin on 2017/9/14.
//  Copyright © 2017年 wangxianjin. All rights reserved.
//

#import "AppDelegate+Push.h"
#import <CloudPushSDK/CloudPushSDK.h>
#import "MainViewController.h"
#import <UserNotifications/UserNotifications.h>
#import "InitPlugin.h"

@implementation AppDelegate (Push)

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    self.viewController = [[MainViewController alloc] init];
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}


-(void)applicationDidEnterBackground:(UIApplication *)application{
}


/*
 *  苹果推送注册成功回调，将苹果返回的deviceToken上传到CloudPush服务器
 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"divicetoken:%@",deviceToken);
    [CloudPushSDK registerDevice:deviceToken withCallback:^(CloudPushCallbackResult *res) {
        if (res.success) {
            NSLog(@"Register deviceToken success.");
        } else {
            NSLog(@"Register deviceToken failed, error: %@", res.error);
        }
    }];
}
/*
 *  苹果推送注册失败回调
 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"didFailToRegisterForRemoteNotificationsWithError %@", error);
}



#pragma mark Notification Open
/*
 *  App处于启动状态时，通知打开回调
 */
- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo {
    
    NSLog(@"Receive one notification.");
    // 取得APNS通知内容
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    // 内容
    NSString *content = [aps valueForKey:@"alert"];
    // badge数量
    NSInteger badge = [[aps valueForKey:@"badge"] integerValue];
    // 播放声音
    NSString *sound = [aps valueForKey:@"sound"];
    // 取得通知自定义字段内容，例：获取key为"Extras"的内容
    NSString *Extras = [userInfo valueForKey:@"Extras"]; //服务端中Extras字段，key是自己定义的
    NSLog(@"content = [%@], badge = [%ld], sound = [%@], Extras = [%@]", content, (long)badge, sound, Extras);
    // iOS badge 清0
    application.applicationIconBadgeNumber =0;
    [CloudPushSDK sendNotificationAck:userInfo];
}




@end
