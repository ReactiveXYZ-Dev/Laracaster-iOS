//
//  UserDefaultsManager.h
//  Laracaster
//
//  Created by Jackie Chung on 18/02/2016.
//  Copyright © 2016 Reactive Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaultsManager : NSObject

+(void)setUserDefaultWithName:(NSString*)defaultName withObject:(id)object;

+(id)getObjectFromUserDefaultWithName:(NSString*)name;

+(void)removeUserDefaultWithName:(NSString*)name;

+(BOOL)shouldShowRegisterSigninPrompt;

+(BOOL)shouldShowGestureTutorial;

@end
