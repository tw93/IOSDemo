//
//  JSExportText.m
//  JSCoreDemo
//
//  Created by 侑夕 on 2018/3/13.
//  Copyright © 2018年 侑夕. All rights reserved.
//

#import "Person.h"

@implementation Person
@synthesize firstName, lastName;
- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}
@end
