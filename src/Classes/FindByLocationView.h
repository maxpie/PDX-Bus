//
//  FindByLocationView.h
//  PDX Bus
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

#import <UIKit/UIKit.h>
#import "StopLocations.h"
#import "XMLAllStops.h"
#import "LocatingView.h"


@interface FindByLocationView : TableViewWithToolbar<LocatingViewDelegate>  {
	int                     _maxToFind;
	TripMode                _mode;
	int                     _show;
	int                     _dist;
	double                  _minDistance;
	int                     _routeCount;
	int                     _maxRouteCount;
	NSArray *               _cachedRoutes;
	NSMutableDictionary *   _lastLocate;
    int                     _autoLaunch;
    NSDictionary *          _launchArgs;
    int                     _firstDisplay;
}

- (id) init;
- (id) initAutoLaunch;


@property (nonatomic, retain) NSArray *cachedRoutes;
@property (nonatomic, retain) NSMutableDictionary *lastLocate;
@property (nonatomic)         int autoLaunch;


- (void)distSegmentChanged:(id)sender;
- (void)modeSegmentChanged:(id)sender;
- (void)showSegmentChanged:(id)sender;
- (void)actionArgs:(NSDictionary *)args;

@end
