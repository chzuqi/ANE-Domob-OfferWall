//
//  DomodExtensionHandler.m
//  DomodOfferWall
//
//  Created by CZQ on 14-5-29.
//
//

#import "DomodExtensionHandler.h"

@implementation DomodExtensionHandler

@synthesize context;
@synthesize converter;

#pragma mark -

- (id)initWithContext:(FREContext)extensionContext
{
    self = [super init];
    if (self) {
        self.context = extensionContext;
        self.converter = [[[DMTypeConversion alloc] init] autorelease];
    }
    return self;
}

- (void)dealloc {
    self.context = nil;
    self.converter = nil;
    _manager = nil;
    [super dealloc];
}


#pragma mark - Manager Delegate

// 积分墙开始加载数据
- (void)dmOfferWallManagerDidStartLoad:(DMOfferWallManager *)manager
                         offerWallType:(DMOfferWallType)type {
    
    switch (type) {
            
        case eDMOfferWallTypeList:
            NSLog(@"<demo>ListWallDidStartLoad");
            break;
        case eDMOfferWallTypeVideo:
            NSLog(@"<demo>VideoWallDidStartLoad");
            break;
        case eDMOfferWallTypeInterstitial:
            NSLog(@"<demo>InterstitialWallDidStartLoad");
            break;
        default:
            break;
    }
}

// 积分墙加载完成。
- (void)dmOfferWallManagerDidFinishLoad:(DMOfferWallManager *)manager
                          offerWallType:(DMOfferWallType)type {

    switch (type) {
            
        case eDMOfferWallTypeList:
            DISPATCH_STATUS_EVENT(self.context, [@"dmOfferWallManagerDidFinishLoad" UTF8String], [@"eDMOfferWallTypeList" UTF8String]);
            NSLog(@"<demo>ListWallDidFinishLoad");
            break;
        case eDMOfferWallTypeVideo:
            DISPATCH_STATUS_EVENT(self.context, [@"dmOfferWallManagerDidFinishLoad" UTF8String], [@"eDMOfferWallTypeVideo" UTF8String]);

            NSLog(@"<demo>VideoWallDidFinishLoad");
            break;
        case eDMOfferWallTypeInterstitial:
            DISPATCH_STATUS_EVENT(self.context, [@"dmOfferWallManagerDidFinishLoad" UTF8String], [@"eDMOfferWallTypeInterstitial" UTF8String]);
            NSLog(@"<demo>InterstitialWallDidFinishLoad");
            break;
        default:
            break;
    }
}

// 积分墙加载失败。可能的原因由error部分提供，例如网络连接失败、被禁用等。
- (void)dmOfferWallManager:(DMOfferWallManager *)manager
       failedLoadWithError:(NSError *)error
             offerWallType:(DMOfferWallType)type {
    
    switch (type) {
            
        case eDMOfferWallTypeList:
            NSLog(@"<demo>ListWallFailedLoadWithError:%@",error);
            break;
        case eDMOfferWallTypeVideo:
            NSLog(@"<demo>VideoWallFailedLoadWithError:%@",error);
            break;
        case eDMOfferWallTypeInterstitial:
            NSLog(@"<demo>InterstitialWallFailedLoadWithError:%@",error);
            break;
        default:
            break;
    }
}

// 当积分墙要被呈现出来时，回调该方法
- (void)dmOfferWallManagerWillPresent:(DMOfferWallManager *)manager
                        offerWallType:(DMOfferWallType)type {
    
    switch (type) {
            
        case eDMOfferWallTypeList:
            NSLog(@"<demo>ListWallWillPresent");
            break;
        case eDMOfferWallTypeVideo:
            NSLog(@"<demo>VideoWallWillPresent");
            break;
        case eDMOfferWallTypeInterstitial:
            NSLog(@"<demo>InterstitialWallWillPresent");
            break;
        default:
            break;
    }
}

//  积分墙页面关闭。
- (void)dmOfferWallManagerDidClosed:(DMOfferWallManager *)manager
                      offerWallType:(DMOfferWallType)type {
    
    switch (type) {
            
        case eDMOfferWallTypeList:
            NSLog(@"<demo>ListWallDidClosed");
            break;
        case eDMOfferWallTypeVideo:
            NSLog(@"<demo>VideoWallDidClosed");
            break;
        case eDMOfferWallTypeInterstitial:
            NSLog(@"<demo>InterstitialWallDidClosed");
            break;
        default:
            break;
    }
}

// 积分查询成功之后，回调该接口，获取总积分和总已消费积分。
- (void)dmOfferWallManager:(DMOfferWallManager *)manager
        receivedTotalPoint:(NSNumber *)totalPoint
        totalConsumedPoint:(NSNumber *)consumedPoint {
    NSString *result = [NSString stringWithFormat:@"{'totalPoint:'%ld,'consumedPoint':%ld}", (long)[totalPoint integerValue], (long)[consumedPoint integerValue]];
    DISPATCH_STATUS_EVENT(self.context, [@"receivedTotalPoint" UTF8String], [result UTF8String]);
//    _pointLabel.text = [NSString stringWithFormat:@"%d", [totalPoint integerValue]];
//    _consumeLabel.text = [NSString stringWithFormat:@"%d", [consumedPoint integerValue]];
}

// 积分查询失败之后，回调该接口，返回查询失败的错误原因。
- (void)dmOfferWallManager:(DMOfferWallManager *)manager
      failedCheckWithError:(NSError *)error {
    NSLog(@"<demo>dmOfferWallManager:failedCheckWithError:%@", error);
    
}

// 消费请求正常应答后，回调该接口，并返回消费状态（成功或余额不足），以及总积分和总已消费积分。
- (void)dmOfferWallManager:(DMOfferWallManager *)manager
    consumedWithStatusCode:(DMOfferWallConsumeStatus)statusCode
                totalPoint:(NSNumber *)totalPoint
        totalConsumedPoint:(NSNumber *)consumedPoint {
    
    NSString *result = [NSString stringWithFormat:@"{'totalPoint:'%ld,'consumedPoint':%ld}", (long)[totalPoint integerValue], (long)[consumedPoint integerValue]];

    
    switch (statusCode) {
        case eDMOfferWallConsumeSuccess:
            DISPATCH_STATUS_EVENT(self.context, [@"eDMOfferWallConsumeSuccess" UTF8String], [result UTF8String]);
//            [self.view makeToast:@"消费成功！"];
            break;
        case eDMOfferWallConsumeInsufficient:
            DISPATCH_STATUS_EVENT(self.context, [@"eDMOfferWallConsumeFail" UTF8String], [@"eDMOfferWallConsumeInsufficient" UTF8String]);
//            [self.view makeToast:@"消费失败，余额不足！"];
            break;
        case eDMOfferWallConsumeDuplicateOrder:
             DISPATCH_STATUS_EVENT(self.context, [@"eDMOfferWallConsumeFail" UTF8String], [@"eDMOfferWallConsumeDuplicateOrder" UTF8String]);
//            [self.view makeToast:@"订单重复！"];
            break;
        default:
            break;
    }
    
//    _pointLabel.text = [NSString stringWithFormat:@"%d", [totalPoint integerValue]];
//    _consumeLabel.text = [NSString stringWithFormat:@"%d", [consumedPoint integerValue]];
}

//  消费请求异常应答后，回调该接口，并返回异常的错误原因。
- (void)dmOfferWallManager:(DMOfferWallManager *)manager
    failedConsumeWithError:(NSError *)error {
    NSString *errorString = [error localizedDescription];
    DISPATCH_STATUS_EVENT(self.context, [@"eDMOfferWallConsumeFail" UTF8String], [errorString UTF8String]);
    NSLog(@"<demo>dmOfferWallManager:failedConsumeWithError:%@", error);
}

//  积分墙是否可用。
- (void)dmOfferWallManager:(DMOfferWallManager *)manager
      didCheckEnableStatus:(BOOL)enable {
    DISPATCH_STATUS_EVENT(self.context, [@"didCheckEnableStatus" UTF8String], [enable?@"true":@"false" UTF8String]);
//    _statusLabel.text = enable?@"可用":@"不可用";
}


#pragma main function

- (FREObject)DMInit:(FREObject)frePublisherID
{
    NSString *publisherId;
    if ([self.converter FREGetObject:frePublisherID asString:&publisherId] != FRE_OK)
    {
        return NULL;
    }
    _manager = [[DMOfferWallManager alloc] initWithPublisherID:publisherId
                                                     andUserID:nil];
    _manager.delegate = self;
    // !!!:重要：如果需要禁用应用内下载，请将此值设置为YES。
    _manager.disableStoreKit = NO;
    NSLog(@"init with publisherid: %@", publisherId);
    return NULL;
}

- (FREObject)DMConsume:(FREObject)frePoint
{
    NSString *point;
    if ([self.converter FREGetObject:frePoint asString:&point] != FRE_OK)
    {
        return NULL;
    }
    [_manager consumeWithPointNumber:point.length>0?[point integerValue]:0];
    return NULL;
}
- (FREObject)DMcheckSocre
{
    [_manager checkOwnedPoint];
    NSLog(@"checkOwnedPoint");
    return NULL;
}

- (FREObject)DMcheckStatus
{
    [_manager checkOfferWallEnableState];
    NSLog(@"checkOfferWallEnableState");
    return NULL;
}

- (FREObject)DMShowOfferWall
{
    [_manager presentOfferWallWithType:eDMOfferWallTypeList];
    NSLog(@"DMShowOfferWall");
    return NULL;
}
- (FREObject)DMShowVideoOfferWall
{
    [_manager presentOfferWallWithType:eDMOfferWallTypeVideo];
    return NULL;
}
- (FREObject)DMLoadInterstitialOfferWall
{
    [_manager loadInterstitialOfferWall];
    return NULL;
}
- (FREObject)DMShowInterstitialOfferWall
{
    [_manager presentOfferWallWithType:eDMOfferWallTypeInterstitial];
    return NULL;
}

@end
