//
//  ACHelpers.m
//  TextFieldSelectedRange
//
//  Created by Allan on 1/19/10.
//  Copyright 2010 AllanCraig. All rights reserved.
//

#import "ACHelpers.h"

#define NumObj(int) [NSNumber numberWithInt:int]

@implementation ACHelpers

-(NSArray *)rangeOfTextFieldSelection:(NSTextField *)textField
{
	NSText *textEditor = [textField currentEditor];
	NSRange selRange = [textEditor selectedRange];
	NSArray *range = [NSArray arrayWithObjects:
					  NumObj(selRange.location),
					  NumObj(selRange.length),
					  nil];
	return range;
}


-(void)selectTextInTextfield:(NSTextField *)textField
{
	[textField selectText:self];
	[[textField currentEditor] setSelectedRange:NSMakeRange(24, 8)];
}

@end
