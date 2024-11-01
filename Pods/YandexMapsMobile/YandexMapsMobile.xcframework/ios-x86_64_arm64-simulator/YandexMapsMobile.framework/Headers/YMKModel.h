#import <YandexMapsMobile/YMKCallback.h>
#import <YandexMapsMobile/YMKDataProviderWithId.h>

@class YMKModelStyle;

/**
 * describes model presentation of PlacemarkMapObject
 */
@interface YMKModel : NSObject
/**
 * describes style of the model
 */
@property (nonatomic, nonnull) YMKModelStyle *modelStyle;

/**
 * Sets gltf data provider.
 *
 * The class maintains a strong reference to the object in
 * the 'gltfDataProvider' parameter until it (the class) is invalidated.
 *
 * @param onFinished Called when the model is loaded.
 */
- (void)setDataWithGltfDataProvider:(nonnull id<YMKDataProviderWithId>)gltfDataProvider
                           callback:(nonnull YMKCallback)callback;

/**
 * Tells if this object is valid or no. Any method called on an invalid
 * object will throw an exception. The object becomes invalid only on UI
 * thread, and only when its implementation depends on objects already
 * destroyed by now. Please refer to general docs about the interface for
 * details on its invalidation.
 */
@property (nonatomic, readonly, getter=isValid) BOOL valid;

@end
