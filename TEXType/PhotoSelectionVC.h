//
//  PhotoSelectionVC.h
//  Text Type
//
//  Created by Vrinsoft Macmini on 15/05/15.
//  Copyright (c) 2015 Vrinsoft Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface PhotoSelectionVC : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    IBOutlet UIButton *btnCamera, *btnGallary;
    UIImagePickerController *imagepicker;
    

}
@end
