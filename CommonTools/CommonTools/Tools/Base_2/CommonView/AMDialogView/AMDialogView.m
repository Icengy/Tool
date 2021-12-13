//
//  AMDialogView.m
//  ArtMedia2
//
//  Created by icnengy on 2020/6/3.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import "AMDialogView.h"

@implementation AMDialogView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

static BOOL _hadInstance = NO;
+ (instancetype)shareInstance {
    if (!_hadInstance) {
        _hadInstance = YES;
        NSArray *objArray = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([AMDialogView class]) owner:self options:nil];
        for (id obj in objArray) {
            if ([obj isKindOfClass:self]) {
                return obj;
            }
        }
    }
    return nil;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [RGB(0, 0, 0) colorWithAlphaComponent:0.8];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
}

- (void)show {
    if (!self) return;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^ {
    } completion:nil];
}

- (void)hide {
    [UIView animateWithDuration:0.4f delay:0.0 options:UIViewAnimationOptionTransitionFlipFromTop animations:^ {
    }completion:^(BOOL finished) {
        _hadInstance = NO;
        [self removeFromSuperview];
    }];
}

- (void)hide:(void (^)(void))completion {
    [UIView animateWithDuration:0.4f delay:0.0 options:UIViewAnimationOptionTransitionFlipFromTop animations:^ {
    }completion:^(BOOL finished) {
        _hadInstance = NO;
        if (completion) completion();
        [self removeFromSuperview];
    }];
}

#pragma mark -
- (void)setMainCarrier:(UIView *)mainCarrier {
    _mainCarrier = mainCarrier;
    _mainCarrier.backgroundColor = [UIColor.whiteColor colorWithAlphaComponent:1.0f];
}

#pragma mark -
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:self.mainCarrier]) {
        return NO;
    }
    return YES;
}

@end


#pragma mark - AMImageSelectDialogView
@interface AMImageSelectDialogView ()

@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet AMButton *closeBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet AMButton *photoBtn;
@property (weak, nonatomic) IBOutlet AMButton *albumBtn;

@end

@implementation AMImageSelectDialogView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.mainCarrier = self.mainView;
    
    _nameLabel.font = [UIFont addHanSanSC:16.0f fontType:0];
    _photoBtn.titleLabel.font = [UIFont addHanSanSC:18.0f fontType:0];
    _albumBtn.titleLabel.font = [UIFont addHanSanSC:18.0f fontType:0];
}
#pragma mark -
- (void)setTitle:(NSString *)title {
    _title = title;
    _nameLabel.text = _title;
}

- (void)setItemData:(NSArray<NSString *> *)itemData {
    _itemData = itemData;
    if (!_itemData.count) return;
    [_photoBtn setTitle:itemData.firstObject forState:UIControlStateNormal];
    [_albumBtn setTitle:itemData.lastObject forState:UIControlStateNormal];
}

#pragma mark -
- (IBAction)closeDialog:(AMButton *)sender {
    [self hide];
}

- (IBAction)clickToPhoto:(AMButton *)sender {
    if (_imageSelectedBlock) _imageSelectedBlock(AMImageSelectedMeidaTypePhoto);
}

- (IBAction)clickToAlbum:(AMButton *)sender {
    if (_imageSelectedBlock) _imageSelectedBlock(AMImageSelectedMeidaTypeCamera);
}
@end

#pragma mark - AMAuthDialogView
@interface AMAuthDialogView ()
@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet AMButton *closeBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet AMButton *photoBtn;
@property (weak, nonatomic) IBOutlet AMButton *albumBtn;

@end


@implementation AMAuthDialogView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.mainCarrier = self.mainView;
    
    _nameLabel.font = [UIFont addHanSanSC:14.0f fontType:0];
    _photoBtn.titleLabel.font = [UIFont addHanSanSC:18.0f fontType:0];
    _albumBtn.titleLabel.font = [UIFont addHanSanSC:14.0f fontType:0];
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:_albumBtn.titleLabel.text];
    
    [attr addAttributes:@{NSUnderlineStyleAttributeName:[NSNumber numberWithInt:1], NSUnderlineColorAttributeName:RGB(153, 153, 153)} range:[_albumBtn.titleLabel.text rangeOfString:_albumBtn.titleLabel.text]];
    
    [_albumBtn setAttributedTitle:attr forState:(UIControlStateNormal)];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _nameLabel.text = _title;
}

- (IBAction)closeDialog:(AMButton *)sender {
    [self hide];
}

- (IBAction)clickToPhoto:(AMButton *)sender {
    if (_imageSelectedBlock) _imageSelectedBlock(AMImageSelectedMeidaTypeCamera);
}

- (IBAction)clickToAlbum:(AMButton *)sender {
    if (_imageSelectedBlock) _imageSelectedBlock(AMImageSelectedMeidaTypePhoto);
}

@end

#pragma mark - AMTableDialogView

#import "AMTableBankDialogCell.h"
#import "AMTableMenuDialogCell.h"

#define AMTableRowHeight 50.0f

@interface AMTableDialogView () <UITableViewDelegate ,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;
@end

@implementation AMTableDialogView {
    NSMutableArray *_dataArray;
    NSInteger _selectedIndex;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.mainCarrier = self.mainView;
    
    _dataArray = [NSMutableArray new];
    _selectedIndex = 0;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.rowHeight = AMTableRowHeight;
    self.tableView.scrollEnabled = NO;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([AMTableBankDialogCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([AMTableBankDialogCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([AMTableMenuDialogCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([AMTableMenuDialogCell class])];
}

#pragma mark -
- (void)setTableType:(AMTableDialogType)tableType {
    _tableType = tableType;
    if ([self.dataSource respondsToSelector:@selector(dialogViewDataSource:)]) {
        if (_dataArray.count) [_dataArray removeAllObjects];
        _dataArray = [self.dataSource dialogViewDataSource:self].mutableCopy;
    }
    if ([self.dataSource respondsToSelector:@selector(dialogViewSelectedItem:)]) {
        _selectedIndex = [self.dataSource dialogViewSelectedItem:self];
    }
    NSInteger count = _dataArray.count;
    if (count >= 6)  {count = 6;self.tableView.scrollEnabled = YES;}
    ///整组行高+上下视图高度
    _tableViewHeightConstraint.constant = AMTableRowHeight * count + AMTableRowHeight/2;
    
    if (_tableType == AMTableDialogTypeBank) self.tableView.scrollEnabled = YES;
    
    [self.tableView reloadData];
}

#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return AMTableRowHeight/4;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return AMTableRowHeight/4;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_tableType) {//AMTableDialogTypeBank
        AMTableBankDialogCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AMTableBankDialogCell class])];
        cell.bankInfo = _dataArray[indexPath.row];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (_dataArray.count) {
            if (indexPath.row == _selectedIndex) {
                [cell setSelected:YES animated:YES];
                [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
                //调用此方法,显示我们自定义的选中颜色
                [self tableView:tableView didSelectRowAtIndexPath:indexPath];
            }
        }

        
        return cell;
    }else {
        AMTableMenuDialogCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AMTableMenuDialogCell class])];
        cell.menuTitle = _dataArray[indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tableType == AMTableDialogTypeBank) {
        _selectedIndex = indexPath.row;
    }else {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    if ([self.delegate respondsToSelector:@selector(dialogView:didSelectRowAtIndexPath:)])
        [self.delegate dialogView:self didSelectRowAtIndexPath:indexPath];
}

@end


#pragma mark - AMThumbsDialogView
@interface AMThumbsDialogView ()
@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet AMButton *closeBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@end

@implementation AMThumbsDialogView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.mainCarrier = self.mainView;
    
    _nameLabel.font = [UIFont addHanSanSC:16.0f fontType:0];
    _countLabel.numberOfLines = 0;
}

#pragma mark -
- (void)setThumbsCount:(NSInteger)thumbsCount {
    _thumbsCount = thumbsCount;
    [self reloadData:_thumbsCount];
}

- (void)reloadData:(NSInteger)thumbsCount {
    
    NSString *string = [NSString stringWithFormat:@"%@",@(thumbsCount)];
    if (![ToolUtil isEqualToNonNull:string ]) {
        string = @"0";
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange range = NSMakeRange(0, string.length);
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentCenter;//对齐方式
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:style range:range];
    [attributedString addAttribute:NSKernAttributeName value:@(4.0f) range:range];//字符间隔
    [attributedString addAttribute:NSFontAttributeName value:[UIFont addHanSanSC:45.0f fontType:2] range:range];//字体大小
    [attributedString addAttribute:NSForegroundColorAttributeName value:Color_Black range:range];//文字颜色
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeMake(0, 0);
    shadow.shadowBlurRadius = 1.5f;
    shadow.shadowColor = Color_MainBg;
    
    [attributedString addAttribute:NSShadowAttributeName value:shadow range:range];//阴影颜色，和NSVerticalGlyphFormAttributeName一起使用
    [attributedString addAttribute:NSVerticalGlyphFormAttributeName value:@(0) range:range];///设置水平拉伸0水平 1竖直
    
    _countLabel.attributedText = attributedString;
}
#pragma mark -
- (IBAction)closeDialog:(AMButton *)sender {
    [self hide];
}

@end

#pragma mark - AMMeetingConfirmDialogView
@interface AMMeetingConfirmDialogView ()
@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;

@property (weak, nonatomic) IBOutlet AMButton *cancelBtn;
@property (weak, nonatomic) IBOutlet AMButton *confirmBtn;
@end
@implementation AMMeetingConfirmDialogView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.mainCarrier = self.mainView;
    
    _titleLabel.font = [UIFont addHanSanSC:16.0f fontType:0];
    _dateLabel.font = [UIFont addHanSanSC:13.0f fontType:0];
    _countLabel.font = [UIFont addHanSanSC:13.0f fontType:0];
    _tipsLabel.font = [UIFont addHanSanSC:13.0f fontType:0];
    
    _confirmBtn.titleLabel.font = [UIFont addHanSanSC:16.0f fontType:0];
    _cancelBtn.titleLabel.font = [UIFont addHanSanSC:16.0f fontType:0];
}

- (void)setBeginDate:(NSString *)beginDate {
    _beginDate = beginDate;
    _dateLabel.text = [NSString stringWithFormat:@"会客时间：%@",[ToolUtil isEqualToNonNullKong:_beginDate]];
}

- (void)setInviteCount:(NSInteger)inviteCount {
    _inviteCount = inviteCount;
    if (_inviteCount) {
        _titleLabel.text = [NSString stringWithFormat:@"已邀请%@人参加会客",@(_inviteCount)];
    }
}

- (void)setNumberRangeArray:(NSArray *)numberRangeArray {
    _numberRangeArray = numberRangeArray;
    
    if (_numberRangeArray && _numberRangeArray.count == 2) {
        _countLabel.text = [NSString stringWithFormat:@"会客人数：%@~%@人",_numberRangeArray.firstObject, _numberRangeArray.lastObject];
    }
}

- (void)setMeetingTips:(NSString *)meetingTips {
    _meetingTips = meetingTips;
    _tipsLabel.text = [NSString stringWithFormat:@"会客说明：%@", [ToolUtil isEqualToNonNullKong:_meetingTips]];
}

#pragma mark -
- (IBAction)clickToCancel:(id)sender {
    [self hide];
}
- (IBAction)clickToConfirm:(id)sender {
    [self hide:^{
        if (self.meetingConfirmBlock) self.meetingConfirmBlock();
    }];
}

@end

#pragma mark - AMMeetingEditCancelDialogView
@interface AMMeetingEditCancelDialogView () <AMTextViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet AMTextView *reasonTV;

@property (weak, nonatomic) IBOutlet AMButton *cancelBtn;
@property (weak, nonatomic) IBOutlet AMButton *confirmBtn;
@end

@implementation AMMeetingEditCancelDialogView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.mainCarrier = self.mainView;
    
    _titleLabel.font = [UIFont addHanSanSC:16.0f fontType:0];
    _reasonTV.font = [UIFont addHanSanSC:12.0f fontType:0];
    _reasonTV.ownerDelegate = self;
    
    _confirmBtn.titleLabel.font = [UIFont addHanSanSC:16.0f fontType:0];
    _cancelBtn.titleLabel.font = [UIFont addHanSanSC:16.0f fontType:0];
}

- (void)setStyle:(AMMeetingEditCancelDialogStyle)style {
    _style = style;
    if (_style == AMMeetingEditCancelDialogEdit) {
        _titleLabel.text = @"编辑会客说明";
        _reasonTV.placeholder = @"请输入会客说明(限300字)";
        _reasonTV.charCount = 300;
    }
    if (_style == AMMeetingEditCancelDialogCancel) {
        _titleLabel.text = @"确定取消会客";
        _reasonTV.placeholder = @"请输入取消原因";
    }
}

#pragma mark -
- (IBAction)clickToCancel:(id)sender {
    [self hide];
}
- (IBAction)clickToConfirm:(id)sender {
    @weakify(self);
    [self hide:^{
        @strongify(self);
        if (self.meetingInfoBlock) self.meetingInfoBlock(_reasonTV.text);
    }];
}
@end
