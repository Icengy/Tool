//
//  AMPayViewController.m
//  ArtMedia2
//
//  Created by icnengy on 2020/7/2.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import "AMPayViewController.h"

#import "AMPayPriceHeader.h"
#import "AMPayPriceFooter.h"

#import "AMPaySelectViewCell.h"
#import "AMPayVirtualCurrencyCell.h"

#import "AMPayModel.h"

@interface AMPayViewController () <UITableViewDelegate ,UITableViewDataSource, AMPayPriceHeaderDelegate, AMPayPriceFooterDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet AMPayPriceHeader *priceHeaderView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;
@property (weak, nonatomic) IBOutlet AMButton *confirmBtn;


@property (strong, nonatomic) AMPayPriceFooter *priceFooterView;

@end

@implementation AMPayViewController {
    NSMutableArray <AMPayModel *>*_dataArray;
    BOOL _needRecharge;
}

- (instancetype)init {
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    }return self;
}

- (AMPayPriceFooter *)priceFooterView {
    if (!_priceFooterView) {
        _priceFooterView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([AMPayPriceFooter class]) owner:nil options:nil].lastObject;
        _priceFooterView.delegate = self;
    }return _priceFooterView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.3];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
    
    self.confirmBtn.titleLabel.font = [UIFont addHanSanSC:16.0f fontType:1];
    
    _needRecharge = YES;
    _dataArray = [self dataArray];
    
    self.priceHeaderView.delegate = self;
    self.priceHeaderView.payStyle = self.payStyle;
    self.priceHeaderView.priceStr = self.priceStr;
    
    self.tableView.separatorStyle = (self.payStyle == AMAwakenPayStyleConsumption)?UITableViewCellSeparatorStyleNone:UITableViewCellSeparatorStyleSingleLine;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = (self.payStyle == AMAwakenPayStyleConsumption)?ADRowHeight:ADRowHeight *1.2;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([AMPaySelectViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([AMPaySelectViewCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([AMPayVirtualCurrencyCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([AMPayVirtualCurrencyCell class])];
    
    [self.tableView layoutIfNeeded];
    self.tableViewHeightConstraint.constant = self.tableView.contentSize.height;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%@ viewWillAppear", NSStringFromClass([self class]));
}

- (NSMutableArray <AMPayModel *>*)dataArray {
    NSMutableArray <AMPayModel *>*modelArray = @[].mutableCopy;
    if (self.payStyle == AMAwakenPayStyleConsumption) {
        AMPayModel *allModel = [AMPayModel new];
        allModel.iconStr = nil;
        allModel.titleStr = @"当前艺币";
        allModel.subTitleStr = @"100";
        allModel.needRecharge = _needRecharge;
        allModel.wayType = AMPayWayDefault;
        [modelArray addObject:allModel];
        
        AMPayModel *lastModel = [AMPayModel new];
        lastModel.iconStr = nil;
        lastModel.titleStr = @"剩余艺币";
        lastModel.subTitleStr = nil;
        lastModel.wayType = AMPayWayDefault;
        [modelArray addObject:lastModel];
    }else {
    
        if ([WXApi isWXAppInstalled]) {
            AMPayModel *wxModel = [AMPayModel new];
            wxModel.iconStr = @"Pay_微信";
            wxModel.titleStr = @"微信支付";
            wxModel.wayType = AMPayWayWX;
            [modelArray addObject:wxModel];
        }

        AMPayModel *aliModel = [AMPayModel new];
        aliModel.iconStr = @"Pay_支付宝";
        aliModel.titleStr = @"支付宝支付";
        aliModel.wayType = AMPayWayAlipay;
        [modelArray addObject:aliModel];
        
        if (self.payStyle == AMAwakenPayStyleAuction) {
            AMPayModel *aliModel = [AMPayModel new];
            aliModel.iconStr = @"Pay-offline";
            aliModel.titleStr = @"线下打款";
            aliModel.wayType = AMPayWayOffline;
            [modelArray addObject:aliModel];
        }
    }
    
    return modelArray;
}


#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_payStyle == AMAwakenPayStyleConsumption) {
        AMPayVirtualCurrencyCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AMPayVirtualCurrencyCell class]) forIndexPath:indexPath];
        cell.model = _dataArray[indexPath.row];
        return cell;
    }
    AMPaySelectViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AMPaySelectViewCell class]) forIndexPath:indexPath];
    cell.model = _dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
//    if (_payStyle == AMAwakenPayStyleConsumption) return CGFLOAT_MIN;
//    return tableView.rowHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
//    if (_payStyle == AMAwakenPayStyleConsumption) return [UIView new];
//    self.priceFooterView.frame = CGRectMake(0, 0, tableView.width, tableView.rowHeight);
//    return self.priceFooterView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_payStyle == AMAwakenPayStyleConsumption)  return;
    [_dataArray enumerateObjectsUsingBlock:^(AMPayModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx != indexPath.row) obj.isSelected = NO;
    }];
    AMPayModel *model = _dataArray[indexPath.row];
    model.isSelected = !model.isSelected;
    [_dataArray replaceObjectAtIndex:indexPath.row withObject:model];
    [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:(UITableViewScrollPositionNone)];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark -
- (void)payHeader:(AMPayPriceHeader *)header didClickToDismiss:(id)sender {
    [self tapClick:sender];
}

- (void)payFooter:(AMPayPriceFooter *)footer didClickToAddNewBank:(id)sender {
    
}

#pragma mark -
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:self.contentView]) {
        return NO;
    }
    return YES;
}

#pragma mark -
- (void)tapClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(payViewController:didSelectPayForWay:)]) {
        [self.delegate payViewController:self didSelectPayForWay:AMPayWayDefault];
    }
}

- (IBAction)clickToConfrim:(id)sender {
    if (_payStyle != AMAwakenPayStyleConsumption) {
        __block AMPayWay payWay = AMPayWayDefault;
            [_dataArray enumerateObjectsUsingBlock:^(AMPayModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (obj.isSelected) {
                    payWay = obj.wayType;
                    *stop = YES;
                }
            }];
        if (self.delegate && [self.delegate respondsToSelector:@selector(payViewController:didSelectPayForWay:)]) {
            [self.delegate payViewController:self didSelectPayForWay:payWay];
        }
    }else {
        if (self.delegate && [self.delegate respondsToSelector:@selector(payViewController:didSelectPayVirtualWithNeedRecharge:)]) {
            [self.delegate payViewController:self didSelectPayVirtualWithNeedRecharge:_needRecharge];
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
