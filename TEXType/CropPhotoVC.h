//
//  CropPhotoVC.h
//  Text Type
//
//  Created by Vrinsoft Macmini on 15/05/15.
//  Copyright (c) 2015 Vrinsoft Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JBCroppableImageView.h"

@class JBCroppableImageView;
@interface CropPhotoVC : UIViewController
{
    IBOutlet UIButton *btnCrop,*btnDone,*btnBack;
    IBOutlet JBCroppableImageView *imgSelected;
    IBOutlet UIImageView *imgTemp;
    int intBtnCheck;
    IBOutlet UIView *viewImage;
    UIImage *getImg;
     IBOutlet  UIScrollView *scroll;
    
}
@property (nonatomic, retain) IBOutlet JBCroppableImageView  *imgSelected;


@end
