//
//  ViewController.m
//  DOLog
//
//  Created by zhangchong on 2017/7/14.
//  Copyright © 2017年 zhangchong. All rights reserved.
//

#include <MobileCoreServices/MobileCoreServices.h>
#import "ViewController.h"
#import "DOConstants.h"
#import "NSFileManager+Helpers.h"

static NSString * LogDirectory = @"DebugLogger";

typedef NS_ENUM(NSUInteger, DOViewTag) {
    DOViewTagFirst = 1,
};


@interface ViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *qualityLebel;
@property (nonatomic, assign) NSInteger qualityFactor;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIView * view = [self.view viewWithTag:9999];
//    [self.view bringSubviewToFront:view];
    
    self.qualityLebel.delegate = self;
    NSLog(@"RATE_MODULE Address: %p | RATE_MODULE_ Address: %p" , &RATE_MODULE, &RATE_MODULE_);
    [self __setupSubViews];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Subviews
- (void)__setupSubViews {
    CGFloat height = 60.f, gap = -5.f;
    CGFloat width = CGRectGetWidth(self.view.bounds) - 10;
    CGFloat x = 5.f;
    CGFloat y = 0.f; 
    DOViewTag tag = DOViewTagFirst;
    
    UIView * firstView = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    firstView.backgroundColor = [UIColor yellowColor];
    firstView.tag = tag++;
    [self.view addSubview:firstView];
    
    y += (height + gap);
    UIView * secondView = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    secondView.backgroundColor = [UIColor blueColor];
    secondView.tag = tag++;
    [self.view addSubview:secondView];
    
    y += (height + gap);
    UIView * thirdView = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    thirdView.backgroundColor = [UIColor greenColor];
    thirdView.tag = tag++;
    [self.view addSubview:thirdView];
}


#pragma mark - Action Handler


- (IBAction)__OnAllSubviews:(id)sender {
    
    /*
    for (UIView * view in self.view.subviews) {
        NSLog(@"view: %p tag: %ld : description: %@", view, (long)view.tag, [view debugDescription]);
    }
    
    UIView * view = [self.view viewWithTag:1];
    [self.view bringSubviewToFront:view];
    
    
    for (UIView * view in self.view.subviews) {
        NSLog(@"view: %p tag: %ld : description: %@", view, (long)view.tag, [view debugDescription]);
    }
     */
    NSString *qualityString = self.qualityLebel.text;
    BOOL shouldShowAlert = NO;
    if (!qualityString || qualityString.length == 0) {
        shouldShowAlert = YES;
    }
    
    self.qualityFactor = [qualityString integerValue];
    if (self.qualityFactor > 100 || self.qualityFactor < 0) {
        shouldShowAlert = YES;
    }
    
    if (shouldShowAlert) {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Quality Error"
                                                                        message:@"Should enter a number which in [0-100]"
                                                                 preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"cancel"
                                                         style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           [self dismissViewControllerAnimated:YES completion:nil];
                                                       }];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
        return ;
    }
    
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.mediaTypes = @[(NSString*)kUTTypeImage];
//    pickerController.allowsEditing = YES;
    pickerController.delegate = self;
    pickerController.view.backgroundColor = [UIColor whiteColor];
    [self presentViewController:pickerController animated:YES completion:nil];
}



- (void)saveData:(NSData *)data toFile:(NSString *)fileName {
    
    NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
    NSURL *directoryURL = [documentsURL URLByAppendingPathComponent:LogDirectory isDirectory:YES];
    [[NSFileManager defaultManager] createDirectoryIfNeeded:[directoryURL path]];
    NSString *filePath = [[directoryURL path] stringByAppendingFormat:@"/%@", fileName];
    [data writeToFile:filePath atomically:YES];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
//    NSLog(@"info: %@", info);
    
    if ([info[UIImagePickerControllerMediaType] isEqual:(NSString*)kUTTypeImage]) {
//        UIImage *editingImage = info[UIImagePickerControllerEditedImage];
        UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
        NSTimeInterval secondsSince1970 = [[NSDate date] timeIntervalSince1970];
        
        
        CGFloat compressionQuality = self.qualityFactor/100.f;
        NSLog(@"compressionQuality: %f", compressionQuality);
        NSData *imageData = UIImageJPEGRepresentation(originalImage, compressionQuality);
        NSString *secondes = [NSString stringWithFormat:@"%.03f-%.02f.jpg", secondsSince1970, compressionQuality];
        [self saveData:imageData toFile:secondes];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
