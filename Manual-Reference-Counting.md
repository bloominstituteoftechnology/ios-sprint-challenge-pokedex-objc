# Manual Reference Counting

Answer the following questions inline with this document.

1. Are there memory leaks with this code? (If so, where are the leaks?)
1- punctuationSet has a retain count of +1 which is explicitly stated. Which must be released.
2- wordFrequency is used again in the for loop when determining the count. Giving it a +1 retain count, so I autoreleased it so it will be released after. 
3- punctuation set is used in the cleanQuote string initialization giving it a +1 retain count, so i must be released after.
4- In the for loop "word" is delclared and then used again to declare the count giving it a +1 retain count and must be autoreleased after the else runs.

    ```swift
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

    2. Rewrite the code so that it does not leak any memory with ARC disabled
    
    NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";
    
    NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain];
    
    NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
    NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];
    
    NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init];
    
    for (NSString *word  in words) {
            NSNumber *count = wordFrequency[word];
            if (count != nil) {
                wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
            } else {
                wordFrequency[word] = [[[NSNumber alloc] initWithInteger:1]autorelease];
            }
    }
    
    NSLog(@"Word frequency: %s", wordFrequency.description.UTF8String);
    
    [punctuationSet release];
    [wordFrequency release];
	

2. Which of these objects is autoreleased?  Why?

	1. `NSDate *yesterday = [NSDate date];`
	
	2. `NSDate *theFuture = [[NSDate dateWithTimeIntervalSinceNow:60] retain];`
	
	3. `NSString *name = [[NSString alloc] initWithString:@"John Sundell"];`
	
	4. `NSDate *food = [NSDate new];`
	
	5. `LSIPerson *john = [[LSIPerson alloc] initWithName:name];`
	
	6. `LSIPerson *max = [[[LSIPerson alloc] initWithName:@"Max"] autorelease];`
    
    LSIPerson 'max' , because we have stated when we initialized the property that it will be released when decided by the compiler.

3. Explain when you need to use the `NSAutoreleasePool`.

When you want your objects to be automatically released after an iteration or something similiar. Like in a for loop where you are iterating or creating objects several times it will automatically release them at the end of each loop.

4. Implement a convenience `class` method to create a `LSIPerson` object that takes a `name` property and returns an autoreleased object.

```swift
@interface LSIPerson: NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;
- (instancetype)personName:(NSSting *)personName;

- (instancetype)personName:(NSSting *)personName {

LSIPerson *person = [[self alloc]initWithName:name];
return [person autorelease];

}

@end
