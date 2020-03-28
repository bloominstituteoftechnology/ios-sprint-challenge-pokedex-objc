#  Manual Reference Counting Questions

1. Are there memory leaks with this code? (If so, where are the leaks?)

NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

* right here you don't need to call retain or need to release if you do call retain (function of NSCharacterSet)
NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain];

NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

* alloc init here on this dictionary, add auto release
NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init];

for (NSString *word in words) {
NSNumber *count = wordFrequency[word];
if (count) {
wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
} else {

* alloc init called here +1 retian count
wordFrequency[word] = [[NSNumber alloc] initWithInteger:1];
}
}

printf("Word frequency: %s", wordFrequency.description.UTF8String);

1. Part 2
Rewrite the code so that it does not leak any memory with ARC disabled

NSCharacterSet *punctuationSet = [NSCharacterSet punctuationCharacterSet];

NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[[NSMutableDictionary alloc] init] autorelease];

for (NSString *word in words) {
NSNumber *count = wordFrequency[word];
if (count != nil) {
wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
} else {
wordFrequency[word] = [[[NSNumber alloc] initWithInteger:1] autorelease];
}
}
printf("Word frequency: %s", wordFrequency.description.UTF8String);

2. Which of these objects is autoreleased? Why?

* is autoreleased because its a method on NSDate
NSDate *yesterday = [NSDate date];

* not autoreleased because calling retain on it
NSDate *theFuture = [[NSDate dateWithTimeIntervalSinceNow:60] retain];

* not auto released because alloc init used
NSString *name = [[NSString alloc] initWithString:@"John Sundell"];

* not auto released because new is used
NSDate *food = [NSDate new];

* not auto released because alloc init used
LSIPerson *john = [[LSIPerson alloc] initWithName:name];

* autoreleased because calling autorelease on it
LSIPerson *max = [[[LSIPerson alloc] initWithName:@"Max"] autorelease];

3. Explain when you need to use the NSAutoreleasePool.

* if you were iterating over an array of a large amount of data and would reach the memory cap where the app would crash before finishing the the iteration, this is where you would want to use your own autorelease pool.

4. Implement a convenience class method to create a LSIPerson object that takes a name property and returns an autoreleased object.

@interface LSIPerson: NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;

+ (instancetype)personWithName:(NSString *)name;

@end

#import "LSIPerson.h"

@implementation LSIPerson

+ (instancetype)personWithName:(NSString *)name {

return [[[LSIPerson alloc] initWithName:name] autorelease];

}

@end
