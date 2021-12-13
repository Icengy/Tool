//
//  AMWKWebViewJavascriptBridge.m
//  ArtMedia2
//
//  Created by icnengy on 2020/10/26.
//  Copyright © 2020 翁磊. All rights reserved.
//

#import "AMWKWebViewJavascriptBridge.h"

@implementation AMWKWebViewJavascriptBridge

@dynamic friendShareMethod;
@dynamic ranksShareMethod;
@dynamic saveImgMethod;
@dynamic goArtistPageMethod;
@dynamic goVideoPageMethod;
@dynamic goProductPageMethod;
@dynamic goArtistAuthMethod;
@dynamic verifyLoginMethod;
@dynamic refreshPageMethod;

- (NSString *)friendShareMethod {
    return @"friendShare";
}

- (NSString *)ranksShareMethod {
    return @"ranksShare";
}

- (NSString *)saveImgMethod {
    return @"saveImg";
}

- (NSString *)goArtistPageMethod {
    return @"goArtistPage";
}

- (NSString *)goVideoPageMethod {
    return @"goVideoPage";
}

- (NSString *)goProductPageMethod {
    return @"goProductPage";
}

- (NSString *)goArtistAuthMethod {
    return @"goArtistAuth";
}

- (NSString *)verifyLoginMethod {
    return @"verifyLogin";
}

- (NSString *)getPageHeightMethod {
    return @"getPageHeight";
}

- (NSString *)refreshPageMethod {
    return @"refreshPage";
}

- (NSString *)goAuctionFieldMethod {
    return @"goAuctionField";
}

- (NSString *)goAuctionGoodsMethod {
    return @"goAuctionGood";
}

@end
