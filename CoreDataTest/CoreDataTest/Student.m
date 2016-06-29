//
//  Student.m
//  CoreDataTest
//
//  Created by DmitryMini on 6/29/16.
//  Copyright © 2016 offsiteteam. All rights reserved.
//

#import "Student.h"

@implementation Student

// Insert code here to add functionality to your managed object subclass
- (NSString *)description {
   return [NSString stringWithFormat:@"firstName = %@, lastName = %@, score = %@", self.firstName, self.lastName, self.score];
}

// Так переопределять сеттеры и геттеры:
- (void) setFirstName:(NSString *)firstName {
    [self willChangeValueForKey:@"firstName"];
    [self setPrimitiveValue:firstName forKey:@"firstName"];
    [self didChangeValueForKey:@"firstName"];
    NSLog(@"SET FIRST NAME!");
}

- (NSString*) firstName {
    NSString* string = nil;
    [self willAccessValueForKey:@"firstName"];
    string = [self primitiveValueForKey:@"firstName"];
    [self didAccessValueForKey:@"firstName"];
    NSLog(@"GET FIRST NAME");
    return string;
}

- (BOOL) validateLastName:(id  _Nullable __autoreleasing *)value error:(NSError * _Nullable __autoreleasing *)error {
    *error = [NSError errorWithDomain:@"BAD LAST NAME" code:1223 userInfo:nil];
    return NO;
}

@end
