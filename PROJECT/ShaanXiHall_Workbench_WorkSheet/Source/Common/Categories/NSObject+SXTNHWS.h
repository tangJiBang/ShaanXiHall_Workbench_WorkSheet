//
//  NSObject+SXTNHWS.h
//  ShaanxiTransmissionNetworkHiddenWorkSheet
//
//  Created by tangji on 2019/8/1.
//  Copyright © 2019 Boco. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (SXTNHWS)

@property(nonatomic, strong) id<NSCopying> eKey;
@property(nonatomic, strong) id eValue;

- (id)initWithKey:(id<NSCopying>)key value:(id)value;

@end

@interface NSArray (HABEnumerate)

- (NSArray *)enumerateAllKeys;

- (NSArray *)enumerateAllValues;

- (id)enumerateValueForKey:(id<NSCopying>)key;

- (id<NSCopying>)enumerateKeyForValue:(id)value;

- (NSArray *)enumerateObjectsWithOut:(NSArray *)withoutKey;

- (NSArray *)enumerateObjectsWith:(NSArray *)keys;

@end


NS_ASSUME_NONNULL_END
