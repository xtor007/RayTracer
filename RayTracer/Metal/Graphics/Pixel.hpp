//
//  Pixel.hpp
//  RayTracer
//
//  Created by Yasha Serhiienko on 22.04.2023.
//

#ifndef Pixel_hpp
#define Pixel_hpp

//#pragma pack(push, 1)
struct Pixel {
public:
    uint8_t red;
    uint8_t green;
    uint8_t blue;
    
    Pixel();
    
    Pixel(uint8_t red, uint8_t green, uint8_t blue);
    
    Pixel operator * (float right);
    
    Pixel operator + (Pixel right);
};
//#pragma pack(pop)

#endif /* Pixel_hpp */
