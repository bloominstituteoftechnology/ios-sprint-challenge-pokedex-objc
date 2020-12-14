# Manual Reference Counting

Answer the following questions inline with this document.

1. Are there memory leaks with this code? Yes.  (If so, where are the leaks?)

	```swift
	NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

	NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain];  // LEAK 1

	NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
	NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

	NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init]; // LEAK 2

	for (NSString *word in words) {
		NSNumber *count = wordFrequency[word];
		if (count) {
			wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
		} else {
			wordFrequency[word] = [[NSNumber alloc] initWithInteger:1];  // LEAK 3
		}
	}

	printf("Word frequency: %s", wordFrequency.description.UTF8String);
	```

	2. Rewrite the code so that it does not leak any memory with ARC disabled

#1      NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] ; 

#2     NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
         NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];  
         NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[[NSMutableDictionary alloc] init] autorelease];
         
#3     for (NSString *word in words) {
         NSNumber *count = wordFrequency[word];
            if (count) {
                wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
                } else {
                wordFrequency[word] = [[NSNumber] initWithInteger:1]; 
                
                }
2. Which of these objects is autoreleased?  Why?

	1. `NSDate *yesterday = [NSDate date];`
            Autoreleased, no memory alloc
	2. `NSDate *theFuture = [[NSDate dateWithTimeIntervalSinceNow:60] retain];`
            Not autoreleased due to retain
	3. `NSString *name = [[NSString alloc] initWithString:@"John Sundell"];`
            Not autorelesaed due to alloc
	4. `NSDate *food = [NSDate new];`
            Not autoreleased due to new
	5. `LSIPerson *john = [[LSIPerson alloc] initWithName:name];`
            Not autoreleased duer to alloc
	6. `LSIPerson *max = [[[LSIPerson alloc] initWithName:@"Max"] autorelease];`
            Autorelased due to autorelease at end
3. Explain when you need to use the `NSAutoreleasePool`.
      When iterating through large data sets each property gets assigned memory and it will continue to take up memory unless autorelease pool is employed which will release the objects as required. 

4. Implement a convenience `class` method to create a `LSIPerson` object that takes a `name` property and returns an autoreleased object.


@interface LSIPerson: NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;
+ (instancetype)initPersonWithName: (NSString *)aName;

@end

@implementation LSIPerson

+(instancetype)initPersonWithName: (NSString *)aName
{
LSIPerson *person = [[self alloc] initPersonWithName: name];
return [person autorelease]
}
```
