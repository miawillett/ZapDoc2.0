//
//  HomeVC.m
//  Text Type
//
//  Created by Vrinsoft Macmini on 15/05/15.
//  Copyright (c) 2015 Vrinsoft Macmini. All rights reserved.
//

#import "HomeVC.h"
#import "PhotoSelectionVC.h"
#import "SelectedPhotoVC.h"
#import "defines.h"
#import <TEXType-Swift.h>
//#import "defines.h"
@interface HomeVC ()

@end

@implementation HomeVC

bool isOCR;

- (void)viewDidLoad {
    [super viewDidLoad];
    APP_DELEGATE.dataImage=NULL;
    isOCR = false;
}
-(void)viewWillAppear:(BOOL)animated
{
    [APP_DELEGATE.HUD hide:YES];
    btn0.enabled=FALSE;
    btn1.enabled=FALSE;
    btn2.enabled=FALSE;
    btn3.enabled=FALSE;
    btn4.enabled=FALSE;
    btn5.enabled=FALSE;
    
   
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSError * error;
    NSArray * directoryContents =  [[NSFileManager defaultManager]
                                    contentsOfDirectoryAtPath:documentsDirectory error:&error];
    
    NSLog(@"directoryContents ====== %@",directoryContents);
    
    APP_DELEGATE.ArrayImg=NULL;
    APP_DELEGATE.ArrayImg=[[NSMutableArray alloc] init];

    
    if (directoryContents.count!=0)
    {
        for (int i=0; i<directoryContents.count; i++)
        {
            if ([[directoryContents objectAtIndex:i] hasSuffix:@".png"])
            {
                [APP_DELEGATE.ArrayImg addObject:[directoryContents objectAtIndex:i]];
            }
        }
    }
    
    if ([APP_DELEGATE.ArrayImg count] == 0)
        return;
    NSUInteger i = 0;
    NSUInteger j = [APP_DELEGATE.ArrayImg count]-1;
    while (i < j)
    {
        [APP_DELEGATE.ArrayImg exchangeObjectAtIndex:i withObjectAtIndex:j];
        
        i++;
        j--;
    }
  //asd
    APP_DELEGATE.arrPaths=[[NSMutableArray alloc] init];
    [APP_DELEGATE.arrPaths removeAllObjects];
    if (APP_DELEGATE.ArrayImg.count!=0)
    {
        NSArray *arrayPaths =
        NSSearchPathForDirectoriesInDomains(
                                            NSDocumentDirectory,
                                            NSUserDomainMask,
                                            YES);
        NSString *path = [arrayPaths objectAtIndex:0];

        for (int i=0; i<APP_DELEGATE.ArrayImg.count; i++)
        {
            NSString* fileName = [NSString stringWithFormat:@"%@",[APP_DELEGATE.ArrayImg objectAtIndex:i]];
            NSString* ImageFilePath = [path stringByAppendingPathComponent:fileName];
            UIImage *image1=[UIImage imageWithContentsOfFile:ImageFilePath];
            
            if (i==0) {
                img0.image=image1;
                img0.layer.cornerRadius = img0.frame.size.width / 2;
                img0.clipsToBounds = YES;
                [APP_DELEGATE.arrPaths addObject:ImageFilePath];
                btn0.enabled=TRUE;
                
            }
            if (i==1) {
                img1.image=image1;
                
                img1.layer.cornerRadius = img1.frame.size.width / 2;
                img1.clipsToBounds = YES;
                [APP_DELEGATE.arrPaths addObject:ImageFilePath];
                btn1.enabled=TRUE;
            }
            if (i==2) {
                
                img2.image=image1;
                
                img2.layer.cornerRadius = img2.frame.size.width / 2;
                img2.clipsToBounds = YES;
                [APP_DELEGATE.arrPaths addObject:ImageFilePath];
                btn2.enabled=TRUE;
            }
            if (i==3) {
                img3.image=image1;
                
                img3.layer.cornerRadius = img3.frame.size.width / 2;
                img3.clipsToBounds = YES;
                [APP_DELEGATE.arrPaths addObject:ImageFilePath];
                btn3.enabled=TRUE;
            }
            if (i==4) {
                img4.image=image1;
                
                img4.layer.cornerRadius = img4.frame.size.width / 2;
                img4.clipsToBounds = YES;
                [APP_DELEGATE.arrPaths addObject:ImageFilePath];
                btn4.enabled=TRUE;
            }
            if (i==5) {
                img5.image=image1;
                
                img5.layer.cornerRadius = img5.frame.size.width / 2;
                img5.clipsToBounds = YES;
                [APP_DELEGATE.arrPaths addObject:ImageFilePath];
                btn5.enabled=TRUE;
            }
            
        }
        [self animate];
    }
}
-(void) animate {
    //IMAGE 1 jhbjh
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         img0.transform = CGAffineTransformMakeScale(1.2, 1.2);
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                                          animations:^{
                                              img0.transform = CGAffineTransformMakeScale(1, 1);
                                          } completion:^(BOOL finished) {
                                              
                                          }];
                     }];
    
    [UIView animateWithDuration:0.5 delay:0.3 options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         img1.transform = CGAffineTransformMakeScale(1.2, 1.2);
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                                          animations:^{
                                              img1.transform = CGAffineTransformMakeScale(1, 1);
                                          } completion:^(BOOL finished) {
                                              
                                          }];
                     }];
    [UIView animateWithDuration:0.5 delay:0.6 options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         img2.transform = CGAffineTransformMakeScale(1.2, 1.2);
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                                          animations:^{
                                              img2.transform = CGAffineTransformMakeScale(1, 1);
                                          } completion:^(BOOL finished) {
                                              
                                          }];
                     }];
    [UIView animateWithDuration:0.5 delay:0.9 options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         img3.transform = CGAffineTransformMakeScale(1.2, 1.2);
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                                          animations:^{
                                              img3.transform = CGAffineTransformMakeScale(1, 1);
                                          } completion:^(BOOL finished) {
                                              
                                          }];
                     }];
    [UIView animateWithDuration:0.5 delay:0.12 options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         img4.transform = CGAffineTransformMakeScale(1.2, 1.2);
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                                          animations:^{
                                              img4.transform = CGAffineTransformMakeScale(1, 1);
                                          } completion:^(BOOL finished) {
                                              
                                          }];
                     }];
    [UIView animateWithDuration:0.5 delay:0.3 options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         img5.transform = CGAffineTransformMakeScale(1.2, 1.2);
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                                          animations:^{
                                              img5.transform = CGAffineTransformMakeScale(1, 1);
                                          } completion:^(BOOL finished) {
                                              
                                          }];
                     }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)OnClickBtn:(id)sender
{
    imagepicker=[[UIImagePickerController alloc]init];
    imagepicker.delegate=self;
    imagepicker.allowsEditing=NO;
    
     SelectedPhotoVC *Selection =[[SelectedPhotoVC alloc]initWithNibName:@"SelectedPhotoVC" bundle:nil];
    
    if ([sender tag]==1)
    {
        PhotoSelectionVC *Photo =[[PhotoSelectionVC alloc]initWithNibName:@"PhotoSelectionVC" bundle:nil];
        [self.navigationController pushViewController:Photo animated:YES];
        Selection.a=10;
    }
    else if([sender tag]==2)
    {
        //Camera
        
        imagepicker.sourceType=UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagepicker animated:YES completion:nil];
        
    }
    else if([sender tag]==3)
    {
        //Gallary
        imagepicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagepicker animated:YES completion:nil];
        
    }
    else if([sender tag]==0)
    {
        //img0
        APP_DELEGATE.dataImage = UIImageJPEGRepresentation(img0.image, 0.1);
        [self.navigationController pushViewController:Selection animated:YES];
        Selection.a=0;
    }
    else if([sender tag]==11)
    {
        //img1
        APP_DELEGATE.dataImage = UIImageJPEGRepresentation(img1.image, 0.1);
        [self.navigationController pushViewController:Selection animated:YES];
        Selection.a=1;
        
    }
    else if([sender tag]==22)
    {
        //img2
        APP_DELEGATE.dataImage = UIImageJPEGRepresentation(img2.image, 0.1);
        [self.navigationController pushViewController:Selection animated:YES];
        Selection.a=2;
    }
    else if([sender tag]==33)
    {
        //img3
        APP_DELEGATE.dataImage = UIImageJPEGRepresentation(img3.image, 0.1);
        [self.navigationController pushViewController:Selection animated:YES];
        Selection.a=3;
    }
    else if([sender tag]==44)
    {
        //img4
        APP_DELEGATE.dataImage = UIImageJPEGRepresentation(img4.image, 0.1);
        [self.navigationController pushViewController:Selection animated:YES];
        Selection.a=4;
    }
    else if([sender tag]==55)
    {
        //img5
        APP_DELEGATE.dataImage = UIImageJPEGRepresentation(img5.image, 0.1);
        [self.navigationController pushViewController:Selection animated:YES];
        Selection.a=5;
    }
    else if([sender tag] == 19){
        //OCR TESTING BUTTON
        imagepicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagepicker animated:YES completion:nil];
        
        isOCR = true;
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [APP_DELEGATE.HUD show:YES];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    UIImage *image = [info valueForKey: UIImagePickerControllerOriginalImage];
    imageData = UIImageJPEGRepresentation(image, 0.1);
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    if(isOCR){
        
        UIImage *myObjcData = image;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSData *data = UIImagePNGRepresentation(myObjcData);
        [defaults setObject:data forKey:@"data"];
        [defaults synchronize];
        
        //UIViewController *toOCR = [[UIViewController alloc] init];
        //[self presentModalViewController:toOCR animated:YES];
        
        OCR_VC *Selection =[[OCR_VC alloc]initWithNibName:@"OCR_VC" bundle:nil];
        [self.navigationController pushViewController:Selection animated:YES];
        
    }
    else{
    SelectedPhotoVC *Selection =[[SelectedPhotoVC alloc]initWithNibName:@"SelectedPhotoVC" bundle:nil];
    APP_DELEGATE.dataImage=NULL;
    APP_DELEGATE.dataImage = imageData;
    Selection.a = 10;
    [self.navigationController pushViewController:Selection animated:YES];
    }
    
}



- (void) imagePickerControllerDidCancel:(UIImagePickerController*)picker
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
