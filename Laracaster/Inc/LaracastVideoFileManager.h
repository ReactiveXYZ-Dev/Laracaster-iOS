//
//  LaracastVideoFileManager.h
//  Laracaster
//
//  Created by Jackie Chung on 26/02/2016.
//  Copyright © 2016 Reactive Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LaracastVideoFileInstance;

@interface LaracastVideoFileManager : NSObject

+(instancetype)sharedManager;

// add file to the default group when initialized
-(void)addFileToDefaultGroup:(LaracastVideoFileInstance*)file;

// add file to designated group
-(void)addfile:(LaracastVideoFileInstance*)file ToDesignatedGroupWithName:(NSString*)groupName;

// move file to designated group
-(void)moveFile:(LaracastVideoFileInstance*)file fromGroup:(NSString*)fromGroup toGroup:(NSString*)toGroup;

// delete file from the disk and remove it from the associated groups
-(void)deleteFile:(LaracastVideoFileInstance*)file;

// delete file from the group
-(void)removeFile:(LaracastVideoFileInstance*)file fromGroup:(NSString*)groupName;

// retrieve all group names
-(NSArray*)allNonDefaultGroups;

// retrieve file instances from the default group
-(NSArray<LaracastVideoFileInstance*>*)filesFromTheDefaultGroup;

// retrieve file instances from a specific group
-(NSArray<LaracastVideoFileInstance*>*)filesFromSameGroup:(NSString*)groupName;

// save the video group configuration to file
-(BOOL)saveGroupMap;

// read the video group configuration to file
-(void)readGroupMap;

-(void)printDictionary;

@end
