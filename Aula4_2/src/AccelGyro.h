/*
 * AccelGyro.h
 *
 *  Created on: 16 de mai de 2018
 *      Author: nicolas.oliveira
 */

#ifndef ACCELGYRO_H_
#define ACCELGYRO_H_

class AccelGyro{

public:
	static uint8_t WHO_AM_I;
	static uint16_t ACCEL_Z;
	static uint8_t ACCEL_ZOUT_H;
	static uint8_t ACCEL_ZOUT_L;
	static uint8_t ACCEL_CONFIG;
	static float gravity;
};


#endif /* ACCELGYRO_H_ */
