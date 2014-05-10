//
//  UIControl+Event.h
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

@import UIKit.UIControl;

@interface UIControl (Event)

/*!
 * Add a event block for control events using receiver's block and control events.
 *
 * @params block The block to apply to event action.
 * @params controlEvents A bitmask specifying the control events for which the action message is sent.
 */
- (void)addEventBlock:(void (^)(id sender))block forControlEvents:(UIControlEvents)controlEvents NS_AVAILABLE_IOS(4_0);

/*!
 * Remove all event blocks for receiver's control events.
 *
 * @params controlEvents A bitmask specifying the control events for which the action message is sent.
 */
- (void)removeEventBlocksForControlEvents:(UIControlEvents)controlEvents NS_AVAILABLE_IOS(4_0);

/*!
 * Returns a boolean value that indicates whether the event blocks is registered for receiver's control events.
 *
 * @params controlEvents A bitmask specifying the control events for which the action message is sent.
 *
 * @return A boolean value that indicates whether the event blocks is registered for receiver's control events.
 */
- (BOOL)hasEventBlocksForControlEvents:(UIControlEvents)controlEvents NS_AVAILABLE_IOS(4_0);

@end
