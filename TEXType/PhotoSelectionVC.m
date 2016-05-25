//
//  PhotoSelectionVC.m
//  Text Type
//
//  Created by Vrinsoft Macmini on 15/05/15.
//  Copyright (c) 2015 Vrinsoft Macmini. All rights reserved.
//

#import "PhotoSelectionVC.h"
#import "SelectedPhotoVC.h"
#import "defines.h"
#import "defines.h"
@interface PhotoSelectionVC ()

@end

@implementation PhotoSelectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
    
    
    if ([sender tag]==1)
    {
        //Camera
  
            
            imagepicker.sourceType=UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagepicker animated:YES completion:nil];

    }
    else if ([sender tag]==2)
    {
        //Gallary
        
        imagepicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagepicker animated:YES completion:nil];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [APP_DELEGATE.HUD show:YES];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    UIImage *image = [info valueForKey: UIImagePickerControllerOriginalImage];
    
    SelectedPhotoVC *Selection =[[SelectedPhotoVC alloc]initWithNibName:@"SelectedPhotoVC" bundle:nil];
    Selection.a=10;
    APP_DELEGATE.dataImage=NULL;
    APP_DELEGATE.dataImage=UIImageJPEGRepresentation(image, 0.1);
    [self.navigationController pushViewController:Selection animated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];

}



- (void) imagePickerControllerDidCancel:(UIImagePickerController*)picker
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
