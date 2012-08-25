//
//  BackgroundTaskContainer.h
//  PDX Bus
//
//  Created by Andrew Wallace on 2/20/10.
//

/*

``The contents of this file are subject to the Mozilla Public License
     Version 1.1 (the "License"); you may not use this file except in
     compliance with the License. You may obtain a copy of the License at
     http://www.mozilla.org/MPL/

     Software distributed under the License is distributed on an "AS IS"
     basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
     License for the specific language governing rights and limitations
     under the License.

     The Original Code is PDXBus.

     The Initial Developer of the Original Code is Andrew Wallace.
     Copyright (c) 2008-2011 Andrew Wallace.  All Rights Reserved.''

 */

#import <Foundation/Foundation.h>
#import "BackgroundTaskProgress.h"
#import "ProgressModalView.h"

@protocol BackgroundTaskDone <NSObject>

- (void)BackgroundTaskDone:(UIViewController*)viewController cancelled:(bool)cancelled;
- (UIInterfaceOrientation)BackgroundTaskOrientation;

@optional

- (void)BackgroundTaskStarted;
- (bool)BackgroundTaskWait;

@end


@interface BackgroundTaskContainer : NSObject  <BackgroundTaskProgress,ProgressDelegate> {
	ProgressModalView *			_progressModal;
	id<BackgroundTaskDone>		_callbackComplete;
	id<BackgroundTaskProgress>	_callbackWhenFetching;
	NSThread *					_backgroundThread;
	NSString *					_title;
    NSString *                  _errMsg;
}

+ (BackgroundTaskContainer*) create:(id<BackgroundTaskDone>) done;
- (void)BackgroundThread:(NSThread *)thread;
- (void)BackgroundStart:(int)items title:(NSString *)title;
- (void)BackgroundItemsDone:(int)itemsDone;
- (void)BackgroundCompleted:(UIViewController*)viewController;
- (void)BackgroundSetErrorMsg:(NSString *)errMsg;

@property (nonatomic, retain)	NSString *					title;
@property (retain)				ProgressModalView *			progressModal;     // atomic for thread safety
@property (   atomic, assign)	id<BackgroundTaskDone>		callbackComplete;  // weak
@property (nonatomic, retain)	id<BackgroundTaskProgress>	callbackWhenFetching;
@property (nonatomic, retain)	NSThread *					backgroundThread;
@property (nonatomic, retain)   NSString *                  errMsg;


@end
