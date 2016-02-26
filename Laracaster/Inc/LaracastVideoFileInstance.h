//
//  LaracastVideoFileInstance.h
//  Laracaster
//
//  Created by Jackie Chung on 26/02/2016.
//  Copyright © 2016 Reactive Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LaracastVideoFileInstance : NSObject

@property (strong,nonatomic) NSString* sourceUrl;

@property (strong,nonatomic) NSString* fileName;

-(instancetype)initWithSourceUrl:(NSString*)url fileName:(NSString*)fileName;

-(void)assignGroup:(NSString*)groupName;

-(void)removeGroup:(NSString*)groupName;

-(NSArray*)allAssociatedGroups;

@end
