#import <Foundation/Foundation.h>

/**
 * Provides any string data.
 */
@protocol YMKDataProviderWithId <NSObject>

/**
 * Use the same id for the identical data, to prevent repeated loading
 * of the same data into RAM and VRAM. Called in any thread.
 *
 * This method will be called on a background thread.
 */
- (nonnull NSString *)providerId;

/**
 * Return string data. Called in a separate thread.
 *
 * This method will be called on a background thread.
 */
- (nonnull NSString *)load;

@end
