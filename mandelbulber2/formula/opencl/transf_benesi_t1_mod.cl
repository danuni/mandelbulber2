/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * benesiT1Mod  3D based on benesiT1
 * @reference
 * http://www.fractalforums.com/new-theories-and-research/
 * do-m3d-formula-have-to-be-distance-estimation-formulas/
 */

/* ### This file has been autogenerated. Remove this line, to prevent override. ### */

#ifndef DOUBLE_PRECISION
void TransfBenesiT1ModIteration(float4 *z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	float tempXZ = mad(z->x, SQRT_2_3, -z->z * SQRT_1_3);
	*z = (float4){(tempXZ - z->y) * SQRT_1_2, (tempXZ + z->y) * SQRT_1_2,
		z->x * SQRT_1_3 + z->z * SQRT_2_3, z->w};

	float4 temp = *z;
	float tempL = length(temp);
	*z = fabs(*z) * fractal->transformCommon.scale3D333;
	// if (tempL < 1e-21f) tempL = 1e-21f;
	float avgScale = native_divide(length(*z), tempL);
	aux->r_dz *= avgScale;
	aux->DE = mad(aux->DE, avgScale, 1.0f);

	*z = (fabs(*z + fractal->transformCommon.additionConstant111)
				- fabs(*z - fractal->transformCommon.additionConstant111) - *z);

	if (fractal->transformCommon.rotationEnabled)
	{
		*z = Matrix33MulFloat4(fractal->transformCommon.rotationMatrix, *z);
	}

	tempXZ = (z->y + z->x) * SQRT_1_2;

	*z = (float4){z->z * SQRT_1_3 + tempXZ * SQRT_2_3, (z->y - z->x) * SQRT_1_2,
		z->z * SQRT_2_3 - tempXZ * SQRT_1_3, z->w};
}
#else
void TransfBenesiT1ModIteration(double4 *z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	double tempXZ = mad(z->x, SQRT_2_3, -z->z * SQRT_1_3);
	*z = (double4){(tempXZ - z->y) * SQRT_1_2, (tempXZ + z->y) * SQRT_1_2,
		z->x * SQRT_1_3 + z->z * SQRT_2_3, z->w};

	double4 temp = *z;
	double tempL = length(temp);
	*z = fabs(*z) * fractal->transformCommon.scale3D333;
	// if (tempL < 1e-21) tempL = 1e-21;
	double avgScale = native_divide(length(*z), tempL);
	aux->r_dz *= avgScale;
	aux->DE = aux->DE * avgScale + 1.0;

	*z = (fabs(*z + fractal->transformCommon.additionConstant111)
				- fabs(*z - fractal->transformCommon.additionConstant111) - *z);

	if (fractal->transformCommon.rotationEnabled)
	{
		*z = Matrix33MulFloat4(fractal->transformCommon.rotationMatrix, *z);
	}

	tempXZ = (z->y + z->x) * SQRT_1_2;

	*z = (double4){z->z * SQRT_1_3 + tempXZ * SQRT_2_3, (z->y - z->x) * SQRT_1_2,
		z->z * SQRT_2_3 - tempXZ * SQRT_1_3, z->w};
}
#endif
