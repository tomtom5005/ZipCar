//
//  RomanNumeral.h
//  ZipCar
//
//  Created by Thomas Thompson on 7/28/15.
//  Copyright (c) 2015 Thomas Thompson. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSInteger const ZCInvalidRomanNumeral;

@interface RomanNumeral : NSObject

@property (readonly) NSInteger numericValue;
@property (nonatomic, strong) NSString *string;

- (instancetype) initWithString:(NSString *)str;
- (NSUInteger)length;
- (BOOL)validRomanNumeral;

@end
