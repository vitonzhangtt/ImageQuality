//
//  NSFileManager+Helpers.h
//  putong
//
//  Created by Adam Kull on 18/05/15.
//  Copyright (c) 2015 P1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (Helpers)

- (BOOL)createDirectoryIfNeeded:(NSString*)directoryPath;

@end
