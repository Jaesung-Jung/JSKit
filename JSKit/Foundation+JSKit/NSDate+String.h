//
//  NSDate+String.h
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

@import Foundation.NSDate;
@import Foundation.NSDateFormatter;

@interface NSDate (String)

/*!
 * Returns a string representation of a given date formatted using the default format.
 *
 * @return A string representation of a given date formatted using the default format.
 */
- (NSString *)stringValue NS_AVAILABLE_IOS(2_0);

/*!
 * Returns a string representation of a given date formatted using the receiver's format.
 * @see https://developer.apple.com/library/iOS/documentation/Cocoa/Conceptual/DataFormatting
 *
 * @params format The date format for the receiver. See Data Formatting Guide for a list of the conversion specifiers permitted in date format strings.
 *
 * @return A string representation of a given date formatted using the receiver's format.
 */
- (NSString *)stringValueWithFormat:(NSString *)format NS_AVAILABLE_IOS(2_0);

/*!
 * Returns a string representation of a given date formatted using the receiver's locale.
 *
 * @params locale The locale for the receiver.
 *
 * @return A string representation of a given date formatted using the receiver's locale.
 */
- (NSString *)stringValueWithLocale:(NSLocale *)locale NS_AVAILABLE_IOS(2_0);

/*!
 * Returns a string representation of a given date formatted using the receiver's style and time style.
 *
 * @params dateStyle The date style of the receiver. For possible values, see NSDateFormatterStyle.
 * @params timeStyle The time style of the receiver. For possible values, see NSDateFormatterStyle.
 *
 * @return A string representation of a given date formatted using the receiver's style and time style.
 */
- (NSString *)stringValueWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle NS_AVAILABLE_IOS(2_0);

/*!
 * Returns a string representation of a given date formatted using the receiver's style, time style and locale.
 *
 * @params dateStyle The date style of the receiver. For possible values, see NSDateFormatterStyle.
 * @params timeStyle The time style of the receiver. For possible values, see NSDateFormatterStyle.
 * @params locale The locale for the receiver.
 *
 * @return A string representation of a given date formatted using the receiver's style, time style and locale.
 */
- (NSString *)stringValueWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle locale:(NSLocale *)locale NS_AVAILABLE_IOS(2_0);

@end
