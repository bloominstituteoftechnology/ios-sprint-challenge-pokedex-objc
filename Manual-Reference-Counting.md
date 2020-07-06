Manual Reference Counting
Answer the following questions inline with this document.

Are there memory leaks with this code? (If so, where are the leaks?)
NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";
NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain];
NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];
NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init];
for (NSString *word in words) {
	NSNumber *count = wordFrequency[word];
	if (count) {
		wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
	} else {
		wordFrequency[word] = [[NSNumber alloc] initWithInteger:1];
	}
}
printf("Word frequency: %s", wordFrequency.description.UTF8String);
There is a leak on punctuationSet since it is retained but never released.
There is a leak on wordFrequency since it is allocated and initiated but never released.
There is a leak on [[NSNumber alloc] initWithInteger:1] since it is allocated and initiated but never released.
Rewrite the code so that it does not leak any memory with ARC disabled
     NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";
     NSCharacterSet *punctuationSet = [NSCharacterSet punctuationCharacterSet];

     NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
     NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

     NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[[NSMutableDictionary alloc] init] autorelease];

     for (NSString *word in words) {
         @autoreleasepool {
             NSNumber *count = wordFrequency[word];
             if (count) {
                 wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
             } else {
                 wordFrequency[word] = [[[NSNumber alloc] initWithInteger:1] autorelease];
             }
         }
     }

     printf("Word frequency: %s", wordFrequency.description.UTF8String);
Which of these objects is autoreleased? Why?
NSDate *yesterday = [NSDate date];
NSDate *theFuture = [[NSDate dateWithTimeIntervalSinceNow:60] retain];
NSString *name = [[NSString alloc] initWithString:@"John Sundell"];
NSDate *food = [NSDate new];
LSIPerson *john = [[LSIPerson alloc] initWithName:name];
LSIPerson *max = [[[LSIPerson alloc] initWithName:@"Max"] autorelease];
1 is because it's using a convenience initializer starting with "date". 2 is not because it's being retained. 3 is not because it's using an alloc init. 4 is not because it's using the "new" initializer. 5 is not because it's using an alloc init. 6 is because autorelease is added to it.
Explain when you need to use the NSAutoreleasePool.
When data can get large, such as when initializing data inside of a loop, you would want to put your autoreleasing data into an autorelease pool so it will release early before the data builds up too much.
Implement a convenience class method to create a LSIPerson object that takes a name property and returns an autoreleased object.
@interface LSIPerson: NSObject
@property (nonatomic, copy) NSString *name;
- (instancetype)initWithName:(NSString *)name;
+ (instancetype)personNamed:(NSString *)name;
@end
In the implementation part of the .m file:
+ (instancetype)personNamed:(NSString *)name {
	return [[[LSIPerson alloc] initWithName:name] autorelease];
}
