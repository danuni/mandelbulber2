/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2019 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Testing  fragmentarium code, mdifs by knighty (jan 2012)
 *

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the function "TestingIteration" in the file fractal_formulas.cpp
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 TestingIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	// REAL4 oldZ = z;
	// REAL fillet = fractal->transformCommon.offset0;
	REAL4 boxSize = fractal->transformCommon.additionConstant0555;

	REAL xOffset = fractal->transformCommon.offset0;
	REAL yOffset = fractal->transformCommon.offset05;

	if (fractal->transformCommon.functionEnabledBxFalse
			&& aux->i >= fractal->transformCommon.startIterationsB
			&& aux->i < fractal->transformCommon.stopIterationsB)
		z -= boxSize;

	if (fractal->transformCommon.functionEnabledAxFalse
			&& aux->i >= fractal->transformCommon.startIterationsX
			&& aux->i < fractal->transformCommon.stopIterationsX)
		z.x = fabs(z.x);

	if (fractal->transformCommon.functionEnabledAyFalse
			&& aux->i >= fractal->transformCommon.startIterationsY
			&& aux->i < fractal->transformCommon.stopIterationsY)
		z.y = fabs(z.y);

	if (fractal->transformCommon.functionEnabledAzFalse
			&& aux->i >= fractal->transformCommon.startIterationsZ
			&& aux->i < fractal->transformCommon.stopIterationsZ)
		z.z = fabs(z.z);

	if (fractal->transformCommon.functionEnabledCxFalse
			&& aux->i >= fractal->transformCommon.startIterationsJ
			&& aux->i < fractal->transformCommon.stopIterationsJ)
	{
		z.x = fabs(z.x);
		int poly = fractal->transformCommon.int3;
		REAL psi = fabs(fmod(atan(native_divide(z.y, z.x)) + native_divide(M_PI_F, poly),
											native_divide(M_PI_F, (0.5f * poly)))
										- native_divide(M_PI_F, poly));
		REAL len = native_sqrt(mad(z.x, z.x, z.y * z.y));
		z.x = native_cos(psi) * len;
		z.y = native_sin(psi) * len;
	}

	if (fractal->transformCommon.functionEnabledBy
			&& aux->i >= fractal->transformCommon.startIterationsD
			&& aux->i < fractal->transformCommon.stopIterationsD)
		if (z.y > z.x)
		{
			REAL temp = z.x;
			z.x = z.y;
			z.y = temp;
		}

	if (fractal->transformCommon.functionEnabledBx
			&& aux->i >= fractal->transformCommon.startIterationsI
			&& aux->i < fractal->transformCommon.stopIterationsI)
		z = z - boxSize;

	if (fractal->transformCommon.functionEnabledxFalse
			&& aux->i >= fractal->transformCommon.startIterationsA
			&& aux->i < fractal->transformCommon.stopIterationsA)
		if (z.x < xOffset) z.x = fabs(z.x - xOffset) + xOffset;

	if (fractal->transformCommon.functionEnabledy
			&& aux->i >= fractal->transformCommon.startIterationsC
			&& aux->i < fractal->transformCommon.stopIterationsC)
		if (z.y < yOffset) z.y = fabs(z.y - yOffset) + yOffset;

	if (aux->i >= fractal->transformCommon.startIterationsE
			&& aux->i < fractal->transformCommon.stopIterationsE)
		z.x -= fractal->transformCommon.offset1;

	if (aux->i >= fractal->transformCommon.startIterationsF
			&& aux->i < fractal->transformCommon.stopIterationsF)
		z.y -= fractal->transformCommon.offsetA1;

	if (fractal->transformCommon.functionEnabledByFalse
			&& aux->i >= fractal->transformCommon.startIterationsG
			&& aux->i < fractal->transformCommon.stopIterationsG)
		if (z.y > z.x)
		{
			REAL temp = z.x;
			z.x = z.y;
			z.y = temp;
		}

	// scale
	REAL useScale = 1.0f;
	if (aux->i >= fractal->transformCommon.startIterationsS
			&& aux->i < fractal->transformCommon.stopIterationsS)
	{
		useScale = aux->actualScaleA + fractal->transformCommon.scale2;

		z *= useScale;

		if (!fractal->analyticDE.enabledFalse)
			aux->DE = mad(aux->DE, fabs(useScale), 1.0f);
		else
			aux->DE =
				mad(aux->DE * fabs(useScale), fractal->analyticDE.scale1, fractal->analyticDE.offset1);

		if (fractal->transformCommon.functionEnabledFFalse
				&& aux->i >= fractal->transformCommon.startIterationsK
				&& aux->i < fractal->transformCommon.stopIterationsK)
		{
			// update actualScaleA for next iteration
			REAL vary = fractal->transformCommon.scaleVary0
									* (fabs(aux->actualScaleA) - fractal->transformCommon.scaleC1);
			if (fractal->transformCommon.functionEnabledMFalse)
				aux->actualScaleA = -vary;
			else
				aux->actualScaleA = aux->actualScaleA - vary;
		}
	}

	if (aux->i >= fractal->transformCommon.startIterationsH
			&& aux->i < fractal->transformCommon.stopIterationsH)
		z += fractal->transformCommon.offset111;

	// rotation
	if (fractal->transformCommon.functionEnabledRFalse
			&& aux->i >= fractal->transformCommon.startIterationsR
			&& aux->i < fractal->transformCommon.stopIterationsR)
	{
		z = Matrix33MulFloat4(fractal->transformCommon.rotationMatrix, z);
	}

	REAL4 zc = z;

	if (fractal->analyticDE.enabled)
	{
		if (!fractal->analyticDE.enabledFalse)
		{
			if (fractal->transformCommon.functionEnabledBx) zc = fabs(zc) - boxSize;
			REAL zcd = 1.0f;
			zcd = max(zc.x, max(zc.y, zc.z));
			if (zcd > 0.0f)
			{
				zc.x = max(zc.x, 0.0f);
				zc.y = max(zc.y, 0.0f);
				zc.z = max(zc.z, 0.0f);
				zcd = length(zc);
			}
			aux->dist = min(aux->dist, native_divide(zcd, aux->DE));
			aux->dist = mad(aux->dist, fractal->analyticDE.scale1, fractal->analyticDE.offset0);
		}

		else
		{
			/*REAL dist = max(z.x, max(z.y, z.z));
				if (dist > 0.0f)
				{
					zc.x = max(z.x, 0.0f);
					zc.y = max(z.y, 0.0f);
					if(fractal->transformCommon.functionEnabledz)
						zc.z = z.y;
					zc.z = max(zc.z, 0.0f);
					dist = max(dist, length(zc));
				}
			REAL maxDist = dist;
			maxDist = max(maxDist, length(z));
			aux->DE = aux->DE * native_divide(maxDist, length(z)) * fractal->analyticDE.scale1 +
			fractal->analyticDE.offset0; if(fractal->transformCommon.functionEnabledyFalse)
			{
				z = zc;
			}*/
			/*if (fractal->transformCommon.functionEnabledFalse)
				zc  =  fabs(zc) - boxSize;
			REAL zcd = 1.0f;
			zcd = max(zc.x, max(zc.y, zc.z));
				if (zcd > 0.0f)
				{
					zc.x = max(zc.x, 0.0f);
					zc.y = max(zc.y, 0.0f);
					zc.z = max(zc.z, 0.0f);
					zcd = length(zc);
				}
				aux->dist = min(aux->dist, native_divide(zcd, aux->DE));*/
			aux->DE = mad(aux->DE, fractal->analyticDE.scale1, fractal->analyticDE.offset0);
		}
	}
	return z;
}