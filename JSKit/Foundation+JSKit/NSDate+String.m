//
//  NSDate+String.m
//
//  Copyright (c) 2014 Jaesung Jung
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

@import Foundation.NSDateFormatter;
@import Foundation.NSLocale;

#import "NSDate+String.h"

@implementation NSDate (String)

- (NSString *)stringValue
{
    return [self stringValueWithDateStyle:NSDateFormatterFullStyle timeStyle:NSDateFormatterFullStyle];
}

- (NSString *)stringValueWithFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:self];
}

- (NSString *)stringValueWithLocale:(NSLocale *)locale
{
    return [self stringValueWithDateStyle:NSDateFormatterFullStyle timeStyle:NSDateFormatterFullStyle locale:locale];
}

- (NSString *)stringValueWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle
{
    return [self stringValueWithDateStyle:dateStyle timeStyle:timeStyle locale:[NSLocale currentLocale]];
}

- (NSString *)stringValueWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle locale:(NSLocale *)locale
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:dateStyle];
    [dateFormatter setTimeStyle:timeStyle];
    [dateFormatter setLocale:locale];
    return [dateFormatter stringFromDate:self];
}

@end
