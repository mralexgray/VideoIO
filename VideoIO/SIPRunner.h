//
//  SIPRunner.h
//  VideoIO
//
//  Created by Alex Gray on 09/03/2013.
//  Copyright (c) 2013 Alex Gray. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SIPRunner : NSOperationQueue

@property (nonatomic, strong) NSTask *rtmplite, *sipd;



// Designated initializer.

@end


//@interface SIPdOperation : NSOperation
//
//// Designated initializer.
//- (id)initWithWaitTime:(NSTimeInterval)waitTime;
//
//@end

