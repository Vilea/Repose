//
//  NSObject+JSON.m
//  Repose
//
//  Created by Junior Bontognali on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSObject+JSON.h"

@implementation NSObject (JSON)

- (id)initWithMappedDictionary:(NSDictionary *)d
{
    if (self = [[[self class] alloc] init]) {
        NSEnumerator *enumerator = [d keyEnumerator];
        NSString *key;
        while (key = [enumerator nextObject]) {
            if (![key isKindOfClass:[NSString class]])
                return nil;
            
            id obj = [d objectForKey:key];
            [self setValue:obj forKey:key];
        }
    }
    return self;
}

@end
