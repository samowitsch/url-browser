//
//  ACHelpers.h
//  TextFieldSelectedRange
//
//  Created by Allan on 1/19/10.
//  Copyright 2010 AllanCraig. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ACHelpers : NSObject {

}
-(NSArray *)rangeOfTextFieldSelection:(NSTextField *)textField;
-(void)selectTextInTextfield:(NSTextField *)textField;
@end
