//
//  DomodExtensionHandler.h
//  DomodOfferWall
//
//  Created by CZQ on 14-5-29.
//
//

#import <Foundation/Foundation.h>
#import "DMOfferWallManager.h"
#import "FlashRuntimeExtensions.h"
#import "DMTypeConversion.h"

#define DISPATCH_STATUS_EVENT(extensionContext, code, status) FREDispatchStatusEventAsync((extensionContext), (uint8_t*)code, (uint8_t*)status)


@interface DomodExtensionHandler : NSObject<DMOfferWallManagerDelegate> {
    DMOfferWallManager* _manager;
}

@property (nonatomic, assign) FREContext context;
@property (nonatomic, retain) DMTypeConversion *converter;


- (id)initWithContext:(FREContext)extensionContext;
- (FREObject)DMInit:(FREObject)frePublisherID;
- (FREObject)DMConsume:(FREObject)frePoint;
- (FREObject)DMcheckSocre;
- (FREObject)DMcheckStatus;
- (FREObject)DMShowOfferWall;
- (FREObject)DMShowVideoOfferWall;
- (FREObject)DMLoadInterstitialOfferWall;
- (FREObject)DMShowInterstitialOfferWall;

@end
