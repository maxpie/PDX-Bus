//
//  Departure.h
//  TriMetTimes
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
#import "TriMetTypes.h"
#import <MapKit/MkAnnotation.h>
#import "MapPinColor.h"
#import "TableViewWithToolbar.h"

@class XMLDepartures, Trip;

#define kDepartureCellHeight	55
#define kWideDepartureCellHeight 85
#define kDepartureCellId	@"DepartureTime"
#define kBigDepartureId     @"BigDeparture"

typedef enum {
	kStatusEstimated =0,
	kStatusScheduled,
	kStatusDelayed,
	kStatusCancelled
} kStatus;

@interface Departure : NSObject <MapPinColor> {
	NSString *			_route;
	NSString *			_fullSign;
	NSString *			_errorMessage;
	NSString *			_routeName;
	NSString *			_block;
	NSString *			_dir;
	NSString *			_locid;
	TriMetTime			_departureTime;
	TriMetTime			_scheduledTime;
	kStatus				_status;    
	bool				_detour;
	TriMetDistance		_blockPositionFeet;
	TriMetTime			_blockPositionAt;
	NSString *			_blockPositionLat;
	NSString *			_blockPositionLng;
	NSString *			_locationDesc;
	NSString *			_locationDir;
	bool				_hasBlock;
	TriMetTime			_queryTime;
	TriMetTime			_nextBus;
    NSDate              *_cacheTime;
	bool				_streetcar;
	NSMutableArray *	_trips;
	
	NSString *			_stopLat;
	NSString *			_stopLng;
	NSString *			_copyright;
    NSString *          _streetcarBlock;
    bool                _nextBusFeedInTriMetData;
    NSString *          _nextBusRouteId;
}

// MKAnnotation
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
- (NSString*) title; 
- (NSString*) subtitle;
- (MKPinAnnotationColor) getPinColor;
- (Departure *)mapDeparture;


// Rest
- (NSString *)cellReuseIdentifier:(NSString *)identifier width:(ScreenType)width;
- (UITableViewCell *)tableviewCellWithReuseIdentifier:(NSString *)identifier big:(bool)big spaceToDecorate:(bool)spaceToDecorate width:(ScreenType)width;
- (void)populateCell:(UITableViewCell *)cell decorate:(BOOL)decorate big:(BOOL)big busName:(BOOL)busName wide:(BOOL)wide;
- (void)populateTripCell:(UITableViewCell *)cell item:(int)item;
- (void)populateCellGeneric:(UITableViewCell *)cell first:(NSString *)first second:(NSString *)second col1:(UIColor *)col1 col2:(UIColor *)col2;
-(id)init;
-(NSString *)formatDistance:(int)distance;
-(NSString *)formatLayoverTime:(TriMetTime)t;
-(TriMetTime)secondsToArrival;
-(int)minsToArrival;



@property (nonatomic, retain) NSString *locid;
@property (nonatomic, retain) NSString *block;
@property (nonatomic, retain) NSString *dir;
@property (nonatomic, retain) NSMutableArray *trips;
@property (nonatomic) bool hasBlock;
@property (nonatomic) TriMetTime queryTime;
@property (nonatomic) TriMetDistance blockPositionFeet;
@property (nonatomic) TriMetTime blockPositionAt;
@property (nonatomic, retain) NSString *blockPositionLat;
@property (nonatomic, retain) NSString *blockPositionLng;
@property (nonatomic, retain) NSString *errorMessage;
@property (nonatomic, retain) NSString *routeName;
@property (nonatomic, retain) NSString *route;
@property (nonatomic, retain) NSString *fullSign;
@property (nonatomic, retain) NSString *locationDesc;
@property (nonatomic, retain) NSString *locationDir;
@property (nonatomic) TriMetTime  departureTime;
@property (nonatomic) TriMetTime  scheduledTime;
@property (nonatomic) kStatus status;
@property (nonatomic) bool detour;
@property (nonatomic) bool streetcar;
@property (nonatomic) TriMetTime nextBus;
@property (nonatomic, retain) NSString *stopLat;
@property (nonatomic, retain) NSString *stopLng;
@property (nonatomic, retain) NSString *copyright;
@property (nonatomic, retain) NSDate *cacheTime;
@property (nonatomic, retain) NSString *streecarBlock;
@property (nonatomic, retain) NSString *nextBusRouteId;
@property (nonatomic) bool nextBusFeedInTriMetData;



@end
