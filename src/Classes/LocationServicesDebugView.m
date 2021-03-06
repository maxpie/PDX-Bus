//
//  LocationServicesDebugView.m
//  PDX Bus
//
//  Created by Andrew Wallace on 1/31/11.
//  Copyright 2011. All rights reserved.
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

#import "LocationServicesDebugView.h"
#include "CellLabel.h"

#ifdef DEBUG_ALARMS

@implementation LocationServicesDebugView

#define kSectionText	    	0
#define kSectionMap				1
#define kSections				2

#define kMapRows				2
#define kMapRowMap				0
#define kMapRowCancel			1

@synthesize data = _data;

- (void)dealloc {
	self.data = nil;
	[super dealloc];
}

#pragma mark Helper functions

- (UITableViewStyle) getStyle
{
	return UITableViewStyleGrouped;
}

#pragma mark Table view methods


- (id)init {
	if ((self = [super init]))
	{
		self.title = @"Location data";
	}
	return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return kSections;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	switch (section)
	{
		case kSectionMap: return kMapRows;
		case kSectionText:return self.data.internalDataItems;
	}
	return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	switch (indexPath.section)
	{
		case kSectionText:
		{
			static NSString *newId = @"about";
			CellLabel *cell = (CellLabel *)[tableView dequeueReusableCellWithIdentifier:newId];
			if (cell == nil) {
				cell = [[[CellLabel alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:newId] autorelease];
				cell.view = [self create_UITextView:nil font:[self getParagraphFont]];
			}
			
			cell.view.font =  [self getParagraphFont];
			cell.view.text = [self.data internalData:indexPath.row];
			// printf("width:  %f\n", cell.view.bounds.size.width);
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			[self updateAccessibility:cell indexPath:indexPath text:[self.data internalData:indexPath.row] alwaysSaySection:YES];
			// cell.backgroundView = [self clearView];
			return cell;
			break;
		}
		case kSectionMap:
		{
			static NSString *cellId = @"done";
			UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
			if (cell == nil) {
				
				cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId] autorelease];
				cell.textLabel.font =  [self getBasicFont]; //  [UIFont fontWithName:@"Ariel" size:14];
				cell.textLabel.adjustsFontSizeToFitWidth = YES;
				cell.textLabel.textAlignment = UITextAlignmentCenter;
			}
			
			switch (indexPath.row)
			{
				case kMapRowMap:	cell.textLabel.text = @"show on map"; break;
				case kMapRowCancel: cell.textLabel.text = @"cancel"		; break;	
			}
			return cell;
			break;
		}
	}
	return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == kSectionText)
	{
		return [self getTextHeight:[self.data internalData:indexPath.row] font:[self getParagraphFont]];
	}
	return [self basicRowHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	switch (indexPath.section)
	{
		case kSectionMap:
			switch (indexPath.row)
			{
				case kMapRowMap:
                    [self.data showMap:[self navigationController]];
					break;
				case kMapRowCancel:
					[self.data cancelTask];
					[[self navigationController] popViewControllerAnimated:YES];
					break;
			}
			break;
		case kSectionText:
			break;
	}
}

@end

#endif

