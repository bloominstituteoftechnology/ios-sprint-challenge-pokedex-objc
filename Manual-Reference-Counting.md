# Manual Reference Counting

Answer the following questions inline with this document.

1. Are there memory leaks with this code? How would you fix them?

Yes because `punctuationSet` is never released. I added that at the end.

```objectivec
NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs"; // I used to have this quote on my wall at my previous job. One of the reasons I finally made the choice to quit and start Lambda.
	
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
[punctuationSet release]
```







2. Which of these objects is autoreleased?  Why?

	1. `NSDate *yesterday = [NSDate date];` This is autoreleased because because NSDate is taking care of it for you.
	
	2. `NSDate *theFuture = [[NSDate dateWithTimeIntervalSinceNow:60] retain];` Not autoreleased because there is a manual retain.
	
	3. `NSString *name = [[NSString alloc] initWithString:@"John Sundell"];` Not autoreleased because it is being initialized here.
	
	4. `NSDate *food = [NSDate new];` This is autoreleased NSDate is taking care of it for you.
	
	5. `LSIPerson *john = [[LSIPerson alloc] initWithName:name];` This is not autoreleased because of the init.
	
	6. `LSIPerson *max = [[[LSIPerson alloc] initWithName:@"Max"] autorelease];` This is being autoreleased because it specifically being told to autorelease at the end of the init.

3. Explain when you need to use the `NSAutoreleasePool`.

	When there is a huge amount of data, this is going to autorelease for you to make room for the rest of the data. It's going to do this through a loop.


4. Implement a convenience `class` method to create a `LSIPerson` object that takes a `name` property and returns an autoreleased object.

```objectivec
@interface LSIPerson: NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName;
+ (LSIPerson)PersonWithNameOf(NSString *)name;

+ (LSIPerson)PersonWithNameOf(NSString *)name {
	return [[[LSIPerson alloc] initWithName:name] autorelease];
}

@end
```
