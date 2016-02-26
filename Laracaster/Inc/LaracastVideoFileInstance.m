//
//  LaracastVideoFileInstance.m
//  Laracaster
//
//  Created by Jackie Chung on 26/02/2016.
//  Copyright © 2016 Reactive Studio. All rights reserved.
//

#import "LaracastVideoFileInstance.h"

@interface LaracastVideoFileInstance()

@property (strong,nonatomic) NSMutableArray* associatedGroups;

@end

@implementation LaracastVideoFileInstance

-(instancetype)initWithSourceUrl:(NSString *)url fileName:(NSString *)fileName{
    
    if (self = [super init]) {
        
        _sourceUrl = url;
        
        _fileName = fileName;
        
        _associatedGroups = (NSMutableArray*)@[];
    }
    
    return self;
    
}

-(void)assignGroup:(NSString *)groupName{
    
    [_associatedGroups addObject:groupName];
    
}

-(void)removeGroup:(NSString *)groupName{
    
    [_associatedGroups removeObject:groupName];
}

-(NSArray*)allAssociatedGroups{
    
    return _associatedGroups;
    
}

@end
