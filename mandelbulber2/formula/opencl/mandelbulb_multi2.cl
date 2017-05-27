/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * mandelbulbMulti2 3D
 */

/* ### This file has been autogenerated. Remove this line, to prevent override. ### */

#ifndef DOUBLE_PRECISION
void MandelbulbMulti2Iteration(float4 *z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	float4 c = aux->const_c;
	if (fractal->transformCommon.functionEnabledFalse)
	{
		if (fractal->transformCommon.functionEnabledAxFalse
				&& aux->i >= fractal->transformCommon.startIterationsX
				&& aux->i < fractal->transformCommon.stopIterationsX)
			z->x = fabs(z->x);
		if (fractal->transformCommon.functionEnabledAyFalse
				&& aux->i >= fractal->transformCommon.startIterationsY
				&& aux->i < fractal->transformCommon.stopIterationsY)
			z->y = fabs(z->y);
		if (fractal->transformCommon.functionEnabledAzFalse
				&& aux->i >= fractal->transformCommon.startIterationsZ
				&& aux->i < fractal->transformCommon.stopIterationsZ)
			z->z = fabs(z->z);
	}

	float th0 = fractal->bulb.betaAngleOffset;
	float ph0 = fractal->bulb.alphaAngleOffset;

	float3 v;
	switch (fractal->sinTan2Trig.orderOfZYX)
	{
		case multi_OrderOfZYXCl_zyx:
		default: v = (float3){z->z, z->y, z->x}; break;
		case multi_OrderOfZYXCl_zxy: v = (float3){z->z, z->x, z->y}; break;
		case multi_OrderOfZYXCl_yzx: v = (float3){z->y, z->z, z->x}; break;
		case multi_OrderOfZYXCl_yxz: v = (float3){z->y, z->x, z->z}; break;
		case multi_OrderOfZYXCl_xzy: v = (float3){z->x, z->z, z->y}; break;
		case multi_OrderOfZYXCl_xyz: v = (float3){z->x, z->y, z->z}; break;
	}

	if (fractal->sinTan2Trig.asinOrAcos == multi_asinOrAcosCl_asin)
		th0 += asin(native_divide(v.x, aux->r));
	else
		th0 += acos(native_divide(v.x, aux->r));

	if (fractal->sinTan2Trig.atan2OrAtan == multi_atan2OrAtanCl_atan2)
		ph0 += atan2(v.y, v.z);
	else
		ph0 += atan(native_divide(v.y, v.z));

	float rp = native_powr(aux->r, fractal->bulb.power - 1.0f);
	float th = th0 * fractal->bulb.power * fractal->transformCommon.scaleA1;
	float ph = ph0 * fractal->bulb.power * fractal->transformCommon.scaleB1;

	aux->r_dz = mad(rp * aux->r_dz, fractal->bulb.power, 1.0f);
	rp *= aux->r;

	if (fractal->transformCommon.functionEnabledxFalse)
	{ // cosine mode
		float sinth = th;
		if (fractal->transformCommon.functionEnabledyFalse) sinth = th0;
		sinth = native_sin(sinth);
		*z = rp * (float4){sinth * native_sin(ph), native_cos(ph) * sinth, native_cos(th), 0.0f};
	}
	else
	{ // sine mode ( default = V2.07))
		float costh = th;
		if (fractal->transformCommon.functionEnabledzFalse) costh = th0;
		costh = native_cos(costh);
		*z = rp * (float4){costh * native_cos(ph), native_sin(ph) * costh, native_sin(th), 0.0f};
	}

	if (fractal->transformCommon.functionEnabledKFalse)
	{
		if (fractal->transformCommon.functionEnabledDFalse
				&& aux->i >= fractal->transformCommon.startIterationsD
				&& aux->i < fractal->transformCommon.stopIterationsD)
		{
			float temp = z->x;
			z->x = z->y;
			z->y = temp;
		}
		if (fractal->transformCommon.functionEnabledEFalse
				&& aux->i >= fractal->transformCommon.startIterationsE
				&& aux->i < fractal->transformCommon.stopIterationsE)
		{
			float temp = z->x;
			z->x = z->z;
			z->z = temp;
		}

		// swap
		if (fractal->transformCommon.functionEnabledBxFalse) z->x = -z->x;
		if (fractal->transformCommon.functionEnabledByFalse) z->y = -z->y;
		if (fractal->transformCommon.functionEnabledBzFalse) z->z = -z->z;
	}
	*z += fractal->transformCommon.additionConstant000;
	if (fractal->transformCommon.addCpixelEnabledFalse)
	{
		float4 tempC = c;
		if (fractal->transformCommon.alternateEnabledFalse) // alternate
		{
			tempC = aux->c;
			switch (fractal->mandelbulbMulti.orderOfXYZC)
			{
				case multi_OrderOfXYZCl_xyz:
				default: tempC = (float4){tempC.x, tempC.y, tempC.z, tempC.w}; break;
				case multi_OrderOfXYZCl_xzy: tempC = (float4){tempC.x, tempC.z, tempC.y, tempC.w}; break;
				case multi_OrderOfXYZCl_yxz: tempC = (float4){tempC.y, tempC.x, tempC.z, tempC.w}; break;
				case multi_OrderOfXYZCl_yzx: tempC = (float4){tempC.y, tempC.z, tempC.x, tempC.w}; break;
				case multi_OrderOfXYZCl_zxy: tempC = (float4){tempC.z, tempC.x, tempC.y, tempC.w}; break;
				case multi_OrderOfXYZCl_zyx: tempC = (float4){tempC.z, tempC.y, tempC.x, tempC.w}; break;
			}
			aux->c = tempC;
		}
		else
		{
			switch (fractal->mandelbulbMulti.orderOfXYZC)
			{
				case multi_OrderOfXYZCl_xyz:
				default: tempC = (float4){c.x, c.y, c.z, c.w}; break;
				case multi_OrderOfXYZCl_xzy: tempC = (float4){c.x, c.z, c.y, c.w}; break;
				case multi_OrderOfXYZCl_yxz: tempC = (float4){c.y, c.x, c.z, c.w}; break;
				case multi_OrderOfXYZCl_yzx: tempC = (float4){c.y, c.z, c.x, c.w}; break;
				case multi_OrderOfXYZCl_zxy: tempC = (float4){c.z, c.x, c.y, c.w}; break;
				case multi_OrderOfXYZCl_zyx: tempC = (float4){c.z, c.y, c.x, c.w}; break;
			}
		}
		*z += tempC * fractal->transformCommon.constantMultiplierC111;
	}
	// rotation
	if (fractal->transformCommon.functionEnabledRFalse
			&& aux->i >= fractal->transformCommon.startIterationsR
			&& aux->i < fractal->transformCommon.stopIterationsR)
	{
		*z = Matrix33MulFloat4(fractal->transformCommon.rotationMatrix, *z);
	}
}
#else
void MandelbulbMulti2Iteration(double4 *z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	double4 c = aux->const_c;
	if (fractal->transformCommon.functionEnabledFalse)
	{
		if (fractal->transformCommon.functionEnabledAxFalse
				&& aux->i >= fractal->transformCommon.startIterationsX
				&& aux->i < fractal->transformCommon.stopIterationsX)
			z->x = fabs(z->x);
		if (fractal->transformCommon.functionEnabledAyFalse
				&& aux->i >= fractal->transformCommon.startIterationsY
				&& aux->i < fractal->transformCommon.stopIterationsY)
			z->y = fabs(z->y);
		if (fractal->transformCommon.functionEnabledAzFalse
				&& aux->i >= fractal->transformCommon.startIterationsZ
				&& aux->i < fractal->transformCommon.stopIterationsZ)
			z->z = fabs(z->z);
	}

	double th0 = fractal->bulb.betaAngleOffset;
	double ph0 = fractal->bulb.alphaAngleOffset;

	double3 v;
	switch (fractal->sinTan2Trig.orderOfZYX)
	{
		case multi_OrderOfZYXCl_zyx:
		default: v = (double3){z->z, z->y, z->x}; break;
		case multi_OrderOfZYXCl_zxy: v = (double3){z->z, z->x, z->y}; break;
		case multi_OrderOfZYXCl_yzx: v = (double3){z->y, z->z, z->x}; break;
		case multi_OrderOfZYXCl_yxz: v = (double3){z->y, z->x, z->z}; break;
		case multi_OrderOfZYXCl_xzy: v = (double3){z->x, z->z, z->y}; break;
		case multi_OrderOfZYXCl_xyz: v = (double3){z->x, z->y, z->z}; break;
	}

	if (fractal->sinTan2Trig.asinOrAcos == multi_asinOrAcosCl_asin)
		th0 += asin(native_divide(v.x, aux->r));
	else
		th0 += acos(native_divide(v.x, aux->r));

	if (fractal->sinTan2Trig.atan2OrAtan == multi_atan2OrAtanCl_atan2)
		ph0 += atan2(v.y, v.z);
	else
		ph0 += atan(native_divide(v.y, v.z));

	double rp = native_powr(aux->r, fractal->bulb.power - 1.0);
	double th = th0 * fractal->bulb.power * fractal->transformCommon.scaleA1;
	double ph = ph0 * fractal->bulb.power * fractal->transformCommon.scaleB1;

	aux->r_dz = rp * aux->r_dz * fractal->bulb.power + 1.0;
	rp *= aux->r;

	if (fractal->transformCommon.functionEnabledxFalse)
	{ // cosine mode
		double sinth = th;
		if (fractal->transformCommon.functionEnabledyFalse) sinth = th0;
		sinth = native_sin(sinth);
		*z = rp * (double4){sinth * native_sin(ph), native_cos(ph) * sinth, native_cos(th), 0.0};
	}
	else
	{ // sine mode ( default = V2.07))
		double costh = th;
		if (fractal->transformCommon.functionEnabledzFalse) costh = th0;
		costh = native_cos(costh);
		*z = rp * (double4){costh * native_cos(ph), native_sin(ph) * costh, native_sin(th), 0.0};
	}

	if (fractal->transformCommon.functionEnabledKFalse)
	{
		if (fractal->transformCommon.functionEnabledDFalse
				&& aux->i >= fractal->transformCommon.startIterationsD
				&& aux->i < fractal->transformCommon.stopIterationsD)
		{
			double temp = z->x;
			z->x = z->y;
			z->y = temp;
		}
		if (fractal->transformCommon.functionEnabledEFalse
				&& aux->i >= fractal->transformCommon.startIterationsE
				&& aux->i < fractal->transformCommon.stopIterationsE)
		{
			double temp = z->x;
			z->x = z->z;
			z->z = temp;
		}

		// swap
		if (fractal->transformCommon.functionEnabledBxFalse) z->x = -z->x;
		if (fractal->transformCommon.functionEnabledByFalse) z->y = -z->y;
		if (fractal->transformCommon.functionEnabledBzFalse) z->z = -z->z;
	}
	*z += fractal->transformCommon.additionConstant000;
	if (fractal->transformCommon.addCpixelEnabledFalse)
	{
		double4 tempC = c;
		if (fractal->transformCommon.alternateEnabledFalse) // alternate
		{
			tempC = aux->c;
			switch (fractal->mandelbulbMulti.orderOfXYZC)
			{
				case multi_OrderOfXYZCl_xyz:
				default: tempC = (double4){tempC.x, tempC.y, tempC.z, tempC.w}; break;
				case multi_OrderOfXYZCl_xzy: tempC = (double4){tempC.x, tempC.z, tempC.y, tempC.w}; break;
				case multi_OrderOfXYZCl_yxz: tempC = (double4){tempC.y, tempC.x, tempC.z, tempC.w}; break;
				case multi_OrderOfXYZCl_yzx: tempC = (double4){tempC.y, tempC.z, tempC.x, tempC.w}; break;
				case multi_OrderOfXYZCl_zxy: tempC = (double4){tempC.z, tempC.x, tempC.y, tempC.w}; break;
				case multi_OrderOfXYZCl_zyx: tempC = (double4){tempC.z, tempC.y, tempC.x, tempC.w}; break;
			}
			aux->c = tempC;
		}
		else
		{
			switch (fractal->mandelbulbMulti.orderOfXYZC)
			{
				case multi_OrderOfXYZCl_xyz:
				default: tempC = (double4){c.x, c.y, c.z, c.w}; break;
				case multi_OrderOfXYZCl_xzy: tempC = (double4){c.x, c.z, c.y, c.w}; break;
				case multi_OrderOfXYZCl_yxz: tempC = (double4){c.y, c.x, c.z, c.w}; break;
				case multi_OrderOfXYZCl_yzx: tempC = (double4){c.y, c.z, c.x, c.w}; break;
				case multi_OrderOfXYZCl_zxy: tempC = (double4){c.z, c.x, c.y, c.w}; break;
				case multi_OrderOfXYZCl_zyx: tempC = (double4){c.z, c.y, c.x, c.w}; break;
			}
		}
		*z += tempC * fractal->transformCommon.constantMultiplierC111;
	}
	// rotation
	if (fractal->transformCommon.functionEnabledRFalse
			&& aux->i >= fractal->transformCommon.startIterationsR
			&& aux->i < fractal->transformCommon.stopIterationsR)
	{
		*z = Matrix33MulFloat4(fractal->transformCommon.rotationMatrix, *z);
	}
}
#endif
