//
//  Extensions.m
//  Laracaster
//
//  Created by Jackie Chung on 15/02/2016.
//  Copyright © 2016 Reactive Studio. All rights reserved.
//

#import "Extensions.h"

@implementation Extensions


+(UIColor*)colorFromHex:(NSString*)hex{
    
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hex];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];

    
}

@end
