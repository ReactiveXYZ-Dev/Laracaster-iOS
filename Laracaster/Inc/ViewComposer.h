//
//  ViewComposer.h
//  Laracaster
//
//  Created by Jackie Chung on 18/02/2016.
//  Copyright © 2016 Reactive Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewComposer : NSObject

+(instancetype)sharedComposer;

// For generating HUDS
-(void)showToastWithMessage:(NSString*)message andDuration:(float)duration;

@end
