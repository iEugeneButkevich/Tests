//
//  AppDelegate.m
//  StringsTest
//
//  Created by Eugene Butkevich on 8/4/16.
//  Copyright © 2016 offsiteteam. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //1
    NSString* string1 = @"Hello World!";
    NSRange range1 = [string1 rangeOfString:@"World" options:NSCaseInsensitiveSearch];
    if (range1.location != NSNotFound) {
        NSLog(@"RANGE1 = %@", NSStringFromRange(range1));
    } else {
        NSLog(@"NOT FOUND");
    }
    
    //2
    NSString* string2 = @"The NSString class and its mutable subclass, NSMutableString, provide an extensive set of APIs for working with strings, including methods for comparing, searching, and modifying strings. NSString objects are used extensively throughout Foundation and other Cocoa frameworks, serving as the basis for all textual and linguistic functionality on the platform.NSString is “toll-free bridged” with its Core Foundation counterpart, CFStringRef. See “Toll-Free Bridging” for more information.String ObjectsAn NSString object encodes a Unicode-compliant text string, represented as a sequence of UTF–16 code units. All lengths, character indexes, and ranges are expressed in terms of 16-bit platform-endian values, with index values starting at 0.An NSString object can be initialized from or written to a C buffer, an NSData object, or the contents of an NSURL. It can also be encoded and decoded to and from ASCII, UTF–8, UTF–16, UTF–32, or any other string encoding represented by NSStringEncoding.NOTEAn immutable string is a text string that is defined when it is created and subsequently cannot be changed. An immutable string is implemented as an array of UTF–16 code units (in other words, a text string). To create and manage an immutable string, use the NSString class. To construct and manage a string that can be changed after it has been created, use NSMutableString.The objects you create using NSString and NSMutableString are referred to as string objects (or, when no confusion will result, merely as strings). The term C string refers to the standard char * type. Because of the nature of class clusters, string objects aren’t actual instances of the NSString or NSMutableString classes but of one of their private subclasses. Although a string object’s class is private, its interface is public, as declared by these abstract superclasses, NSString and NSMutableString.";
    NSRange range2 = [string2 rangeOfString:@"See “Toll-Free Bridging” for more"];
    NSString* subString2;
    if (range2.location != NSNotFound) {
        subString2 = [string2 substringToIndex:range2.location];
    }
    NSLog(@"SUBSTRING2 = %@", subString2);
    
    //3
    NSRange searchRange = NSMakeRange(0, [string2 length]);
    NSInteger counter = 0;
    while (YES) {
        NSRange range = [string2 rangeOfString:@"NSString" options:0 range:searchRange];
        if (range.location != NSNotFound) {
            NSInteger index = range.location + range.length;
            searchRange.location = index;
            searchRange.length = string2.length - index;
            counter++;
        } else {
            break;
        }
    }
    NSLog(@"COUNTER = %ld", (long)counter);
    
    NSString* string2AfterReplacing = [string2 stringByReplacingOccurrencesOfString:@"NSString" withString:@"PIY-PIY"];
    NSLog(@"AFTER REPLACING: \n%@", string2AfterReplacing);
    
    //4
    NSArray* arrayOfStrings = [string2 componentsSeparatedByString:@" "];
    NSLog(@"ARRAY OF STRINGS: \n %@", arrayOfStrings);
    NSString* joinedString = [arrayOfStrings componentsJoinedByString:@"_"];
    NSLog(@"JOINED STRING: %@", joinedString);
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
