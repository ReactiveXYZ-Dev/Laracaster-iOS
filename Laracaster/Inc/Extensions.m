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

+(UIColor*)randomMaterialColor{
    
    NSArray* colorList = @[@"#e57373",@"#ba68c8",@"#9575cd",@"#7986cb",@"#64b5f6",@"#4dd0e1",@"#81c784",@"#ffb74d",@"#a1887f"];
    
    NSUInteger index = arc4random_uniform((int)colorList.count);
    
    return [self colorFromHex:colorList[index]];
}



@end
