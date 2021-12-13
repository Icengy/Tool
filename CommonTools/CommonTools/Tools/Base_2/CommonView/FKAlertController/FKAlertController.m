//
//  FKAlertController.m
//  ArtMedia2
//
//  Created by 刘洋 on 2020/10/23.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import "FKAlertController.h"

@interface FKAlertController ()
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (nonatomic , copy) void(^sureBlock)(void);
@property (nonatomic , copy) void(^cancelBlock)(void);
@property (nonatomic , copy) void(^sureCompletion)(void);
@end

@implementation FKAlertController
- (instancetype)init{
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.view.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.5];
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
//        [self.view addGestureRecognizer:tap];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"%@ \n %@" ,touches ,event );
//
//}
- (void)hide{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)sureClick:(UIButton *)sender {
    if (self.sureBlock) {
        self.sureBlock();
    }
    [self dismissViewControllerAnimated:YES completion:^{
        if(self.sureCompletion){
            self.sureCompletion();
        }
    }];
}




- (void)showAlertWithController:(UIViewController *)controller title:(NSString *)title content:(NSString *)content sureClickBlock:(void(^)(void))sureClickBlock sureCompletion:(void(^)(void))sureCompletion{
    [self showAlertWithController:controller title:title content:content cancelButtonTitle:@"取消" sureButtonTitle:@"确定" sureClickBlock:sureClickBlock sureCompletion:sureCompletion];
}
- (void)showAlertWithController:(UIViewController *)controller title:(NSString *)title content:(NSString *)content cancelButtonTitle:(NSString *)cancelButtonTitle sureButtonTitle:(NSString *)sureButtonTitle sureClickBlock:(void(^)(void))sureClickBlock sureCompletion:(void(^)(void))sureCompletion{
    self.titleLabel.text = title;
    self.contentLabel.text = content;
    [self.cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
    [self.sureButton setTitle:sureButtonTitle forState:UIControlStateNormal];
    self.sureBlock = sureClickBlock;
    self.sureCompletion = sureCompletion;
    [controller.navigationController presentViewController:self animated:YES completion:nil];
}

@end
