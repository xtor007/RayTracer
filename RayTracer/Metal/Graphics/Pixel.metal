//
//  Pixel.cpp
//  RayTracer
//
//  Created by Yasha Serhiienko on 22.04.2023.
//

#include "Pixel.hpp"
#include "metal_stdlib"

Pixel::Pixel() {}

Pixel::Pixel(uint8_t red, uint8_t green, uint8_t blue) {
    this->red = red;
    this->green = green;
    this->blue = blue;
}

Pixel Pixel::operator * (float right) {
    return Pixel(red * right, green * right, blue * right);
}

Pixel Pixel::operator + (Pixel right) {
    return Pixel(
        metal::min(red + right.red, 255),
        metal::min(green + right.green, 255),
        metal::min(blue + right.blue, 255)
    );
}
