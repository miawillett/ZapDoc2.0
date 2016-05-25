//
//  SelectedPhotoVC.m
//  Text Type
//
//  Created by Vrinsoft Macmini on 15/05/15.
//  Copyright (c) 2015 Vrinsoft Macmini. All rights reserved.
//

#import "SelectedPhotoVC.h"
#import "defines.h"
#import "CropPhotoVC.h"
@interface SelectedPhotoVC ()

@end

@implementation SelectedPhotoVC
@synthesize a;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fixOrientation:[UIImage imageWithData:APP_DELEGATE.dataImage]];
    //imgSelected.image = [UIImage imageWithData:APP_DELEGATE.dataImage];
    checkA=0;
   
}
-(void)viewWillAppear:(BOOL)animated
{
    [APP_DELEGATE.HUD hide:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fixOrientation:(UIImage *)img{
    
    // No-op if the orientation is already correct
    if (img.imageOrientation == UIImageOrientationUp)
    {
     
        imgSelected.image=img;
        return;
    }
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (img.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, img.size.width, img.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, img.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, img.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (img.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, img.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, img.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, img.size.width, img.size.height,
                                             CGImageGetBitsPerComponent(img.CGImage), 0,
                                             CGImageGetColorSpace(img.CGImage),
                                             CGImageGetBitmapInfo(img.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (img.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,img.size.height,img.size.width), img.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,img.size.width,img.size.height), img.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *RotatedImg = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    imgSelected.image=RotatedImg;
    APP_DELEGATE.dataImage=NULL;
    APP_DELEGATE.dataImage=UIImageJPEGRepresentation(RotatedImg, 0.1);
}

-(IBAction)OnClickBtn:(id)sender
{
    
    
    if ([sender tag]==1)
    {
        //Cancle
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if ([sender tag]==2)
    {
        //Back
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        //Done
        [APP_DELEGATE.HUD show:YES];
        
        
        NSFileManager *fileManager;
        if (checkA==0) {
            if (a!=10)
            {
                checkA=2;
                fileManager = [NSFileManager defaultManager];
                [fileManager removeItemAtPath:[APP_DELEGATE.arrPaths objectAtIndex:a] error:nil];
                
            }
        }
        
                [APP_DELEGATE.arrPaths removeAllObjects];
        
        NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
        [timeFormat setDateFormat:@"HHmmssSSS"];
        
        NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
        [dateformat setDateFormat:@"ddMMyy"];
        
        NSDate *now = [[NSDate alloc] init];
        
        NSString *theTime = [timeFormat stringFromDate:now];
        NSString *theDate = [dateformat stringFromDate:now];
        
        //NSLog(@"time is %@%@",theDate,theTime);
        NSData *pngData = UIImagePNGRepresentation(imgSelected.image);
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        NSString *localFilePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"temp%@_images%@.png",theDate,theTime]];

        [pngData writeToFile:localFilePath atomically:YES];

        
         //[fileManager createFileAtPath:[localFilePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] contents:pngData attributes:nil];
        
        CropPhotoVC *CP =[[CropPhotoVC alloc]initWithNibName:@"CropPhotoVC" bundle:nil];
        [self.navigationController pushViewController:CP animated:YES];
        
    }
}



@end
