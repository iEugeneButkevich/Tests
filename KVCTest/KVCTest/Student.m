//
//  Student.m
//  KVCTest
//
//  Created by DmitryMini on 6/28/16.
//  Copyright © 2016 offsiteteam. All rights reserved.
//

#import "Student.h"

@implementation Student

- (void) setName:(NSString *)name {
    NSLog(@"Student setName %@", name);
    _name = name;
}

- (void) setAge:(NSInteger)age {
    NSLog(@"Student setAge %ld", (long)age);
    _age = age;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Student: %@ %ld", self.name, (long)self.age];
}

- (void)setValue:(id)value forKey:(NSString *)key {
    NSLog(@"Student setValue:%@ forKey: %@", value, key);
    [super setValue:value forKey:key];
}

- (void) setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"setValueForUndefinedKey");
}

- (id) valueForUndefinedKey:(NSString *)key {
    NSLog(@"valueForUndefinedKey");
    return nil;
}

- (void) changeName {
    //1
//    _name = @"FakeName";    // В данном случае Observer не узнает, что изменено значение поля name", сеттер не вызывается.
    
    //2
    [self willChangeValueForKey:@"name"];   // В данном случае Observer узнает об изменении поля "name", сеттер не вызывается
    _name = @"FakeName";
    [self didChangeValueForKey:@"name"];
}

// В этом методе происходит валидация всех полей объекта
/*- (BOOL) validateValue:(inout id  _Nullable __autoreleasing *)ioValue forKey:(NSString *)inKey error:(out NSError * _Nullable __autoreleasing *)outError {
    BOOL result;
    if ([inKey isEqualToString:@"name"]) {
        NSString* newName = *ioValue;
        if (![newName isKindOfClass:[NSString class]]) {
            *outError = [[NSError alloc] initWithDomain:@"Not NSString :(" code:123 userInfo:nil];
            return NO;
        }
        if ([newName rangeOfString:@"1"].location != NSNotFound) {
            *outError = [[NSError alloc] initWithDomain:@"Has numbers :(" code:324 userInfo:nil];
            return NO;
        }
    }
    return result;
} */

// Можно делать валидацию каждого поля в отдельном методе:
- (BOOL) validateName:(inout id  _Nullable __autoreleasing *)ioValue error:(out NSError * _Nullable __autoreleasing *)outError{
    NSLog(@"validateName");
    return YES;
}

@end
