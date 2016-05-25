//
//  AppDelegate.h
//  TEXType
//
//  Created by Vrinsoft Macmini on 31/08/15.
//  Copyright (c) 2015 Vrinsoft Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,MBProgressHUDDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,retain) UINavigationController *navigation;
@property (strong, nonatomic) MBProgressHUD* HUD;
@property (nonatomic,retain)NSData *dataImage;
@property(strong,nonatomic)NSMutableArray *arrPaths;
@property(strong,nonatomic) NSMutableArray *ArrayImg;
@end

