/******************************************************************************
 * @section DESCRIPTION
 *
 * This routine initailizes the vegetation variable array.
 *
 * @section LICENSE
 *
 * The Variable Infiltration Capacity (VIC) macroscale hydrological model
 * Copyright (C) 2016 The Computational Hydrology Group, Department of Civil
 * and Environmental Engineering, University of Washington.
 *
 * The VIC model is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along with
 * this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 *****************************************************************************/

#include <vic_driver_shared_all.h>

void initialize_veg1(veg_var_struct *veg_var) {
  extern option_struct options;

  size_t k;

  // Prognostic states
  veg_var->albedo = 0.0;
  veg_var->displacement = 0.0;
  veg_var->fcanopy = 0.0;
  veg_var->LAI = 0.0;
  veg_var->roughness = 0.0;
  veg_var->Wdew = 0.0;
  veg_var->Wdmax = 0.0;
  // Fluxes
  veg_var->canopyevap = 0.0;
  veg_var->throughfall = 0.0;

  if (options.CARBON) {
    // Carbon states
    veg_var->AnnualNPP = 0.0;
    veg_var->AnnualNPPPrev = 0.0;
    veg_var->Ci = 0.0;
    veg_var->NPPfactor = 0.0;
    veg_var->rc = 0.0;
    for (k = 0; k < options.Ncanopy; k++) {
      veg_var->CiLayer[k] = 0.0;
      veg_var->NscaleFactor[k] = 0.0;
      veg_var->rsLayer[k] = 0.0;
    }
    // Carbon fluxes
    veg_var->aPAR = 0.0;
    for (k = 0; k < options.Ncanopy; k++) {
      veg_var->aPARLayer[k] = 0.0;
    }
    veg_var->GPP = 0.0;
    veg_var->Litterfall = 0.0;
    veg_var->NPP = 0.0;
    veg_var->Raut = 0.0;
    veg_var->Rdark = 0.0;
    veg_var->Rgrowth = 0.0;
    veg_var->Rmaint = 0.0;
    veg_var->Rphoto = 0.0;
  }
}

/******************************************************************************
 * @brief    This routine initailizes the vegetation variable array.
 *****************************************************************************/
void initialize_veg(veg_var_struct **veg_var,
                    size_t Nveg) {
  extern option_struct options;

  size_t i, j;

  for (i = 0; i < Nveg; i++) {
    for (j = 0; j < options.SNOW_BAND; j++) {
      initialize_veg1(&veg_var[i][j]);
    }
  }
}
