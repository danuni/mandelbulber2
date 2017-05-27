/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Adds Cpixel constant to z vector, with symmetry
 */

/* ### This file has been autogenerated. Remove this line, to prevent override. ### */

#ifndef DOUBLE_PRECISION
void TransfAddCpixelSymmetricalIteration(
	float4 *z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	float4 tempFAB = aux->const_c;
	if (fractal->transformCommon.functionEnabledx) tempFAB.x = fabs(tempFAB.x);
	if (fractal->transformCommon.functionEnabledy) tempFAB.y = fabs(tempFAB.y);
	if (fractal->transformCommon.functionEnabledz) tempFAB.z = fabs(tempFAB.z);

	tempFAB *= fractal->transformCommon.constantMultiplier111;

	z->x += copysign(tempFAB.x, z->x);
	z->y += copysign(tempFAB.y, z->y);
	z->z += copysign(tempFAB.z, z->z);
}
#else
void TransfAddCpixelSymmetricalIteration(
	double4 *z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	double4 tempFAB = aux->const_c;
	if (fractal->transformCommon.functionEnabledx) tempFAB.x = fabs(tempFAB.x);
	if (fractal->transformCommon.functionEnabledy) tempFAB.y = fabs(tempFAB.y);
	if (fractal->transformCommon.functionEnabledz) tempFAB.z = fabs(tempFAB.z);

	tempFAB *= fractal->transformCommon.constantMultiplier111;

	z->x += copysign(tempFAB.x, z->x);
	z->y += copysign(tempFAB.y, z->y);
	z->z += copysign(tempFAB.z, z->z);
}
#endif
