/*  
 * DomodOfferWall
 *
 * Created by CZQ on 14-5-29.
 * Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
*/

#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"

#define ANE_FUNCTION(f) FREObject (f)(FREContext ctx, void *data, uint32_t argc, FREObject argv[])
#define MAP_FUNCTION(f, data) { (const uint8_t*)(#f), (data), &(f) }

/* DomodOfferWallExtInitializer()
 * The extension initializer is called the first time the ActionScript side of the extension
 * calls ExtensionContext.createExtensionContext() for any context.
 *
 * Please note: this should be same as the <initializer> specified in the extension.xml 
*/
void DomodOfferWallExtInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet);

/* DomodOfferWallExtFinalizer()
 * The extension finalizer is called when the runtime unloads the extension. However, it may not always called.
 *
 * Please note: this should be same as the <finalizer> specified in the extension.xml 
*/
void DomodOfferWallExtFinalizer(void* extData);

/* ContextInitializer()
 * The context initializer is called when the runtime creates the extension context instance.
*/
void DomodOfferWallContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet);

/* ContextFinalizer()
 * The context finalizer is called when the extension's ActionScript code
 * calls the ExtensionContext instance's dispose() method.
 * If the AIR runtime garbage collector disposes of the ExtensionContext instance, the runtime also calls ContextFinalizer().
*/
void DomodOfferWallContextFinalizer(FREContext ctx);

/* This is a sample function that is being included as part of this template. 
 *
 * Users of this template are expected to change this and add similar functions 
 * to be able to call the native functions in the ANE from their ActionScript code
*/
ANE_FUNCTION(DMInit);
ANE_FUNCTION(DMConsume);
ANE_FUNCTION(DMcheckSocre);
ANE_FUNCTION(DMcheckStatus);
ANE_FUNCTION(DMShowOfferWall);
ANE_FUNCTION(DMShowVideoOfferWall);
ANE_FUNCTION(DMLoadInterstitialOfferWall);
ANE_FUNCTION(DMShowInterstitialOfferWall);
