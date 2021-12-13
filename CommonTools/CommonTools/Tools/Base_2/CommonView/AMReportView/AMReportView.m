//
//  AMReportView.m
//  ArtMedia2
//
//  Created by 美术传媒 on 2020/1/13.
//  Copyright © 2020 lcy. All rights reserved.
//

#import "AMReportView.h"

#import "AMReportViewCell.h"

@interface AMReportView () <UIGestureRecognizerDelegate, UITableViewDelegate ,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cancelHeightContraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cancelBottomContraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightContraint;
@property (weak, nonatomic) IBOutlet AMButton *cancelBtn;

@end

@implementation AMReportView {
	NSMutableArray *_dataArray;
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
    
    self.frame = [UIApplication sharedApplication].keyWindow.bounds;
    
    _dataArray = [NSMutableArray arrayWithArray:@[@"色情低俗", @"政治敏感", @"恐怖血腥", @"封面恶心", @"其他"]];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    
    _cancelHeightContraint.constant = 44.0f;
    _cancelBtn.layer.cornerRadius = 4.0f;
    _cancelBtn.clipsToBounds = YES;
    
    _tableViewHeightContraint.constant = 44.0f*(_dataArray.count + 1);
    
    _tableView.scrollEnabled = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 44.0f;
    [_tableView reloadData];
}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 44.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	UIView *wrapView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.width, 44.0f)];
	wrapView.backgroundColor = Color_Whiter;
	
	UILabel *label = [[UILabel alloc] init];
	[wrapView addSubview:label];
	[label mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.offset(0);
	}];
	
	label.text = @"请选择举报原因";
	label.textColor = Color_Grey;
	label.textAlignment = NSTextAlignmentCenter;
	label.font = [UIFont addHanSanSC:14.0f fontType:0];
	
	return wrapView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
	return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
	}else {
		[cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
	}
	
	cell.selectionStyle = UITableViewCellSelectionStyleDefault;
	
    cell.contentView.backgroundColor = Color_Whiter;
	cell.textLabel.textAlignment = NSTextAlignmentCenter;
	cell.textLabel.font = [UIFont addHanSanSC:15.0f fontType:0];
	cell.textLabel.textColor = Color_Black;
	cell.textLabel.text = _dataArray[indexPath.row];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSMutableDictionary *params = @{}.mutableCopy;
    
    params[@"obj_id"] = self.obj_id;
    params[@"obj_type"] = self.obj_type;
    params[@"user_id"] = [UserInfoManager shareManager].uid;
    
    [ApiUtil postWithParent:nil url:[ApiUtilHeader reportObject] params:params.copy success:^(NSInteger code, id  _Nullable response) {
        [SVProgressHUD showSuccess:@"举报成功！\n我们将在24小时内对您提供的举报信息进行处理！" completion:^{
            [self hide];
        }];
    } fail:nil];
}

#pragma mark -
- (void)showReport {
	[SVProgressHUD dismiss];
	[SVProgressHUD showSuccess:@"举报成功！\n我们将在24小时内对您提供的举报信息进行处理！" completion:^{
		[self hide];
	}];
}

#pragma mark -
- (void)showShareView {
	[[UIApplication sharedApplication].keyWindow addSubview:self];
	
	[UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^ {
		NSLog(@"in animate start");
	} completion:^(BOOL finished) {
		NSLog(@"in animate completion");
		dispatch_async(dispatch_get_main_queue(), ^{
			[self.tableView reloadData];
			[SVProgressHUD dismiss];
		});
	}];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
	if ([touch.view isDescendantOfView:self.contentView]) {
		return NO;
	}
	return YES;
}

- (IBAction)clickToCancel:(id)sender {
	[self hide];
}

@end
