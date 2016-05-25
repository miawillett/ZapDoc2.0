//
//  ViewController.h
//  TesseractSample
//
//  Created by Ângelo Suzuki on 11/1/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <CoreText/CoreText.h>
#import "Client.h"
#import <Availability.h>
#import "HomeVC.h"
@class MBProgressHUD;


@interface ViewController : UIViewController<MFMailComposeViewControllerDelegate,UITextViewDelegate,UIGestureRecognizerDelegate,UIPrintInteractionControllerDelegate,UIPrinterPickerControllerDelegate,UIPrintInteractionControllerDelegate,ClientDelegate>
{
    MBProgressHUD *progressHud;
    NSString *shareTitle;
    uint32_t *pixels;
    IBOutlet UIButton *btnShare,*btnBack,*btnBold,*btnItalic,*btnUnderline,*btnSave;
    IBOutlet UITextView *txtViewData;
    IBOutlet UIView *viewEditText;
    IBOutlet UIScrollView *scrlText;
    IBOutlet UIView *viewFilenameSave;
    IBOutlet UILabel *fileName_LBL;
    IBOutlet UITextField *fileName_TF;
    IBOutlet UIButton *saveOk_BTN;
    int a,b,underLine_Flag;
    IBOutlet UIImageView *imageView;
}

@property (nonatomic, retain) NSString *shareTitle; 

@property (nonatomic, strong) MBProgressHUD *progressHud;
@property(nonatomic,retain)UIView *dimBackGround;
@property(nonatomic,retain)UIView *customActionSheet;

- (IBAction)createPDF:(id)sender;
- (void)drawPageNbr:(int)pageNumber;
- (CFRange *)updatePDFPage:(int)pageNumber setTextRange:(CFRange *)pageRange setFramesetter:(CTFramesetterRef *)framesetter;
-(IBAction)printdoc:(id)sender;

@end
