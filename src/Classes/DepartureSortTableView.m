//
//  DepartureSortTableView.m
//  PDX Bus
//
//  Created by Andrew Wallace on 10/17/09.
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

#import "DepartureSortTableView.h"
#import "CellLabel.h"
#import "DepartureTimesView.h"

@implementation DepartureSortTableView

#define kSections 2

#define kSectionInfo 0
#define kSectionSeg  1


#define kSegRowWidth		320
#define kSegRowHeight		40
#define kUISegHeight		40
#define kUISegWidth			320

@synthesize sortSegment = _sortSegment;
@synthesize info		= _info;
@synthesize depView		= _depView;

- (void)dealloc {
	self.depView		= nil;
	self.sortSegment	= nil;
	self.info			= nil;
    [super dealloc];
}


- (id) init
{
	if ((self = [super init]))
	{
		self.title = @"Group Arrivals";
		self.info = @"Group by stop: shows arrivals for each stop.\n\n"
					 "Group by trip: follows a particular bus or train as it passes through each stop.\n\n"
					 "Tip: 'Group by trip' is only useful with bookmarks containing several close stops on "
					 "the same route.";
	}
	return self;
}

#pragma mark Helper functions

- (void)sortSegmentChanged:(id)sender
{
	switch (self.sortSegment.selectedSegmentIndex)
	{
		case 0:
			self.depView.blockSort = FALSE;
			break;
		case 1:
			self.depView.blockSort = TRUE;
			break;
	}
	
	if (!segSetup)
	{
		[self.depView resort];
		[[self navigationController] popViewControllerAnimated:YES];
	}
}

- (UISegmentedControl*) createSegmentedControl:(NSArray *)segmentTextContent parent:(UIView *)parent action:(SEL)action
{
	UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentTextContent];
	CGRect frame = CGRectMake((kSegRowWidth-kUISegWidth)/2, (kSegRowHeight - kUISegHeight)/2 , kUISegWidth, kUISegHeight);
	
	segmentedControl.frame = frame;
	[segmentedControl addTarget:self action:action forControlEvents:UIControlEventValueChanged];
	segmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;
	segmentedControl.autoresizingMask =   UIViewAutoresizingFlexibleWidth;
	
	[parent addSubview:segmentedControl];
	[parent layoutSubviews];
	[segmentedControl autorelease];
	return segmentedControl;
}

#pragma mark View methods

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	switch (indexPath.section)
	{
		case kSectionSeg:
		{
			static NSString *segmentId = @"segment";
			UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:segmentId];
			if (cell == nil) {
				cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:segmentId] autorelease];
				self.sortSegment = [self createSegmentedControl:
								   [NSArray arrayWithObjects: @"Group by stop", @"Group by trip", nil] 
														parent:cell.contentView action:@selector(sortSegmentChanged:)];
				
				[cell layoutSubviews];
				cell.selectionStyle = UITableViewCellSelectionStyleNone;
				cell.isAccessibilityElement = NO;
				cell.backgroundView = [self clearView];
			}
			
			segSetup = YES;
			self.sortSegment.selectedSegmentIndex = self.depView.blockSort ? 1 : 0;
			segSetup = NO;
			return cell;
		}
		break;
		case kSectionInfo:
		{
			static NSString *infoId = @"info";
			CellLabel *cell = (CellLabel *)[tableView dequeueReusableCellWithIdentifier:infoId];
			if (cell == nil) {
				cell = [[[CellLabel alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infoId] autorelease];
				cell.view = [self create_UITextView:[UIColor clearColor] font:TableViewBackFont];
			}
			
			[self setBackfont:cell.view];
			cell.view.text = self.info;
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			cell.backgroundView = [self clearView];
			
			return cell;
		}
		break;
	}
	return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == kSectionInfo)
	{
		return [self getTextHeight:self.info font:TableViewBackFont];
	}
	return kSegRowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
}

#pragma mark TableViewWithToolbar methods

- (UITableViewStyle) getStyle
{
	return UITableViewStyleGrouped;
}


@end

