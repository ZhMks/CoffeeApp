#import <Foundation/Foundation.h>

/**
 * Supported map style modes
 */
typedef NS_ENUM(NSUInteger, YMKMapMode) {
    /**
     * Basic map
     */
    YMKMapModeMap,
    /**
     * Public transport map
     */
    YMKMapModeTransit,
    /**
     * Automobile navigation map
     */
    YMKMapModeDriving,
    /**
     * Administrative map
     */
    YMKMapModeAdmin
};
