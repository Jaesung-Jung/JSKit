//
//  ALAssetsGroup+Properties.h
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

@import AssetsLibrary.ALAssetsGroup;

@interface ALAssetsGroup (Properties)

/*!
 * Returns a string representation of an assets group name.
 *
 * @return A string representation of an assets group name
 */
@property (nonatomic, readonly) NSString *groupName NS_AVAILABLE_IOS(4_0);

/*!
 * Returns a number representation of an assets group type.
 *
 * @return A number representation of an assets group type
 */
@property (nonatomic, readonly) NSNumber *groupType NS_AVAILABLE_IOS(4_0);

/*!
 * Returns a string representation of an assets group UUID.
 *
 * @return A string representation of an assets group UUID
 */
@property (nonatomic, readonly) NSString *groupUUID NS_AVAILABLE_IOS(4_0);

/*!
 * Returns a url representation of an assets group url.
 *
 * @return A url representation of an assets group url
 */
@property (nonatomic, readonly) NSURL *groupURL NS_AVAILABLE_IOS(4_0);

@end
