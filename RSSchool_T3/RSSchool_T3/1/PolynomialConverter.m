#import "PolynomialConverter.h"

@implementation PolynomialConverter
- (NSString*)convertToStringFrom:(NSArray <NSNumber*>*)numbers {
    NSMutableString *result = [[NSMutableString alloc] init];
    NSUInteger counter = [numbers count];
    BOOL skipElement = false;
    
    if (counter == 0) return nil;
    else {
        for (int i = 0; i < [numbers count]; i++) {
            NSInteger number = abs([numbers[i] intValue]);
            counter--;
            
            if (skipElement) skipElement = false;
            else {
                switch (counter) {
                    case 0:
                        [result appendString:[NSString stringWithFormat:@"%ld", (long)number]];
                        break;
                    case 1:
                        if (number == 1) [result appendString:[NSString stringWithFormat:@"%@", @"x"]];
                        else [result appendString:[NSString stringWithFormat:@"%ld%@", (long)number, @"x"]];
                        break;
                        
                    default:
                        if (number == 1) [result appendString:[NSString stringWithFormat:@"%@%ld", @"x^", counter]];
                        else [result appendString:[NSString stringWithFormat:@"%ld%@%ld", (long)number, @"x^", counter]];
                        break;
                }
            }
            
            if (counter > 0) {
                NSInteger nextNumber = [numbers[i + 1] intValue];
                
                if (nextNumber > 0) [result appendString:[NSString stringWithFormat:@" + "]];
                else if (nextNumber < 0) [result appendString:[NSString stringWithFormat:@" - "]];
                else skipElement = true;
            }
        }
    }
    return result;
}
@end
