//
//  UIView+Snapshot.h
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

@import UIKit.UIView;

@interface UIView (Snapshot)

/*!
 * Returns a image object at the a snapshot of the complete view hierarchy as visible onscreen.
 *
 * @return A image object at the a snapshot of the complete view hierarchy as visible onscreen.
 */
- (UIImage *)snapshot NS_AVAILABLE_IOS(7_0);

/*!
 * Returns a image object at the a snapshot of the complete view hierarchy as visible onscreen using the given frame.
 *
 * @params frame A rectangle specified in the local coordinate system of the view.
 *
 * @return A image object at the a snapshot of the complete view hierarchy as visible onscreen.
 */
- (UIImage *)snapshotWithFrame:(CGRect)frame NS_AVAILABLE_IOS(7_0);

/*!
 * Returns a image object at the a snapshot of the complete view hierarchy as visible onscreen using the given scale.
 *
 * @params scale The scale factor to apply to the bitmap. If you specify a value of 0.0, the scale factor is set to the scale factor of the device’s main screen.
 *
 * @return A image object at the a snapshot of the complete view hierarchy as visible onscreen.
 */
- (UIImage *)snapshotWithScale:(CGFloat)scale NS_AVAILABLE_IOS(7_0);

/*!
 * Returns a image object at the a snapshot of the complete view hierarchy as visible onscreen using the given frame and scale.
 *
 * @params frame A rectangle specified in the local coordinate system of the view.
 * @params scale The scale factor to apply to the bitmap. If you specify a value of 0.0, the scale factor is set to the scale factor of the device’s main screen.
 *
 * @return A image object at the a snapshot of the complete view hierarchy as visible onscreen.
 */
- (UIImage *)snapshotWithFrame:(CGRect)frame scale:(CGFloat)scale NS_AVAILABLE_IOS(7_0);

/*!
 * Returns a image object at the a snapshot of the complete view hierarchy as visible onscreen using the given frame and scale.
 *
 * @params frame A rectangle specified in the local coordinate system of the view.
 * @params snapshotSize Size for snapshot.
 *
 * @return A image object at the a snapshot of the complete view hierarchy as visible onscreen.
 */
- (UIImage *)snapshotWithFrame:(CGRect)frame snapshotSize:(CGSize)snapshotSize NS_AVAILABLE_IOS(7_0);

/*!
 * Returns a image object at the a snapshot of the complete view hierarchy as visible onscreen using the given frame and scale.
 *
 * @params frame A rectangle specified in the local coordinate system of the view.
 * @params snapshotSize Size for snapshot.
 * @params scale The scale factor to apply to the bitmap. If you specify a value of 0.0, the scale factor is set to the scale factor of the device’s main screen.
 *
 * @return A image object at the a snapshot of the complete view hierarchy as visible onscreen.
 */
- (UIImage *)snapshotWithFrame:(CGRect)frame snapshotSize:(CGSize)snapshotSize scale:(CGFloat)scale NS_AVAILABLE_IOS(7_0);

@end
