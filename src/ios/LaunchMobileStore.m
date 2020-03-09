/********* LaunchMobileStore.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>

@interface LaunchMobileStore : CDVPlugin {
  // Member variables go here.
}

- (void)openMobileAppStore:(CDVInvokedUrlCommand*)command;
@end

@implementation LaunchMobileStore

- (void)openMobileAppStore:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    
    NSString* appId = [command.arguments objectAtIndex:1];
    NSString* applicationKeyName = [command.arguments objectAtIndex:2];
    
    if(appId !=nil && [appId length] > 0) {
        NSString *iTunesLink = [NSString stringWithFormat:@"https://itunes.apple.com/app/%@", appId];
        //NSString *iTunesLink = [NSString stringWithFormat:@"itms://itunes.apple.com/us/app/apple-store/%@?mt=8", appId];
        NSURL *url = [NSURL URLWithString:[iTunesLink stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success){
            CDVPluginResult* pluginResult;
            if (success) {
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                 messageAsString:[NSString stringWithFormat:@"Success: %@ opened",iTunesLink]];
                [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
            } else {
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR
                                                 messageAsString:[NSString stringWithFormat:@"Failure: %@ not opened",iTunesLink]];
                [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
            }
        }];
    } else if(applicationKeyName != nil && [applicationKeyName length] > 0) {
        //Open OutSystems AppStore
        NSURL* webViewUrl = self.webViewEngine.URL;
        
        NSString * urlFormated = [NSString stringWithFormat:@"%@://%@/NativeAppBuilder/App?AppKey=%@", webViewUrl.scheme, webViewUrl.host, applicationKeyName];
        NSURL *url = [NSURL URLWithString:[urlFormated stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSLog(@"URL --> %@", urlFormated);
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success){
            CDVPluginResult* pluginResult;
            if (success) {
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                 messageAsString:[NSString stringWithFormat:@"Success: %@ opened",urlFormated]];
                [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
            } else {
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR
                                                 messageAsString:[NSString stringWithFormat:@"Failure: %@ not opened",urlFormated]];
                [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
            }
        }];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"No valid Parameters"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}


@end