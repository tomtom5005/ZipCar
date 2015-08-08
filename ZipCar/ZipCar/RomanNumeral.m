//
//  RomanNumeral.m
//  ZipCar
//
//  Created by Thomas Thompson on 7/28/15.
//  Copyright (c) 2015 Thomas Thompson. All rights reserved.
//

#import "RomanNumeral.h"

NSInteger const ZCInvalidRomanNumeral = NSIntegerMax;
static NSString *const regexString = @"^(?=[MDCLXVI])M*(C[MD]|D?C{0,3})(X[CL]|L?X{0,3})(I[XV]|V?I{0,3})$";
@interface RomanNumeral()

@property (nonatomic, strong) NSDictionary *numeralsToIntegers;

@end

@implementation RomanNumeral

- (instancetype) initWithString:(NSString *)str{
    if(self = [super init]){
        _string = str;
    }
    return self;
}

- (BOOL)validRomanNumeral{
        NSError *error;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString options:NSRegularExpressionCaseInsensitive error:&error];
        NSUInteger numberOfMatches = [regex numberOfMatchesInString:self.string options:0 range:NSMakeRange(0,[self.string length])];
        return numberOfMatches ? YES : NO;
}

- (NSDictionary *)numeralsToIntegers{
    return @{@1000 : @"M", @900 : @"CM", @500 : @"D", @400 : @"CD", @100 : @"C", @90 : @"XC", @50 : @"L", @40 : @"XL", @10 :  @"X", @9 : @"IX", @5 : @"V", @4 : @"IV", @1 : @"I"};
}

- (NSInteger)numericValue{
    NSInteger loc = 0;
    NSInteger len;
    NSInteger total = 0;
    if([self validRomanNumeral]){
        NSArray *keys = [self sortedKeys];
        for (NSNumber *number in keys){
            NSString *numeral = self.numeralsToIntegers[number];
            len = [numeral length];
            if( (loc + len) <= [self.string length]){
                NSRange range = NSMakeRange(loc, len);
                RomanNumeral *numeralFragment;
                while( ((loc + len) <= [self.string length]) && [[self.string substringWithRange:range] isEqualToString:numeral]){
                    numeralFragment = [[RomanNumeral alloc] initWithString:[self.string substringWithRange:range]];
                    total += [number integerValue];
                    loc += len;
                    range = NSMakeRange(loc, len);
                }
            }
        }
    }
    else{
        total = [self length] ? ZCInvalidRomanNumeral : 0;
    }
    return total;
}

-(NSUInteger)length{
    return [self.string length];
}

- (NSArray *)sortedKeys{
    NSArray *keys = [[self.numeralsToIntegers allKeys] sortedArrayUsingComparator:^NSComparisonResult(NSNumber *num1, NSNumber *num2) {
        switch ([num1 compare:num2]) {
            case NSOrderedAscending:
                return NSOrderedDescending;
                break;
                
            case NSOrderedSame:
                return NSOrderedSame;
                break;
                
            case NSOrderedDescending:
                return NSOrderedAscending;
                break;
                
            default:
                break;
        }
    }];
    return keys;
}

- (BOOL) isBase10{
    return [@[@"M", @"C", @"X", @"I"] containsObject:self.string];
}

- (NSString *)description{
    return [NSString stringWithFormat:@"%@ %@", [super description], self.string];
}

@end
