//
//  AMShareView.m
//  ArtMedia2
//
//  Created by 美术传媒 on 2019/11/27.
//  Copyright © 2019年 lcy. All rights reserved.
//

#import "AMShareView.h"

#import "WechatManager.h"

@interface AMShareView () <UIGestureRecognizerDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cancelBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cancelHeightContstraint;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic ,strong) UICollectionViewFlowLayout *layout;

@property (weak, nonatomic) IBOutlet AMButton *cancelBtn;

@property (nonatomic ,strong) NSMutableArray <NSArray *>*dataArray;
@property (nonatomic ,assign) AMShareViewStyle style;

@end

@implementation AMShareView
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WXShareResult object:nil];
}

- (NSMutableArray <NSArray *>*)dataArray {
    _dataArray = [NSMutableArray new];
    switch (_style) {
        case AMShareViewStyleDefalut: {
            [_dataArray addObjectsFromArray:@[@[[self reportModel], [self shieldModel]]]];
            break;
        }
        case AMShareViewStyleShare: {
            [_dataArray addObjectsFromArray:@[@[[self reportModel], [self shieldModel]]]];
            NSMutableArray *dataArray = @[].mutableCopy;
            [dataArray addObject:[self copyModel]];
            if ([WXApi isWXAppInstalled]) {
                [dataArray insertObject:[self wxFriendModel] atIndex:0];
                [dataArray insertObject:[self wxModel] atIndex:0];
            }
            [_dataArray insertObject:dataArray.copy atIndex:0];
            break;
        }
        case AMShareViewStyleInvite: {
            NSMutableArray *dataArray = @[].mutableCopy;
            [dataArray addObject:[self copyModel]];
            if ([WXApi isWXAppInstalled]) {
                [dataArray insertObject:[self wxFriendModel] atIndex:0];
                [dataArray insertObject:[self wxModel] atIndex:0];
            }
            [_dataArray insertObject:dataArray.copy atIndex:0];
            break;
        }
        case AMShareViewStyleImage: {
            NSMutableArray *dataArray = @[].mutableCopy;
            if ([WXApi isWXAppInstalled]) {
                [dataArray insertObject:[self wxFriendModel] atIndex:0];
                [dataArray insertObject:[self wxModel] atIndex:0];
            }
            [_dataArray insertObject:dataArray.copy atIndex:0];
            break;
        }
            
        default:
            break;
    }
    return _dataArray;
}

/// 微信好友
- (AMShareViewModel *)wxModel {
    AMShareViewModel *model = [[AMShareViewModel alloc] init];
    model.itemStyle = AMShareViewItemStyleWX;
    model.title = @"微信";
    model.image = @"Wechat";
    
    return model;
}

/// 微信朋友圈
- (AMShareViewModel *)wxFriendModel {
    AMShareViewModel *model = [[AMShareViewModel alloc] init];
    model.itemStyle = AMShareViewItemStyleWXFriend;
    model.title = @"朋友圈";
    model.image = @"WXFriendIcon";
    return model;
}

/// 复制
- (AMShareViewModel *)copyModel {
    AMShareViewModel *model = [[AMShareViewModel alloc] init];
    model.itemStyle = AMShareViewItemStyleCopy;
    model.title = @"复制";
    model.image = @"Copy";
    return model;
}

/// 屏蔽
- (AMShareViewModel *)saveLocalModel {
    AMShareViewModel *model = [[AMShareViewModel alloc] init];
    model.itemStyle = AMShareViewItemStyleShield;
    model.title = @"保存本地";
    model.image = @"ic_save";
    return model;
}


/// 举报
- (AMShareViewModel *)reportModel {
    AMShareViewModel *model = [[AMShareViewModel alloc] init];
    model.itemStyle = AMShareViewItemStyleReport;
    model.title = @"举报";
    model.image = @"report";
    return model;
}

/// 屏蔽
- (AMShareViewModel *)shieldModel {
    AMShareViewModel *model = [[AMShareViewModel alloc] init];
    model.itemStyle = AMShareViewItemStyleShield;
    model.title = @"屏蔽此条";
    model.image = @"unlike";
    return model;
}


- (UICollectionViewFlowLayout *)layout {
	if (!_layout) {
		_layout = [[UICollectionViewFlowLayout alloc] init];

		_layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
		_layout.itemSize = CGSizeMake(_collectionView.height, _collectionView.height);
		_layout.minimumLineSpacing = 0.1f;
		_layout.minimumInteritemSpacing = 0.1f;

	}return _layout;
}

+ (AMShareView *)shareInstanceWithStyle:(AMShareViewStyle)style {
    AMShareView *shareView = [AMShareView shareInstance];
    shareView.style = style;
    
    return shareView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([WXApi isWXAppInstalled]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shareResp:) name:WXShareResult object:nil];
    }
    
    self.frame = k_Bounds;
    if (@available(iOS 13.0, *)) {
        [self setOverrideUserInterfaceStyle:UIUserInterfaceStyleLight];
    }
    
    _collectionView.collectionViewLayout = self.layout;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.alwaysBounceHorizontal = YES;
    
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([AMShareViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([AMShareViewCell class])];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"AMShareViewCellHeader"];
    
    _cancelBtn.titleLabel.font = [UIFont addHanSanSC:14.0f fontType:0];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
}

- (void)setFrame:(CGRect)frame {
    [self.contentView addRoundedCorners:UIRectCornerTopLeft | UIRectCornerTopRight withRadii:CGSizeMake(12.0f, 12.0f)];
    
    [super setFrame:frame];
}

- (void)shareResp:(NSNotification *)noti {
	NSDictionary *dict = [noti.object yy_modelToJSONObject];
	if ([dict[@"isFinish"] boolValue]) {
        [SVProgressHUD showSuccess:@"分享完成" completion:^{
            [self hide];
        }];
	}else {
		[SVProgressHUD showError:[NSString stringWithFormat:@"分享失败，%@",dict[@"errorStr"]] completion:^{
			[self hide];
		}];
	}
}

- (void)setStyle:(AMShareViewStyle)style {
    _style = style;
}

#pragma mark -
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return self.dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return [self.dataArray[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	AMShareViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([AMShareViewCell class]) forIndexPath:indexPath];
    
    cell.model = [self.dataArray[indexPath.section] objectAtIndex:indexPath.item];
	
	return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
	if (section)
		return CGSizeMake(1.0f, collectionView.height);
	return CGSizeZero;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
	UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"AMShareViewCellHeader" forIndexPath:indexPath];
	header.backgroundColor = [UIColor clearColor];
	if (indexPath.section) {
		UIView *line = [[UIView alloc] init];
		[header addSubview:line];
		line.backgroundColor = RGBA(247, 247, 247, 0.9);
		[line mas_makeConstraints:^(MASConstraintMaker *make) {
			make.center.width.equalTo(header);
			make.height.offset(header.height*0.8);
		}];
	}
	
	return header;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	[collectionView deselectItemAtIndexPath:indexPath animated:YES];
	
    AMShareViewModel *model = (AMShareViewModel *)[self.dataArray[indexPath.section] objectAtIndex:indexPath.item];
    switch (model.itemStyle) {
        case AMShareViewItemStyleWX:
        case AMShareViewItemStyleWXFriend: {
            if (_style == AMShareViewStyleImage) {
                if (self.delegate && [self.delegate respondsToSelector:@selector(shareView:didSelectedWithItemStyle:)])  {
                    [self.delegate shareView:self didSelectedWithItemStyle:model.itemStyle];
                }
            }else {
                [[WechatManager shareManager] wxSendReqWithScene:model.itemStyle withParams:_params];
            }
            break;
        }
        case AMShareViewItemStyleCopy: {
            [self clickToPasted];
            break;
        }
        case AMShareViewItemStyleSaveLocal: {
            if (self.delegate && [self.delegate respondsToSelector:@selector(shareView:didSelectedWithItemStyle:)])  {
                [self.delegate shareView:self didSelectedWithItemStyle:model.itemStyle];
            }
            break;
        }
        case AMShareViewItemStyleReport:
        case AMShareViewItemStyleShield: {
            if (self.delegate && [self.delegate respondsToSelector:@selector(shareView:didSelectedWithItemStyle:)])  {
                [self.delegate shareView:self didSelectedWithItemStyle:model.itemStyle];
            }
            break;
        }
            
        default:
            break;
    }
}

#pragma mark -
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
	if ([touch.view isDescendantOfView:self.contentView]) {
		return NO;
	}
	return YES;
}


#pragma mark -
- (IBAction)clickToCancel:(AMButton *)sender {
	[self hide];
}

- (void)clickToPasted {
	UIPasteboard *pasted = [UIPasteboard generalPasteboard];
	pasted.string = [ToolUtil isEqualToNonNullKong:_params[@"url"]];
	[SVProgressHUD showSuccess:@"复制成功" completion:^{
		[self hide];
	}];
}

@end

