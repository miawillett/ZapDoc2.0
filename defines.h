//
//  defines.h
//  BookApplication
//
//  Created by Vrinsoft Macmini on 01/01/14.
//  Copyright (c) 2014 Vrinsoft Macmini. All rights reserved.
//
#import "AppDelegate.h"
#ifndef BookApplication_defines_h
#define BookApplication_defines_h

#define APP_DELEGATE ((AppDelegate*)[[UIApplication sharedApplication] delegate])


#define showAlert(title,amessage) UIAlertView *alert=[[UIAlertView alloc]initWithTitle:title message:amessage delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];[alert show];



//for iphone 4 or 5
#define IS_IPHONE ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone )
#define IS_HEIGHT_GTE_568 ([[UIScreen mainScreen ] bounds].size.height >= 568.0f)

#define IS_HEIGHT_480 ([[UIScreen mainScreen ] bounds].size.height <= 480.0f)

#define IS_IPHONE_5 ( IS_IPHONE && IS_HEIGHT_GTE_568 )
#define IOS_6  ([[[UIDevice currentDevice] systemVersion] floatValue]<7)
#define IS_Ios7 ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0)


#define IS_IPHONE_4_OR_LESS ([[UIScreen mainScreen ] bounds].size.height <= 568.0f)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)


#define AlertTitle @"Alert"
#define AlertInternet @"Please check your internet connection"
#define AlertNoresult @"No data found"
#define AlertServerError @"Can not connected to server please try again later"
#define AppFontNameBold @"Aleo-Bold"
#define AppFontNameRegular @"Aleo-Regular"
#define AppFontNameLight @"Aleo-Light"
#define AppFontABRegular @"ABeeZee-Regular"
#define AppFontRobot @"Roboto-Condensed"
#define backImg @"back.png"




// api
#define MAINURL @"http://203.124.107.14:33/CleaningWebservice.asmx/"
//http://vrinsoft.com/comfortsuites/admin/


#define setBackButton() UIImage *imgBack=[UIImage imageNamed:backImg];UIButton *btnCustom=[UIButton buttonWithType:UIButtonTypeCustom];[btnCustom setImage:imgBack forState:UIControlStateNormal];[btnCustom addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];btnCustom.frame = CGRectMake(0.0, 0.0, imgBack.size.width, imgBack.size.height);UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithCustomView:btnCustom];self.navigationItem.leftBarButtonItem=backBtn;



#define backAction()[self.navigationController popViewControllerAnimated:YES];


#endif

//#define BackButtonForNav(imagename,delegate,selector)                                                     UIImage *imgBack=[UIImage imageNamed:backImg];                                         UIButton *btnCustom=[UIButton buttonWithType:UIButtonTypeCustom];                         [btnCustom setImage:imagename forState:UIControlStateNormal];                       [btnCustom addTarget:delegate action:@selector(selector:) forControlEvents:UIControlEventTouchUpInside];                                                    btnCustom.frame =CGRectMake(0.0, 0.0, imgBack.size.width, imgBack.size.height);UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithCustomView:btnCustom];return backBtn;
//



// for custom table
//#define LblTitleFrame (CGRectMake(20, 10, 280, 30));

