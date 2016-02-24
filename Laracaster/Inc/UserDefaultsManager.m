//
//  UserDefaultsManager.m
//  Laracaster
//
//  Created by Jackie Chung on 18/02/2016.
//  Copyright © 2016 Reactive Studio. All rights reserved.
//

#import "UserDefaultsManager.h"

#import "UserDefaultKeys.h"

#define UserDefault [NSUserDefaults standardUserDefaults]

@implementation UserDefaultsManager

+(void)setUserDefaultWithName:(NSString *)defaultName withObject:(id)object{
    
    [UserDefault setObject:object forKey:defaultName];
    
    [UserDefault synchronize];
    
}

+(id)getObjectFromUserDefaultWithName:(NSString *)name{
    
    return [UserDefault objectForKey:name];
    
}

+(void)removeUserDefaultWithName:(NSString *)name{
    
    [UserDefault removeObjectForKey:name];
    
    [UserDefault synchronize];
}

+(BOOL)shouldShowRegisterSigninPrompt{
    
    if ([[self getObjectFromUserDefaultWithName:kUserDefaultNeverShowRegisterLoginPromptKey] isEqualToString:@"yes"]) {
        
        return NO;
        
    }
    
    return YES;
    
}

+(BOOL)shouldShowGestureTutorial{
    
    if ([[self getObjectFromUserDefaultWithName:kUserDefaultHasShownGestureTutorialKey] isEqualToString:@"yes"]) {
        
        return NO;
    }
    
    return YES;
}

@end
