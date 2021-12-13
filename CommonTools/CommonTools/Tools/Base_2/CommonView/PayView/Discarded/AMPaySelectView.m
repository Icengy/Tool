//
//  AMPaySelectView.m
//  ArtMedia2
//
//  Created by icnengy on 2020/5/21.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import "AMPaySelectView.h"

#import "AMPayPriceHeader.h"
#import "AMPaySelectViewCell.h"

#import "AMPayModel.h"

@interface AMPaySelectView () <UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource, AMPayPriceHeaderDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;

@property (nonatomic ,strong) AMPayPriceHeader *header;
@property (nonatomic ,strong) AMButton *confirmBtn;

@property (nonatomic ,assign) AMAwakenPayStyle style;
@end

@implementation AMPaySelectView  {
    NSMutableArray <AMPayModel *>*_dataArray;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.3];
    self.tableView.backgroundColor = Color_Whiter;
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    
    [self initData];
    
    _tableViewHeightConstraint.constant = ADDefaultButtonHeight *2 + ADRowHeight*1.2 *_dataArray.count+ ADAPTATIONRATIOVALUE(83.0f) + SafeAreaBottomHeight;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = ADRowHeight*1.2;
    
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, SafeAreaBottomHeight, 0);
    
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([AMPaySelectViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([AMPaySelectViewCell class])];
}

- (void)initData {
    _dataArray = [NSMutableArray new];
    if ([WXApi isWXAppInstalled]) {
        AMPayModel *wxModel = [AMPayModel new];
        wxModel.iconStr = @"Pay_微信";
        wxModel.titleStr = @"微信支付";
        wxModel.subTitleStr = @"微信安全支付";
        wxModel.isSelected = YES;
        wxModel.wayType = AMPayWayWX;
        [_dataArray addObject:wxModel];
    }

    AMPayModel *aliModel = [AMPayModel new];
    aliModel.iconStr = @"Pay_支付宝";
    aliModel.titleStr = @"支付宝支付";
    aliModel.subTitleStr = @"支付宝安全支付";
    aliModel.isSelected = [WXApi isWXAppInstalled]?NO:YES;
    aliModel.wayType = AMPayWayAlipay;
    [_dataArray addObject:aliModel];
    
}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return ADDefaultButtonHeight *2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *wrapView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, ADDefaultButtonHeight *2)];
    wrapView.backgroundColor = Color_Whiter;
    
    [wrapView addSubview:self.header];
    self.header.priceStr = self.priceStr;
    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(wrapView);
    }];
    
    return wrapView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return ADRowHeight *1.2;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *wrapView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, ADAPTATIONRATIOVALUE(83.0f))];
    wrapView.backgroundColor = Color_Whiter;
    
    [wrapView addSubview:self.confirmBtn];
    self.confirmBtn.frame = CGRectMake(15.0f, ADAPTATIONRATIOVALUE(4.0f), wrapView.width-30.0f, wrapView.height-ADAPTATIONRATIOVALUE(8.0f));
    self.confirmBtn.layer.cornerRadius = self.confirmBtn.height/2;
    self.confirmBtn.layer.masksToBounds = YES;
    
    return wrapView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AMPaySelectViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AMPaySelectViewCell class])];
    cell.model = _dataArray[indexPath.row];
//    cell.selectedBlock = ^(AMPayModel * _Nonnull model) {
//        [self resetSeletedRow:[_dataArray indexOfObject:model]];
//    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self resetSeletedRow:indexPath.row];
}

#pragma mark -
- (void)payHeader:(AMPayPriceHeader *)header didClickToDismiss:(id)sender {
    [self removeFromSuperview];
}

#pragma mark -
-(void)tapClick:(UITapGestureRecognizer*)tap {
    [self removeFromSuperview];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:self.tableView]) {
        return NO;
    }
    return YES;
}

- (void)resetSeletedRow:(NSInteger)index {
    [_dataArray enumerateObjectsUsingBlock:^(AMPayModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.isSelected = (idx == index) ? YES:NO;
    }];
    [_tableView reloadData];
}

#pragma mark -
- (void)payBtnCLick:(id)sender {
    [self hide];
    __block AMPayWay payWay = AMPayWayApple;
    [_dataArray enumerateObjectsUsingBlock:^(AMPayModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isSelected) payWay = obj.wayType;
    }];
    if(_payBlock) _payBlock(payWay);
}

#pragma mark -
+ (AMPaySelectView *)shareInstanceWithStyle:(AMAwakenPayStyle)style {
    AMPaySelectView *payView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
    payView.frame = CGRectMake(0, K_Height, K_Width, K_Height);
    payView.style = style;
    return payView;
}

+ (AMPaySelectView *)shareInstance {
    return [AMPaySelectView shareInstanceWithStyle:AMAwakenPayStyleDefalut];
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.33 animations:^{
        CGRect frame = self.frame;
        frame.origin.y -= K_Height;
        self.frame = frame;
    }];
}

- (void)hide {
    [UIView animateWithDuration:0.33 animations:^{
        CGRect frame = self.frame;
        frame.origin.x -= K_Width;
        self.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (AMButton *)confirmBtn {
    if (!_confirmBtn) {
        _confirmBtn = [AMButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.backgroundColor = RGB(21, 22, 26);
        [_confirmBtn setTitle:@"确认支付" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:Color_Whiter forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = [UIFont addHanSanSC:16.0 fontType:0];
        [_confirmBtn addTarget:self action:@selector(payBtnCLick:) forControlEvents:UIControlEventTouchUpInside];
    }return _confirmBtn;
}

- (AMPayPriceHeader *)header {
    if (!_header) {
        _header = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([AMPayPriceHeader class]) owner:nil options:nil].lastObject;
        _header.delegate = self;
    }return _header;
}

@end
