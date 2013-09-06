//
//  UIControl+SCBlocks.m
//  JSCalc
//
//  Created by Chani Armitage on 2013-09-05.
//  Copyright (c) 2013 Nigel Brooke. All rights reserved.
//

#import "UIControl+SCBlocks.h"
#import <objc/runtime.h>

@implementation UIControl (SCBlocks)

static const char * BlockKey = "SCBlocks";

- (void) addEventHandler:(JSValue*)handler forControlEvents:(UIControlEvents)controlEvents {
    objc_setAssociatedObject(self, &BlockKey, handler, OBJC_ASSOCIATION_RETAIN);
    [self addTarget:self action:@selector(handleControlEvent) forControlEvents:controlEvents];
}

- (void) addClickHandler:(JSValue*)handler {
    [self addEventHandler:handler forControlEvents:UIControlEventTouchUpInside];
}

-(void) handleControlEvent {
    JSValue* handler;
    handler = objc_getAssociatedObject(self, &BlockKey);
    if (handler) {
        [handler callWithArguments:@[]];
    }
}

@end
