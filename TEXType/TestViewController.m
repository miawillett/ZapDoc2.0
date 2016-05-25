//
//  TestViewController.m
//  TextType
//
//  Created by Ankit on 26/05/15.
//
//

#import "TestViewController.h"
#import "ViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    ViewController *VC =[[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
    
    [self.navigationController pushViewController:VC animated:NO];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
