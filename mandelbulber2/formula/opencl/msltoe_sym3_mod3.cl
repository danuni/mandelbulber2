/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Msltoe_Julia_Bulb_Mod3
 * @reference
 * http://www.fractalforums.com/theory/choosing-the-squaring-formula-by-location/msg14320/#msg14320
 */

/* ### This file has been autogenerated. Remove this line, to prevent override. ### */

#ifndef DOUBLE_PRECISION
void MsltoeSym3Mod3Iteration(float4 *z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	float4 c = aux->const_c;
	aux->r_dz = aux->r_dz * 2.0f * aux->r;
	float4 z1 = *z;
	float psi = mad(2.0f, M_PI, atan2(z->z, z->y));
	float psi2 = 0;
	while (psi > M_PI_8)
	{
		psi -= M_PI_4;
		psi2 -= M_PI_4; // M_PI_4 = pi/4
	}
	float cs = native_cos(psi2);
	float sn = native_sin(psi2);
	z1.y = mad(z->y, cs, -z->z * sn);
	z1.z = mad(z->y, sn, z->z * cs);
	z->y = z1.y;
	z->z = z1.z;
	float4 zs = *z * *z;
	float zs2 = zs.x + zs.y;
	// if (zs2 < 1e-21f)
	//	zs2 = 1e-21f;
	float zs3 = mad(
		zs.z, fractal->transformCommon.scale0 * fractal->transformCommon.scale0 * zs.y, (zs2 + zs.z));
	float zsd = (1.0f - native_divide(zs.z, zs3));

	z1.x = (zs.x - zs.y) * zsd;
	z1.y = (2.0f * z->x * z->y) * zsd * fractal->transformCommon.scale; // scaling y;
	z1.z = 2.0f * z->z * native_sqrt(zs2);
	z->x = z1.x;
	z->y = mad(z1.y, cs, z1.z * sn);
	z->z = mad(-z1.y, sn, z1.z * cs);
	*z += fractal->transformCommon.additionConstant000;
	if (fractal->transformCommon.addCpixelEnabledFalse) // symmetrical addCpixel
	{
		float4 tempFAB = c;
		if (fractal->transformCommon.functionEnabledx) tempFAB.x = fabs(tempFAB.x);
		if (fractal->transformCommon.functionEnabledy) tempFAB.y = fabs(tempFAB.y);
		if (fractal->transformCommon.functionEnabledz) tempFAB.z = fabs(tempFAB.z);

		tempFAB *= fractal->transformCommon.constantMultiplier000;
		z->x += copysign(tempFAB.x, z->x);
		z->y += copysign(tempFAB.y, z->y);
		z->z += copysign(tempFAB.z, z->z);
	}
	float lengthTempZ = length(-*z); // spherical offset
	// if (lengthTempZ > -1e-21f)
	//	lengthTempZ = -1e-21f;   //  *z is neg.)
	*z *= 1.0f + native_divide(fractal->transformCommon.offset, lengthTempZ);
	*z *= fractal->transformCommon.scale1;
	aux->r_dz *= fabs(fractal->transformCommon.scale1);

	if (fractal->transformCommon.functionEnabledFalse // quaternion fold
			&& aux->i >= fractal->transformCommon.startIterationsA
			&& aux->i < fractal->transformCommon.stopIterationsA)
	{
		aux->r = length(*z);
		aux->r_dz = aux->r_dz * 2.0f * aux->r;
		*z = (float4){z->x * z->x - z->y * z->y - z->z * z->z, z->x * z->y, z->x * z->z, z->w};
		if (fractal->transformCommon.functionEnabledAxFalse)
		{
			float4 temp = *z;
			float tempL = length(temp);
			*z *= (float4){1.0f, 2.0f, 2.0f, 1.0f};
			// if (tempL < 1e-21f)
			//	tempL = 1e-21f;
			float avgScale = native_divide(length(*z), tempL);
			aux->r_dz *= avgScale;
		}
		else
		{
			*z *= (float4){1.0f, 2.0f, 2.0f, 1.0f};
		}
	}
}
#else
void MsltoeSym3Mod3Iteration(double4 *z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	double4 c = aux->const_c;
	aux->r_dz = aux->r_dz * 2.0 * aux->r;
	double4 z1 = *z;
	double psi = atan2(z->z, z->y) + M_PI * 2.0;
	double psi2 = 0;
	while (psi > M_PI_8)
	{
		psi -= M_PI_4;
		psi2 -= M_PI_4; // M_PI_4 = pi/4
	}
	double cs = native_cos(psi2);
	double sn = native_sin(psi2);
	z1.y = mad(z->y, cs, -z->z * sn);
	z1.z = mad(z->y, sn, z->z * cs);
	z->y = z1.y;
	z->z = z1.z;
	double4 zs = *z * *z;
	double zs2 = zs.x + zs.y;
	// if (zs2 < 1e-21)
	//	zs2 = 1e-21;
	double zs3 = mad(
		zs.z, fractal->transformCommon.scale0 * fractal->transformCommon.scale0 * zs.y, (zs2 + zs.z));
	double zsd = (1.0 - native_divide(zs.z, zs3));

	z1.x = (zs.x - zs.y) * zsd;
	z1.y = (2.0 * z->x * z->y) * zsd * fractal->transformCommon.scale; // scaling y;
	z1.z = 2.0 * z->z * native_sqrt(zs2);
	z->x = z1.x;
	z->y = mad(z1.y, cs, z1.z * sn);
	z->z = mad(-z1.y, sn, z1.z * cs);
	*z += fractal->transformCommon.additionConstant000;
	if (fractal->transformCommon.addCpixelEnabledFalse) // symmetrical addCpixel
	{
		double4 tempFAB = c;
		if (fractal->transformCommon.functionEnabledx) tempFAB.x = fabs(tempFAB.x);
		if (fractal->transformCommon.functionEnabledy) tempFAB.y = fabs(tempFAB.y);
		if (fractal->transformCommon.functionEnabledz) tempFAB.z = fabs(tempFAB.z);

		tempFAB *= fractal->transformCommon.constantMultiplier000;
		z->x += copysign(tempFAB.x, z->x);
		z->y += copysign(tempFAB.y, z->y);
		z->z += copysign(tempFAB.z, z->z);
	}
	double lengthTempZ = length(-*z); // spherical offset
	// if (lengthTempZ > -1e-21)
	//	lengthTempZ = -1e-21;   //  *z is neg.)
	*z *= 1.0 + native_divide(fractal->transformCommon.offset, lengthTempZ);
	*z *= fractal->transformCommon.scale1;
	aux->r_dz *= fabs(fractal->transformCommon.scale1);

	if (fractal->transformCommon.functionEnabledFalse // quaternion fold
			&& aux->i >= fractal->transformCommon.startIterationsA
			&& aux->i < fractal->transformCommon.stopIterationsA)
	{
		aux->r = length(*z);
		aux->r_dz = aux->r_dz * 2.0 * aux->r;
		*z = (double4){z->x * z->x - z->y * z->y - z->z * z->z, z->x * z->y, z->x * z->z, z->w};
		if (fractal->transformCommon.functionEnabledAxFalse)
		{
			double4 temp = *z;
			double tempL = length(temp);
			*z *= (double4){1.0, 2.0, 2.0, 1.0};
			// if (tempL < 1e-21)
			//	tempL = 1e-21;
			double avgScale = native_divide(length(*z), tempL);
			aux->r_dz *= avgScale;
		}
		else
		{
			*z *= (double4){1.0, 2.0, 2.0, 1.0};
		}
	}
}
#endif
