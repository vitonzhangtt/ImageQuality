//
//  NSFileManager+Helpers.m
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
