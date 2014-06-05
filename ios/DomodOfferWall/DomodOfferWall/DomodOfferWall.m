/*
 * DomodOfferWall.m
 * DomodOfferWall
 *
 * Created by CZQ on 14-5-29.
 * Copyright (c) 2014年 czqsoft. All rights reserved.
 */

#import "DomodOfferWall.h"
#import "DomodExtensionHandler.h"

DomodExtensionHandler* domod_handle;


/* DomodOfferWallExtInitializer()
 * The extension initializer is called the first time the ActionScript side of the extension
 * calls ExtensionContext.createExtensionContext() for any context.
 *
 * Please note: this should be same as the <initializer> specified in the extension.xml 
 */
void DomodOfferWallExtInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet) 
{
    NSLog(@"Entering DomodOfferWallExtInitializer()");

    *extDataToSet = NULL;
    *ctxInitializerToSet = &DomodOfferWallContextInitializer;
    *ctxFinalizerToSet = &DomodOfferWallContextFinalizer;

    NSLog(@"Exiting DomodOfferWallExtInitializer()");
}

/* DomodOfferWallExtFinalizer()
 * The extension finalizer is called when the runtime unloads the extension. However, it may not always called.
 *
 * Please note: this should be same as the <finalizer> specified in the extension.xml 
 */
void DomodOfferWallExtFinalizer(void* extData) 
{
    return;
}

/* ContextInitializer()
 * The context initializer is called when the runtime creates the extension context instance.
 */
void DomodOfferWallContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet)
{
    static FRENamedFunction func[] = 
    {
        MAP_FUNCTION(DMInit, NULL),
        MAP_FUNCTION(DMConsume, NULL),
        MAP_FUNCTION(DMcheckSocre, NULL),
        MAP_FUNCTION(DMcheckStatus, NULL),
        MAP_FUNCTION(DMShowOfferWall, NULL),
        MAP_FUNCTION(DMShowVideoOfferWall, NULL),
        MAP_FUNCTION(DMLoadInterstitialOfferWall, NULL),
        MAP_FUNCTION(DMShowInterstitialOfferWall, NULL),

    };
    
    *numFunctionsToTest = sizeof(func) / sizeof(FRENamedFunction);
    *functionsToSet = func;
    
    domod_handle = [[DomodExtensionHandler alloc]initWithContext:ctx];
    
    NSLog(@"Exiting ContextInitializer()");
}

/* ContextFinalizer()
 * The context finalizer is called when the extension's ActionScript code
 * calls the ExtensionContext instance's dispose() method.
 * If the AIR runtime garbage collector disposes of the ExtensionContext instance, the runtime also calls ContextFinalizer().
 */
void DomodOfferWallContextFinalizer(FREContext ctx)
{
    NSLog(@"Entering ContextFinalizer()");

    // Nothing to clean up.
    NSLog(@"Exiting ContextFinalizer()");
    return;
}

ANE_FUNCTION(DMInit)
{
    return [domod_handle DMInit:argv[0]];
}
ANE_FUNCTION(DMConsume)
{
    return [domod_handle DMConsume:argv[0]];
}
ANE_FUNCTION(DMcheckSocre)
{
    return [domod_handle DMcheckSocre];
}
ANE_FUNCTION(DMcheckStatus)
{
    return [domod_handle DMcheckStatus];
}
ANE_FUNCTION(DMShowOfferWall)
{
    return [domod_handle DMShowOfferWall];
}
ANE_FUNCTION(DMShowVideoOfferWall)
{
    return [domod_handle DMShowVideoOfferWall];
}
ANE_FUNCTION(DMLoadInterstitialOfferWall)
{
    return [domod_handle DMLoadInterstitialOfferWall];
}
ANE_FUNCTION(DMShowInterstitialOfferWall)
{
    return [domod_handle DMShowInterstitialOfferWall];
}

