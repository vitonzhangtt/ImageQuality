//
//  NSFileManager+Helpers.m
//  
//
//  Created by Adam Kull on 18/05/15.
//  Copyright (c) 2015 P1. All rights reserved.
//

#import "NSFileManager+Helpers.h"

@implementation NSFileManager (Helpers)

- (BOOL)createDirectoryIfNeeded:(NSString *)directoryPath {
    if (!directoryPath.length) { return NO; }
    NSError *error = nil;
    if (![self fileExistsAtPath:directoryPath]) {
        [self createDirectoryAtPath:directoryPath withIntermediateDirectories:NO attributes:nil error:&error];
        if (error) {
            return NO;
        }
    }
    return YES;
}

@end
