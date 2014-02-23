//
//  UIControl+Event.m
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

#import "UIControl+Event.h"
#import "NSObject+Associated.h"

static void *kControlBlocks;

#pragma mark - Private Class
@interface JSEventHandler : NSObject <NSCopying>

- (instancetype)initWithBlock:(void (^)(id sender))block forControlEvents:(UIControlEvents)controlEvents;

@property (nonatomic, copy) void (^actionBlock)(id sender);
@property (nonatomic) UIControlEvents controlEvents;

@end

@implementation JSEventHandler

- (instancetype)initWithBlock:(void (^)(id sender))block forControlEvents:(UIControlEvents)controlEvents {
    if ((self = [super init])) {
        self.actionBlock = block;
        self.controlEvents = controlEvents;
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    return [[JSEventHandler alloc] initWithBlock:self.actionBlock forControlEvents:self.controlEvents];
}

- (void)invoke:(id)sender {
    self.actionBlock(sender);
}

@end

#pragma mark - Implementation
@implementation UIControl (Event)

- (void)addEventBlock:(void (^)(id))block forControlEvents:(UIControlEvents)controlEvents {
    NSMutableDictionary *events = [self associatedValueForKey:&kControlBlocks];
    if (!events) {
        events = [NSMutableDictionary dictionary];
        [self associateValue:events withKey:&kControlBlocks];
    }
    
    NSNumber *key = @(controlEvents);
    NSMutableSet *handlers = events[key];
    if (!handlers) {
        handlers = [NSMutableSet set];
        events[key] = handlers;
    }
    
    JSEventHandler *target = [[JSEventHandler alloc] initWithBlock:block forControlEvents:controlEvents];
    [handlers addObject:target];
    [self addTarget:target action:@selector(invoke:) forControlEvents:controlEvents];
}

- (void)removeEventBlocksForControlEvents:(UIControlEvents)controlEvents {
    NSMutableDictionary *events = [self associatedValueForKey:&kControlBlocks];
    if (!events) {
        events = [NSMutableDictionary dictionary];
        [self associateValue:events withKey:&kControlBlocks];
    }
    
    NSNumber *key = @(controlEvents);
    NSSet *handlers = events[key];
    
    if (!handlers)
        return;
    
    [handlers enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        [self removeTarget:obj action:NULL forControlEvents:controlEvents];
    }];
    
    [events removeObjectForKey:key];
}

- (BOOL)hasEventBlocksForControlEvents:(UIControlEvents)controlEvents {
    NSMutableDictionary *events = [self associatedValueForKey:&kControlBlocks];
    if (!events) {
        events = [NSMutableDictionary dictionary];
        [self associateValue:events withKey:&kControlBlocks];
    }
    
    NSNumber *key = @(controlEvents);
    NSSet *handlers = events[key];
    
    if (!handlers)
        return NO;
    
    return handlers.count;
}

@end
