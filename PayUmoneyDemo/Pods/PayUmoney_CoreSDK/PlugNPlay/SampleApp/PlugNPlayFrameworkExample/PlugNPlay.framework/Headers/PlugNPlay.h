//
//  PlugNPlay.h
//  PlugNPlay
//
//  Created by Mukesh Patil on 1/13/17.
//  Copyright © 2017 Citrus Payment Solutions, Pvt. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <PayUMoneyCoreSDK/PayUMoneyCoreSDK.h>

#import "Version.h"
//#import "PlugAndPlayPayment.h"
#import "PnPToolbar.h"
#import "PnPUtility.h"
#import "UIUtility.h"
#import "LeftRightStrip.h"
//#import "PnPSetupAutoLoadView.h"
#import "PnPWalletManagementConstants.h"
#import "PnPCvvInputViewController.h"
#import "PnPWalletPayViewController.h"
#import "PnPAddCardViewController.h"
//#import "PnPCardManagementTableViewCell.h"

typedef void (^WalletValidationErrorCompletionHandler)(NSError *error);
typedef void (^PnPPaymentCompletionBlock)(NSDictionary *paymentResponse, NSError *error, id extraParam);
typedef void (^PaymentCompletionHandler)(NSDictionary *paymentResponse, NSError *error);


@interface PlugNPlay : NSObject

//When Sent YES, it disables the Wallet payment UI in the Plug and Play Payment UI
+(void)setDisableWallet:(BOOL)isDisabled;

//When Sent YES, it disables the Cards payment UI in the Plug and Play Payment UI
+(void)setDisableCards:(BOOL)isDisabled;

//When Sent YES, it disables the Netbanking payment UI in the Plug and Play Payment UI
+(void)setDisableNetbanking:(BOOL)isDisabled;

//When Sent YES, it disables the payment Completion Screen, app gets back to merchant app immideatly after the payment
+(void)setDisableCompletionScreen:(BOOL)isDisabled;

//sets the top bar color of the Plug and  Play SDK UI
+(void)setTopBarColor:(UIColor *)color;

//sets the top bar title text color of the Plug and  Play SDK UI
+(void)setTopTitleTextColor:(UIColor *)color;

//sets the bottom button color of the Plug and  Play SDK UI
+(void)setButtonColor:(UIColor *)color;

//sets the bottom button text color of the Plug and  Play SDK UI
+(void)setButtonTextColor:(UIColor *)color;


//sets the Merchant display name of the Plug and  Play SDK UI
+(void)setMerchantDisplayName:(NSString *)merchantDisplayName;

//sets the view returning view controller
+(void)setReturningViewController:(UIViewController*)vc;

//sets the indicator tint color on PnP UI
+(void)setIndicatorTintColor:(UIColor*)color;

//set payment paramters
//+(void)setPaymentParams:(PUMRequestParams*)paymentParams;

//Getters
+(BOOL)disableWallet;
+(BOOL)disableCards;
+(BOOL)disableNetbanking;
+(BOOL)disableCompletionScreen;

+(UIColor*)topBarColor;
+(UIColor*)topTitleTextColor;
+(UIColor*)buttonColor;
+(UIColor*)buttonTextColor;

+(NSString*)merchantDisplayName;
+(UIViewController*)returningViewController;
+(UIColor*)indicatorTintColor;

//+(PUMRequestParams*)getPaymentParams;


+(void)presentPaymentViewControllerWithTxnParams:(PUMTxnParam*)txnParam
                                onViewController:(UIViewController*)viewController
                             withCompletionBlock:(PnPPaymentCompletionBlock)completionBlock;


@end
