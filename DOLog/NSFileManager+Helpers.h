//
//  NSFileManager+Helpers.h
//  


#import <Foundation/Foundation.h>

@interface NSFileManager (Helpers)

- (BOOL)createDirectoryIfNeeded:(NSString*)directoryPath;

@end
