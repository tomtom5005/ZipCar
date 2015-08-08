//
//  ZipCarTests.m
//  ZipCarTests
//
//  Created by Thomas Thompson on 7/28/15.
//  Copyright (c) 2015 Thomas Thompson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "RomanNumeral.h"

@interface ZipCarTests : XCTestCase
{
    NSArray *validStrings;
    NSArray *invalidStrings;
    NSArray *validValues;
    NSString *emptyString;
}
@end

@implementation ZipCarTests

- (void)setUp {
    [super setUp];
    validStrings = @[@"MMMM", @"mmcdlxxiv", @"CCC", @"XXX", @"III", @"CM", @"CD", @"DCCC", @"DCC", @"DC", @"XC", @"XL", @"LX", @"LXX", @"LXXX", @"XV", @"XIV", @"XVI", @"XVII", @"XVIII", @"IX", @"XI", @"XII", @"XIII", @"VI"];
    validValues = @[@4000, @2474, @300, @30, @3, @900, @400, @800, @700, @600, @90, @40, @60, @70, @80, @15, @14, @16, @17, @18, @9, @11, @12, @13, @6];
    
    invalidStrings = @[@"KJH", @"CCCC", @"XXXX", @"IIII", @"CMM", @"CCM", @"CCD", @"DD", @"XCC", @"XXC", @"XLL", @"XXL", @"IIV", @"VVI"];
    emptyString = @"";
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testValidRomanNumeral {
    for (NSString *str in validStrings) {
        RomanNumeral *numeral = [[RomanNumeral alloc] initWithString:str];
        NSString *errorMsg = [NSString stringWithFormat:@"%@ is a valid roman numeral but the method validRomanNumeral: is returning NO.",str];
        XCTAssert([numeral validRomanNumeral], @"Failed.  %@",errorMsg);
    }
}

- (void)testInvalidRomanNumeral {
    for (NSString *str in invalidStrings) {
        RomanNumeral *numeral = [[RomanNumeral alloc] initWithString:str];
        NSString *errorMsg = [NSString stringWithFormat:@"%@ is a invalid roman numeral but the method validRomanNumeral: is returning YES.",str];
        XCTAssertFalse([numeral validRomanNumeral], @"Failed.  %@",errorMsg);
    }
}

- (void)testNumericValueForInvalidNumerals {
    for (NSString *str in invalidStrings) {
        RomanNumeral *numeral = [[RomanNumeral alloc] initWithString:str];
        NSString *errorMsg = [NSString stringWithFormat:@"%@ is a invalid roman numeral and it's numericValue should be %ld but it's numericValue property is %ld.",str,(long)ZCInvalidRomanNumeral, (long)numeral.numericValue];
        XCTAssertEqual(numeral.numericValue,ZCInvalidRomanNumeral,@"Failed.  %@",errorMsg);
    }
}


- (void)testNumericValueForValidNumerals {
    NSInteger i = 0;
    for (NSString *str in validStrings) {
        RomanNumeral *numeral = [[RomanNumeral alloc] initWithString:[str uppercaseString]];
        NSInteger value = [validValues[i] integerValue];
        NSString *errorMsg = [NSString stringWithFormat:@"%@ is a valid roman numeral and it's numericValue should be %ld but it's numericValue property is %ld.",numeral, (long)value, (long)numeral.numericValue];
        XCTAssertEqual(numeral.numericValue, value, @"Failed.  %@",errorMsg);
        i++;
    }
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
