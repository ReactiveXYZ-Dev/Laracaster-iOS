//
//  LaracastVideoFileManager.m
//  Laracaster
//
//  Created by Jackie Chung on 26/02/2016.
//  Copyright © 2016 Reactive Studio. All rights reserved.
//

#import "LaracastVideoFileManager.h"

#import "LaracastVideoFileInstance.h"

static NSString* defaultVideoDirName = @"videos";

static NSString* defaultGroupName = @"default";

@interface LaracastVideoFileManager()

@property (strong,nonatomic) NSMutableDictionary<NSString*,NSMutableArray<LaracastVideoFileInstance*>*>* groupDictionary;

@end

@implementation LaracastVideoFileManager

+(instancetype)sharedManager{
    
    static LaracastVideoFileManager* manager = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
       
        manager = [[self alloc]init];
        
    });
    
    return manager;
    
}

-(instancetype)init{
    
    if (self = [super init]) {
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:[self pathToSaveGroupMap]]) {
            
            [self readGroupMap];
            
        }else{
            
            // initialize the group map
            _groupDictionary = [[NSMutableDictionary alloc]initWithObjects:@[[NSArray array]] forKeys:@[defaultGroupName]];
            
        }
        
    }
    
    return self;
    
}

#pragma mark - Public methods

-(void)addFileToDefaultGroup:(LaracastVideoFileInstance *)file{
    
    // add to the group dictionary
    [_groupDictionary[defaultGroupName] addObject:file];
    
    // assign the group name to the file
    [file assignGroup:defaultGroupName];
    
}

-(void)addfile:(LaracastVideoFileInstance*)file ToDesignatedGroupWithName:(NSString *)groupName{
    
    // add to the group dictionary
    if (!_groupDictionary[groupName]) {
        
        _groupDictionary[groupName] = (NSMutableArray*)@[];
        
    }
    
    [_groupDictionary[groupName] addObject:file];
    
    // assign the group name to the file
    [file assignGroup:groupName];
    
}

-(void)moveFile:(LaracastVideoFileInstance *)file fromGroup:(NSString *)fromGroup toGroup:(NSString *)toGroup{
    
    // change the group references
    [_groupDictionary[toGroup] addObject:file];
    
    [_groupDictionary[fromGroup] removeObject:file];
    
    // change group references on the object
    [file removeGroup:fromGroup];
     
    [file assignGroup:toGroup];
}

-(void)deleteFile:(LaracastVideoFileInstance *)file{
    
    // delete the actual video file
    NSString* videoPath = [self pathForVideoWithName:file.fileName];
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:videoPath]) {
        
        [manager removeItemAtPath:videoPath error:nil];
        
    }
    
    // remove all the group references
    for (NSString* groupName in [file allAssociatedGroups]) {
        
        if (_groupDictionary[groupName]) {
            
            [_groupDictionary[groupName] removeObject:file];
            
        }
        
    }
    
}

-(void)removeFile:(LaracastVideoFileInstance *)file fromGroup:(NSString *)groupName{
    
    // update the group references (well... pretty much add the file back to the default group)
    
    [self moveFile:file fromGroup:groupName toGroup:defaultGroupName];
    
}

-(NSArray*)allNonDefaultGroups{
    
    return [_groupDictionary allKeys];
    
}

-(NSArray<LaracastVideoFileInstance*>*)filesFromTheDefaultGroup{
    
    return _groupDictionary[defaultGroupName];
    
}

-(NSArray<LaracastVideoFileInstance*>*)filesFromSameGroup:(NSString *)groupName{
    
    return _groupDictionary[groupName];
    
}

-(BOOL)saveGroupMap{
    
    BOOL success = [NSKeyedArchiver archiveRootObject:_groupDictionary toFile:[self pathToSaveGroupMap]];
    
    return success;
    
}

-(void)readGroupMap{
    
    _groupDictionary = [NSKeyedUnarchiver unarchiveObjectWithFile:[self pathToSaveGroupMap]];
    
}

-(void)printDictionary{
    
    NSLog(@"%@",_groupDictionary);
    
}

#pragma mark - Private methods
-(NSString*)pathForVideoWithName:(NSString*)fileName{
    
    NSString* documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    return [[documentPath stringByAppendingPathComponent:defaultVideoDirName] stringByAppendingPathComponent:fileName];
}

-(NSString*)pathToSaveGroupMap{
    
    NSString* documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    return [documentPath stringByAppendingPathComponent:@"groups.dat"];
    
}

@end
