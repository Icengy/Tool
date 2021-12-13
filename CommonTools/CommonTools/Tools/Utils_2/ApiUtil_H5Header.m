//
//  ApiUtil_H5Header.m
//  ArtMedia2
//
//  Created by icnengy on 2020/10/26.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import "ApiUtil_H5Header.h"

@implementation ApiUtil_H5Header

+ (NSString *)h5_inviteFriends {
    return [NSString stringWithFormat:@"%@/h5/inviteFriends/index.html?uid=%@",URL_JAVA_HOST ,[UserInfoManager shareManager].uid];
}

+ (NSString *)h5_helpCenter:(NSInteger)flag {
    return [NSString stringWithFormat:@"%@/h5/helpcenter/index.html?flag=%@", URL_JAVA_HOST,@(flag)];
}

+ (NSString *)h5_identityPost {
    return [NSString stringWithFormat:@"%@/h5/identityPost/index.html", URL_JAVA_HOST];
}

+ (NSString *)h5_inviteNew {
    return [NSString stringWithFormat:@"%@/h5/inviteNew/index.html", URL_JAVA_HOST];
}

+ (NSString *)h5_YBSM {
    return [NSString stringWithFormat:@"%@/h5/agreement/index.html?articleCode=YBSM", URL_JAVA_HOST];
}

+ (NSString *)h5_YSRMTCZFWXY {
    return [NSString stringWithFormat:@"%@/h5/agreement/index.html?articleCode=YSRMTCZFWXY", URL_JAVA_HOST];
}

+ (NSString *)h5_inviteNewList {
    return [NSString stringWithFormat:@"%@/h5/inviteNew/index.html?uid=%@",URL_JAVA_HOST, [UserInfoManager shareManager].uid];
}

+ (NSString *)h5_ownerTips {
    return [NSString stringWithFormat:@"%@/h5/ownership/index.html", URL_JAVA_HOST];
}

+ (NSString *)h5_registerWith:(NSString *)invitation_code {
    return [NSString stringWithFormat:@"%@/wechat/#/inviteNew?uid=%@&invitation_code=%@",URL_JAVA_HOST, [UserInfoManager shareManager].uid, [ToolUtil isEqualToNonNull:invitation_code replace:@"0"]];
}

+ (NSString *)h5_identifConf:(NSString *)invitation_code {
    return [NSString stringWithFormat:@"%@/wechat/#/identifConf?uid=%@&invitation_code=%@", URL_JAVA_HOST, [UserInfoManager shareManager].uid, [ToolUtil isEqualToNonNull:invitation_code replace:@"0"]];
}

+ (NSString *)h5_goodDetail:(NSString *)gid {
    return [NSString stringWithFormat:@"%@/wechat/#/appShare/goodDetail?uid=%@&good_id=%@", URL_JAVA_HOST ,[UserInfoManager shareManager].uid, [ToolUtil isEqualToNonNull:gid replace:@"0"]];
}

+ (NSString *)h5_getCerdetail:(NSString *)gid {
    return [NSString stringWithFormat:@"%@/wechat/#/appShare/possess?ownerId=%@&goodId=%@", URL_JAVA_HOST, [UserInfoManager shareManager].uid,[ToolUtil isEqualToNonNull:gid replace:@"0"]];
}

+ (NSString *)h5_agreement:(NSString *)articleid {
    return [NSString stringWithFormat:@"%@/h5/agreement/index.html?articleCode=%@", URL_JAVA_HOST, articleid];
}

+ (NSString *)h5_showMoreInfo:(NSString *)uid {
    return [NSString stringWithFormat:@"%@/h5/agreement/index.html?uid=%@",URL_JAVA_HOST, uid];
}

+ (NSString *)h5_userInfoPre {
    return [NSString stringWithFormat:@"%@/h5/agreement/index.html?articleCode=YSRMTYHXY", URL_JAVA_HOST];
}


+ (NSString *)h5_auctionGoodDetail:(NSString *)auctionGoodId {
    return [NSString stringWithFormat:@"%@/h5/auctionItems/index.html?auctionGoodId=%@",URL_JAVA_HOST, auctionGoodId];
}

+ (NSString *)h5_shareForAuctionItems:(NSString *)auctionGoodId {
    return [NSString stringWithFormat:@"%@/wechat/#/appShare/auctionItems?auctionGoodId=%@",URL_JAVA_HOST, auctionGoodId];
}

+ (NSString *)h5_shareForspecOccas:(NSString *)auctionFieldId {
    return [NSString stringWithFormat:@"%@/wechat/#/appShare/specOccas?auctionFieldId=%@",URL_JAVA_HOST, auctionFieldId];
}

@end
