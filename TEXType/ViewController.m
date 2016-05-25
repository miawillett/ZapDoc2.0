//
//  ViewController.m
//  TesseractSample
//
//  Created by Ângelo Suzuki on 11/1/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//



#import "AppDelegate.h"

//#error Provide Application ID and Password
// To create an application and obtain a password,
// register at http://cloud.ocrsdk.com/Account/Register
// More info on getting your application id and password at
// http://ocrsdk.com/documentation/faq/#faq3

// Name of application you created
static NSString* MyApplicationID = @"Textype App OCR";
// Password should be sent to your e-mail after application was created
static NSString* MyPassword = @"EGq+Of4XjkboK0sClZIoO7c5";





#import "ViewController.h"
#import "MBProgressHUD.h"
#import "defines.h"
#include <math.h>

//static inline double radians (double degrees) {return degrees * M_PI/180;}


@implementation ViewController

@synthesize progressHud;

@synthesize shareTitle;


- (void)viewDidLoad
{
    a=1;
    b=1;
 
    [super viewDidLoad];
    [APP_DELEGATE.HUD hide:YES];
    
    [viewFilenameSave setHidden:YES];
    [self setupCustomActionSheet];
    //self.view.hidden=true;

    if (IS_HEIGHT_480)
    {
        scrlText.frame = CGRectMake(scrlText.frame.origin.x, scrlText.frame.origin.y, scrlText.frame.size.width, 366);
        
        scrlText.contentSize = CGSizeMake(scrlText.frame.size.width, scrlText.frame.size.height+100);
        
    }
    
    UIImage *image = [[UIImage alloc] initWithData:APP_DELEGATE.dataImage];
    //image = gs_convert_image(image);
    
//    imageView.image=image;
    //image = gs_convert_image(imageView.image);
    
    
//    UIImage *image = [UIImage imageWithData:APP_DELEGATE.dataImage];
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
//    imageView.frame = self.view.frame;
//    imageView.contentMode = UIViewContentModeScaleAspectFit;
//    [self.view addSubview:imageView];
//    //[self.view addSubview:viewEditText];
    self.progressHud = [[MBProgressHUD alloc] initWithView:self.view];
    
    [self.progressHud show:YES];
    
    self.progressHud.labelText = @"Processing";
    imageView.hidden=true;
    viewEditText.hidden=false;
    [self.view addSubview:self.progressHud];
    
    
    
    self.progressHud.labelText = @"Loading image...";
    
    Client *client = [[Client alloc] initWithApplicationID:MyApplicationID password:MyPassword];
    [client setDelegate:self];
    
    if([[NSUserDefaults standardUserDefaults] stringForKey:@"installationID"] == nil) {
        NSString* deviceID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        
        NSLog(@"First run: obtaining installation ID..");
        NSString* installationID = [client activateNewInstallation:deviceID];
        NSLog(@"Done. Installation ID is \"%@\"", installationID);
        
        [[NSUserDefaults standardUserDefaults] setValue:installationID forKey:@"installationID"];
    }
    
    NSString* installationID = [[NSUserDefaults standardUserDefaults] stringForKey:@"installationID"];
    if([installationID length] == 0 || installationID == nil)
    {
        self.progressHud.hidden = YES;
        return;
    }
    
    client.applicationID = [client.applicationID stringByAppendingString:installationID];
    
    ProcessingParams* params = [[ProcessingParams alloc] init];
    
    [client processImage:image withParams:params];
    
    self.progressHud.labelText = @"Uploading image...";
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(myKeyboardWillHideHandler:)
    						                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void) myKeyboardWillHideHandler:(NSNotification *)notification
{
    txtViewData.frame = CGRectMake(txtViewData.frame.origin.x, txtViewData.frame.origin.y, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64 - 50);
}


- (void)viewDidAppear:(BOOL)animated
{
    
    
    [super viewDidAppear:animated];
}


- (void)viewWillAppear:(BOOL)animated
{
    underLine_Flag = 0;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    txtViewData.frame=CGRectMake(txtViewData.frame.origin.x, txtViewData.frame.origin.y, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height - 64 - 50);
    
    if (![self.progressHud isHidden])
        [self.progressHud hide:NO];
    self.progressHud = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



#pragma mark - ClientDelegate implementation

- (void)clientDidFinishUpload:(Client *)sender
{
    self.progressHud.labelText = @"Processing image...";
    NSLog(@"Processing image...");
}

- (void)clientDidFinishProcessing:(Client *)sender
{
    self.progressHud.labelText = @"Downloading result...";
    NSLog(@"Downloading result...");
}

- (void)client:(Client *)sender didFinishDownloadData:(NSData *)downloadedData
{
    [self.progressHud hide:YES];
    NSString* result = [[NSString alloc] initWithData:downloadedData encoding:NSUTF8StringEncoding];
    
    txtViewData.text = result;
}

- (void)client:(Client *)sender didFailedWithError:(NSError *)error
{
    [self.progressHud hide:YES];
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                    message:[error localizedDescription]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil];
    
    [alert show];
    
    [self.navigationController popViewControllerAnimated:YES];
//    statusLabel.text = [error localizedDescription];
//    statusIndicator.hidden = YES;
}



#pragma mark - Gray Scale Image
UIImage * gs_convert_image (UIImage * src_img) {
    CGColorSpaceRef d_colorSpace = CGColorSpaceCreateDeviceRGB();
    /*
     * Note we specify 4 bytes per pixel here even though we ignore the
     * alpha value; you can't specify 3 bytes per-pixel.
     */
    size_t d_bytesPerRow = src_img.size.width * 4;
    unsigned char * imgData = (unsigned char*)malloc(src_img.size.height*d_bytesPerRow);
    CGContextRef context =  CGBitmapContextCreate(imgData, src_img.size.width,
                                                  src_img.size.height,
                                                  8, d_bytesPerRow,
                                                  d_colorSpace,
                                                  kCGImageAlphaNoneSkipFirst);
    
    UIGraphicsPushContext(context);
    // These next two lines 'flip' the drawing so it doesn't appear upside-down.
    CGContextTranslateCTM(context, 0.0, src_img.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    // Use UIImage's drawInRect: instead of the CGContextDrawImage function, otherwise you'll have issues when the source image is in portrait orientation.
    [src_img drawInRect:CGRectMake(0.0, 0.0, src_img.size.width, src_img.size.height)];
    UIGraphicsPopContext();
    
    /*
     * At this point, we have the raw ARGB pixel data in the imgData buffer, so
     * we can perform whatever image processing here.
     */
    
    
    // After we've processed the raw data, turn it back into a UIImage instance.
    CGImageRef new_img = CGBitmapContextCreateImage(context);
    UIImage * convertedImage = [[UIImage alloc] initWithCGImage:
                                new_img];
    
    CGImageRelease(new_img);
    CGContextRelease(context);
    CGColorSpaceRelease(d_colorSpace);
    free(imgData);
    return convertedImage;
}



-(void) addToolBatOnTopOfTextView:(UITextView *) textView
{
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    if (!IOS_6)
        toolbar.barStyle = UIBarStyleDefault;
    else
        toolbar.barStyle = UIBarStyleBlackTranslucent;
    toolbar.barTintColor = [UIColor lightGrayColor];
    [toolbar sizeToFit];
    
    UIBarButtonItem *flexButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(donBtnTappedForResignKeyboard)];
    [doneButton setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    
    NSArray *itemsArray = [NSArray arrayWithObjects:flexButton, doneButton, nil];
    [toolbar setItems:itemsArray];
    [textView setInputAccessoryView:toolbar];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    
    [self addToolBatOnTopOfTextView:textView];
    
    textView.frame = CGRectMake(textView.frame.origin.x, textView.frame.origin.y, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64 - 50 - 270);
    
    
    return YES;
}

#pragma mark - Onclick
-(void) donBtnTappedForResignKeyboard
{
    
    [txtViewData resignFirstResponder];
    if (!IS_HEIGHT_GTE_568)
    {
        
        
        scrlText.contentSize = CGSizeMake(320, scrlText.frame.size.height);
        
    }
    
    [UIScrollView beginAnimations:nil context:nil];
    [UIScrollView setAnimationDuration:0.7];
    scrlText.contentOffset=CGPointMake(0, 0);
    [UIScrollView commitAnimations];
}

-(IBAction)OnClickBtn:(id)sender
{
   
    UIFontDescriptor * fontD = [txtViewData.font.fontDescriptor
                                fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold
                                | UIFontDescriptorTraitItalic];
    
    if ([sender tag]==1)
    {
        //Share
        
        [UIView animateWithDuration:0.40 delay: 0.0 options: UIViewAnimationOptionCurveEaseIn animations:^{
            self.dimBackGround.alpha = 1.0f;
            self.customActionSheet.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 280, self.view.frame.size.width, 280);
        } completion:^(BOOL finished) {
        }];
    }
    else if ([sender tag]==2)
    {
        //Back
        [APP_DELEGATE.HUD show:YES];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        [self didReceiveMemoryWarning];
    }
    else if ([sender tag]==3)
    {
        //Bold
        if (a==1) {
            txtViewData.font=[UIFont boldSystemFontOfSize:14.0];
            
            a=2;
            if (b==2) {
                txtViewData.font = [UIFont fontWithDescriptor:fontD size:14.0];
            }
        }
        else
        {
            if (b==2) {
                txtViewData.font=[UIFont italicSystemFontOfSize:14.0 ];
            }
            else
            {
                txtViewData.font=[UIFont systemFontOfSize:14.0];
            }
            a=1;
        }
        
    }
    else if ([sender tag]==4)
    {
        //Italic
        if (b==1) {
            txtViewData.font=[UIFont italicSystemFontOfSize:14.0 ];
            b=2;
            if (a==2) {
                txtViewData.font = [UIFont fontWithDescriptor:fontD size:14.0];
            }
        }
        else
        {
            if (a==2) {
                txtViewData.font=[UIFont boldSystemFontOfSize:14.0 ];
            }
            else
            {
                txtViewData.font=[UIFont systemFontOfSize:14.0];
            }
            b=1;
        }
        
    }
    else if ([sender tag]==5)
    {
        //Underline
        
        if (underLine_Flag) {
            NSMutableAttributedString *attributedString = [txtViewData.attributedText mutableCopy];
            int valueToSet = NSUnderlineStyleNone;
            [attributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:valueToSet] range:NSMakeRange(0, txtViewData.text.length)];
            
            txtViewData.attributedText = attributedString;
            underLine_Flag = 0;
        }
        else
        {
            NSMutableAttributedString *attributedString = [txtViewData.attributedText mutableCopy];
            int valueToSet = NSUnderlineStyleSingle;
            [attributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:valueToSet] range:NSMakeRange(0, txtViewData.text.length)];
            
            txtViewData.attributedText = attributedString;
            underLine_Flag = 1;
        }
    }
    else
    {
        //Save
        
    }
}

-(IBAction)OnClickTap:(id)sender
{
    [self closeCustomActionSheetWithTime:0.7];
}

-(IBAction)OnClickShare:(id)sender
{
    
    [self closeCustomActionSheetWithTime:1.0];
    
    if ([sender tag] == 1001)
    {
        
        [self postToFacebook:nil];
    }
    else if ([sender tag] == 1002)
    {
        [self postToTwitter:nil];
       
    }
    else if ([sender tag] == 1003)
    {
        [self sendEmailAction:nil];
    }
    else if ([sender tag] == 1004)
    {
        //Copy
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = txtViewData.text;
    }
    else if ([sender tag] == 1005)
    {
        //Print
    }
    else
    {
        [self OnClickTap:nil];
    }

}

- (IBAction)postToFacebook:(id)sender
{
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [controller setInitialText:txtViewData.text];
        [self presentViewController:controller animated:YES completion:Nil];
    }
    else
    {
        showAlert(AlertTitle, @"It seems that we cannot talk to Facebook at the moment or you have not yet added your Facebook account to this device. Go to the Settings application to add your Facebook account to this device.");
    }
    
}

- (IBAction)postToTwitter:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:txtViewData.text];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else
    {
        showAlert(AlertTitle, @"It seems that we cannot talk to Twitter at the moment or you have not yet added your Twitter account to this device. Go to the Settings application to add your Twitter account to this device.");
    }
}

- (IBAction)sendEmailAction:(UIButton *)sender
{
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
        mail.mailComposeDelegate = self;
        [mail setSubject:@"Copy Doc"];
        [mail setMessageBody:txtViewData.text isHTML:NO];
        [mail setToRecipients:@[@""]];
        
        [self presentViewController:mail animated:YES completion:NULL];
    }
    else
    {
        showAlert(AlertTitle,@"You do not have mail account configured on this device." );
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            
            NSLog(@"Mail sending canceled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail Saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sending failed");
            break;
        default:
            NSLog(@"Mail not sent");
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(IBAction)printdoc:(id)sender
{
    [self closeCustomActionSheetWithTime:1.0];
    
    UIPrintInteractionController *pic = [UIPrintInteractionController sharedPrintController];
    pic.delegate = self;
    
    UIPrintInfo *printInfo = [UIPrintInfo printInfo];
    printInfo.outputType = UIPrintInfoOutputGeneral;
    printInfo.jobName=@"Copy Doc";
    pic.printInfo = printInfo;
    NSString *strData = txtViewData.text;
    UISimpleTextPrintFormatter *textFormatter = [[UISimpleTextPrintFormatter alloc]
                                                 initWithText:strData];
    textFormatter.startPage = 0;
    textFormatter.contentInsets = UIEdgeInsetsMake(72.0, 72.0, 72.0, 72.0); // 1 inch margins
    textFormatter.maximumContentWidth = 6 * 72.0;
    pic.printFormatter = textFormatter;
//    [textFormatter release];
    pic.showsPageRange = YES;
    
    void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) =
    ^(UIPrintInteractionController *printController, BOOL completed, NSError *error) {
        if (!completed && error) {
            showAlert(AlertTitle,@"Printing could not complete because of error");
            NSLog(@"Printing could not complete because of error: %@", error);
        }
    };
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [pic presentFromBarButtonItem:sender animated:YES completionHandler:completionHandler];
    } else {
        [pic presentAnimated:YES completionHandler:completionHandler];
    }
    
}

#pragma mark - Custom Action Sheet
-(void)setupCustomActionSheet
{
    
    NSLog(@"%f",[UIScreen mainScreen].bounds.size.width + 250);
    
    self.dimBackGround = [[UIView alloc] init];
    self.dimBackGround.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    self.dimBackGround.backgroundColor = [UIColor blackColor];
    self.dimBackGround.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.5f];
    [APP_DELEGATE.window addSubview:self.dimBackGround];
    self.dimBackGround.alpha = 0.0f;
    
    self.customActionSheet = [[UIView alloc] init];
    self.customActionSheet.frame = CGRectMake(0, 1005, [UIScreen mainScreen].bounds.size.width, 280);
    self.customActionSheet.backgroundColor = [UIColor clearColor];
    [self.dimBackGround addSubview:self.customActionSheet];
    
    UIButton *btnFBShare = [UIButton buttonWithType:UIButtonTypeCustom];
    btnFBShare.frame = CGRectMake(8, 20, [UIScreen mainScreen].bounds.size.width - 16, 37);

    [btnFBShare addTarget:self action:@selector(OnClickShare:) forControlEvents:UIControlEventTouchUpInside];
    btnFBShare.backgroundColor = [UIColor clearColor];
    btnFBShare.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:17];
    [btnFBShare setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btnFBShare setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    btnFBShare.tag = 1001;
    [btnFBShare setTitleColor:[UIColor colorWithRed:(21/255.f) green:(126/255.f) blue:(251/255.f) alpha:1.0f] forState:UIControlStateNormal];
    [btnFBShare setTitle:@"Facebook" forState:UIControlStateNormal];
    
    [btnFBShare setBackgroundImage:[UIImage imageNamed:@"actionSheetBtn.png"] forState:UIControlStateNormal];
    btnFBShare.adjustsImageWhenHighlighted = NO;
    [self.customActionSheet addSubview:btnFBShare];
    
    UIButton *btnTwitterShare = [UIButton buttonWithType:UIButtonTypeCustom];
    btnTwitterShare.frame = CGRectMake(8, btnFBShare.frame.size.height + btnFBShare.frame.origin.y + 5, [UIScreen mainScreen].bounds.size.width - 16, 37);
    [btnTwitterShare addTarget:self action:@selector(OnClickShare:) forControlEvents:UIControlEventTouchUpInside];
    btnTwitterShare.backgroundColor = [UIColor clearColor];
    btnTwitterShare.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:17];
    [btnTwitterShare setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btnTwitterShare setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [btnTwitterShare setTitleColor:[UIColor colorWithRed:(21/255.f) green:(126/255.f) blue:(251/255.f) alpha:1.0f] forState:UIControlStateNormal];
    btnTwitterShare.tag = 1002;
    [btnTwitterShare setTitle:@"Twitter" forState:UIControlStateNormal];
    [btnTwitterShare setBackgroundImage:[UIImage imageNamed:@"actionSheetBtn.png"] forState:UIControlStateNormal];
    btnTwitterShare.adjustsImageWhenHighlighted = NO;
    [self.customActionSheet addSubview:btnTwitterShare];
    
    UIButton *btnEmail = [UIButton buttonWithType:UIButtonTypeCustom];
    btnEmail.frame = CGRectMake(8, btnTwitterShare.frame.size.height + btnTwitterShare.frame.origin.y + 5, [UIScreen mainScreen].bounds.size.width - 16, 37);
    [btnEmail addTarget:self action:@selector(OnClickShare:) forControlEvents:UIControlEventTouchUpInside];
    btnEmail.backgroundColor = [UIColor clearColor];
    btnEmail.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:17];
    [btnEmail setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btnEmail setTitleColor:[UIColor colorWithRed:(21/255.f) green:(126/255.f) blue:(251/255.f) alpha:1.0f] forState:UIControlStateNormal]; //253,71,43
    btnEmail.tag = 1003;
    [btnEmail setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [btnEmail setTitle:@"Send an Email" forState:UIControlStateNormal];
    [btnEmail setBackgroundImage:[UIImage imageNamed:@"actionSheetBtn.png"] forState:UIControlStateNormal];
    btnEmail.adjustsImageWhenHighlighted = NO;
    [self.customActionSheet addSubview:btnEmail];
    
    UIButton *btnCopy = [UIButton buttonWithType:UIButtonTypeCustom];
    btnCopy.frame = CGRectMake(8, btnEmail.frame.size.height + btnEmail.frame.origin.y + 5, [UIScreen mainScreen].bounds.size.width - 16, 37);
    [btnCopy addTarget:self action:@selector(OnClickShare:) forControlEvents:UIControlEventTouchUpInside];
    btnCopy.backgroundColor = [UIColor clearColor];
    btnCopy.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:17];
    [btnCopy setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btnCopy setTitleColor:[UIColor colorWithRed:(21/255.f) green:(126/255.f) blue:(251/255.f) alpha:1.0f] forState:UIControlStateNormal]; //253,71,43
    btnCopy.tag = 1004;
    [btnCopy setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [btnCopy setTitle:@"Copy" forState:UIControlStateNormal];
    [btnCopy setBackgroundImage:[UIImage imageNamed:@"actionSheetBtn.png"] forState:UIControlStateNormal];
    btnCopy.adjustsImageWhenHighlighted = NO;
    [self.customActionSheet addSubview:btnCopy];
    
    UIButton *btnPrint = [UIButton buttonWithType:UIButtonTypeCustom];
    btnPrint.frame = CGRectMake(8, btnCopy.frame.size.height + btnCopy.frame.origin.y + 5, [UIScreen mainScreen].bounds.size.width - 16, 37);
    [btnPrint addTarget:self action:@selector(printdoc:) forControlEvents:UIControlEventTouchUpInside];
    btnPrint.backgroundColor = [UIColor clearColor];
    btnPrint.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:17];
    [btnPrint setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btnPrint setTitleColor:[UIColor colorWithRed:(21/255.f) green:(126/255.f) blue:(251/255.f) alpha:1.0f] forState:UIControlStateNormal]; //253,71,43
    btnPrint.tag = 1005;
    [btnPrint setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [btnPrint setTitle:@"Print" forState:UIControlStateNormal];
    [btnPrint setBackgroundImage:[UIImage imageNamed:@"actionSheetBtn.png"] forState:UIControlStateNormal];
    btnPrint.adjustsImageWhenHighlighted = NO;
    [self.customActionSheet addSubview:btnPrint];
    
    UIButton *btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    btnCancel.frame = CGRectMake(8, btnPrint.frame.size.height + btnPrint.frame.origin.y + 5, [UIScreen mainScreen].bounds.size.width - 16, 37);
    [btnCancel addTarget:self action:@selector(OnClickShare:) forControlEvents:UIControlEventTouchUpInside];
    btnCancel.backgroundColor = [UIColor clearColor];
    btnCancel.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:17];
    [btnCancel setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btnCancel setTitleColor:[UIColor colorWithRed:(253/255.f) green:(71/255.f) blue:(43/255.f) alpha:1.0f] forState:UIControlStateNormal]; //253,71,43
    btnCancel.tag = 1006;
    [btnCancel setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [btnCancel setTitle:@"Cancel" forState:UIControlStateNormal];
    [btnCancel setBackgroundImage:[UIImage imageNamed:@"actionSheetBtn.png"] forState:UIControlStateNormal];
    btnCancel.adjustsImageWhenHighlighted = NO;
    [self.customActionSheet addSubview:btnCancel];
    
}

-(void) closeCustomActionSheetWithTime:(float) time
{
    [UIView animateWithDuration:time delay: 0.0 options: UIViewAnimationOptionCurveEaseIn animations:^{
        self.dimBackGround.alpha = 0.0f;
        self.customActionSheet.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height + 280, [UIScreen mainScreen].bounds.size.width, 280);
    } completion:^(BOOL finished) {
    }];
}

#pragma mark - Pdf Processing
- (IBAction)createPDF:(id)sender {
    [viewFilenameSave setHidden:NO];
    [saveOk_BTN addTarget:self action:@selector(createPDFFromText) forControlEvents:UIControlEventTouchUpInside];
    //Get Document Directory path
}

- (void) createPDFFromText
{
    if(fileName_TF.text.length > 0){
        [viewFilenameSave setHidden:YES];
        NSArray * dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        //Define path for PDF file
        NSString * documentPath = [[dirPath objectAtIndex:0] stringByAppendingPathComponent:txtViewData.text];
        
        // Prepare the text using a Core Text Framesetter.
        CFAttributedStringRef currentText = CFAttributedStringCreate(NULL, (__bridge CFStringRef)txtViewData.text, NULL);
        if (currentText) {
            CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(currentText);
            if (framesetter) {
                
                
                // Create the PDF context using the default page size of 612 x 792.
                UIGraphicsBeginPDFContextToFile(documentPath, CGRectZero, nil);
                
                CFRange currentRange = CFRangeMake(0, 0);
                NSInteger currentPage = 0;
                BOOL done = NO;
                
                do {
                    // Mark the beginning of a new page.
                    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
                    
                    // Draw a page number at the bottom of each page.
                    currentPage++;
                    [self drawPageNbr:currentPage];
                    
                    // Render the current page and update the current range to
                    // point to the beginning of the next page.
                    currentRange = *[self updatePDFPage:currentPage setTextRange:&currentRange setFramesetter:&framesetter];
                    
                    // If we're at the end of the text, exit the loop.
                    if (currentRange.location == CFAttributedStringGetLength((CFAttributedStringRef)currentText))
                        done = YES;
                } while (!done);
                
                // Close the PDF context and write the contents out.
                UIGraphicsEndPDFContext();
                
                // Release the framewetter.
                CFRelease(framesetter);
                
            } else {
                NSLog(@"Could not create the framesetter..");
            }
            // Release the attributed string.
            CFRelease(currentText);
        } else {
            NSLog(@"currentText could not be created");
        }
    }
    else
    {
        NSLog(@"Please Enter File Name");
    }
}
-(void)drawPageNbr:(int)pageNumber{
    NSString *setPageNum = [NSString stringWithFormat:@"Page %d", pageNumber];
    UIFont *pageNbrFont = [UIFont systemFontOfSize:14];
    
    CGSize maxSize = CGSizeMake(612, 72);
    CGSize pageStringSize = [setPageNum sizeWithFont:pageNbrFont
                                   constrainedToSize:maxSize
                                       lineBreakMode:NSLineBreakByClipping];
    
    CGRect stringRect = CGRectMake(((612.0 - pageStringSize.width) / 2.0),
                                   720.0 + ((72.0 - pageStringSize.height) / 2.0),
                                   pageStringSize.width,
                                   pageStringSize.height);
    [setPageNum drawInRect:stringRect withFont:pageNbrFont];
}

-(CFRange*)updatePDFPage:(int)pageNumber setTextRange:(CFRange*)pageRange setFramesetter:(CTFramesetterRef*)framesetter{
    // Get the graphics context.
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    // Put the text matrix into a known state. This ensures
    // that no old scaling factors are left in place.
    CGContextSetTextMatrix(currentContext, CGAffineTransformIdentity);
    // Create a path object to enclose the text. Use 72 point
    // margins all around the text.
    CGRect frameRect = CGRectMake(72, 72, 468, 648);
    CGMutablePathRef framePath = CGPathCreateMutable();
    CGPathAddRect(framePath, NULL, frameRect);
    // Get the frame that will do the rendering.
    // The currentRange variable specifies only the starting point. The framesetter
    // lays out as much text as will fit into the frame.
    CTFrameRef frameRef = CTFramesetterCreateFrame(*framesetter, *pageRange,
                                                   framePath, NULL);
    CGPathRelease(framePath);
    // Core Text draws from the bottom-left corner up, so flip
    // the current transform prior to drawing.
    CGContextTranslateCTM(currentContext, 0, 792);
    CGContextScaleCTM(currentContext, 1.0, -1.0);
    // Draw the frame.
    CTFrameDraw(frameRef, currentContext);
    // Update the current range based on what was drawn.
    *pageRange = CTFrameGetVisibleStringRange(frameRef);
    pageRange->location += pageRange->length;
    pageRange->length = 0;
    CFRelease(frameRef);
    return pageRange;
}

@end
