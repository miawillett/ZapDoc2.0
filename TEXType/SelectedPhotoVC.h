//
//  SelectedPhotoVC.h
//  Text Type
//
//  Created by Vrinsoft Macmini on 15/05/15.
//  Copyright (c) 2015 Vrinsoft Macmini. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SelectedPhotoVC : UIViewController
{
    IBOutlet UIButton *btnCancle,*btnBack,*btnDone;
    IBOutlet UIImageView *imgSelected;
    int checkA;
    
    
}
@property(nonatomic,assign)int a;
@end
