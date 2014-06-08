//
//  NSObject+Associated.h
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

@import Foundation.NSObject;

@interface NSObject (Associated)

/*!
 * Sets an associated value (retain, nonatomic) for a given object using a given key.
 *
 * @params value The value to associate with the key key for object. Pass nil to clear an existing association.
 * @params key The key for the association.
 */
- (void)associateValue:(id)value withKey:(const void *)key NS_AVAILABLE_IOS(3_1);

/*!
 * Sets an associated value (retain, atomic) for a given object using a given key.
 */
- (void)atomicallyAssociateValue:(id)value withKey:(const void *)key NS_AVAILABLE_IOS(3_1);

/*!
 * Sets an associated value (copy, nonatomic) for a given object using a given key.
 *
 * @params value The value to associate with the key key for object. Pass nil to clear an existing association.
 * @params key The key for the association.
 */
- (void)associateCopyOfValue:(id)value withKey:(const void *)key NS_AVAILABLE_IOS(3_1);

/*!
 * Sets an associated value (copy, atomic) for a given object using a given key.
 *
 * @params value The value to associate with the key key for object. Pass nil to clear an existing association.
 * @params key The key for the association.
 */
- (void)atomicallyAssociateCopyOfValue:(id)value withKey:(const void *)key NS_AVAILABLE_IOS(3_1);

/*!
 * Sets an associated value (assign) for a given object using a given key.
 *
 * @params value The value to associate with the key key for object. Pass nil to clear an existing association.
 * @params key The key for the association.
 */
- (void)weaklyAssociateValue:(id)value withKey:(const void *)key NS_AVAILABLE_IOS(3_1);

/*!
 * Returns the value associated with a given object for a given key.
 *
 * @params key The key for the association.
 *
 * @return A value associated with a given object for a given key.
 */
- (id)associatedValueForKey:(const void *)key NS_AVAILABLE_IOS(3_1);

/*!
 * Removes all associations for a given object.
 */
- (void)removeAllAssociatedObjects NS_AVAILABLE_IOS(3_1);

@end
