//
//  HomeVC.h
//  Text Type
//
//  Created by Vrinsoft Macmini on 15/05/15.
//  Copyright (c) 2015 Vrinsoft Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeVC : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    IBOutlet UIButton *btnImageSelect, *btnCamera, *btnGallary,*btn0,*btn1,*btn2,*btn3,*btn4,*btn5;
    IBOutlet UIView *viewBottom;
    IBOutlet UIImageView *img0,*img1,*img2,*img3,*img4,*img5;
    
    
    UIImagePickerController *imagepicker;
    NSData *imageData;
    
}
@end
