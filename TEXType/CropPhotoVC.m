//
//  CropPhotoVC.m
//  Text Type
//
//  Created by Vrinsoft Macmini on 15/05/15.
//  Copyright (c) 2015 Vrinsoft Macmini. All rights reserved.
//

#import "CropPhotoVC.h"
#import "ViewController.h"
#import "defines.h"
#import "JBCroppableImageView.h"

@interface CropPhotoVC ()
{
    
}
@end

@implementation CropPhotoVC
@synthesize imgSelected;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    getImg=[UIImage imageWithData:APP_DELEGATE.dataImage];
    imgTemp.image=getImg;
    
    imgSelected.image=getImg;
    viewImage.hidden=TRUE;
         
//        
//        scroll.frame =CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height-64-50);
    
   
//    scroll.minimumZoomScale = 1.0;
//    scroll.maximumZoomScale = 2.0;
}

//- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
//    // Return the view that we want to zoom
//    return imgSelected;
//}
//
//
//- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale;{
//    
//}

- (IBAction)cropTapped:(id)sender
{
    [imgSelected crop];
    [APP_DELEGATE.HUD hide:YES];

}
-(void) viewWillAppear:(BOOL)animated
{
    [self viewDidLoad];
    [APP_DELEGATE.HUD hide:YES];
}

-(IBAction)OnClickBtn:(id)sender
{
        if ([sender tag]==1)
    {
        imgTemp.hidden=TRUE;
        viewImage.hidden=FALSE;
        intBtnCheck=2;
    }
    else if ([sender tag]==2)
    {
        [APP_DELEGATE.HUD show:YES];
        
        
        NSFileManager *fileManager;
        if ([APP_DELEGATE.ArrayImg count] > 6) {
            int a=0;
            
            while ([APP_DELEGATE.ArrayImg count] >6)
            {
                NSString* fileName = [NSString stringWithFormat:@"%@",[APP_DELEGATE.ArrayImg objectAtIndex:a]];
                NSArray *arrayPaths =
                NSSearchPathForDirectoriesInDomains(
                                                    NSDocumentDirectory,
                                                    NSUserDomainMask,
                                                    YES);
                NSString *path = [arrayPaths objectAtIndex:0];
                NSString* ImageFilePath = [path stringByAppendingPathComponent:fileName];
                
                fileManager = [NSFileManager defaultManager];
                [fileManager removeItemAtPath:ImageFilePath error:nil];
                [APP_DELEGATE.ArrayImg removeObjectAtIndex:a];
                a++;
            }
            
            
        }
        [APP_DELEGATE.ArrayImg removeAllObjects];

        
        if (intBtnCheck==2) {
           [imgSelected crop];
            
            [self cropTapped:nil];
            
        }
        else
        {
           
            ViewController *VC = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
            [self.navigationController pushViewController:VC animated:YES];

        }
    }
    else
    {
        [APP_DELEGATE.HUD show:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
