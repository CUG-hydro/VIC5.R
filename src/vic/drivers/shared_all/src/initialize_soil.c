/******************************************************************************
 * @section DESCRIPTION
 *
 * This routine initializes the soil variable arrays for each new grid cell.
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

void initialize_soil1(cell_data_struct *cell) {
  extern option_struct options;

  size_t lindex, frost_area;

  // Prognostic states
  cell->aero_resist[0] = 0.0;
  cell->aero_resist[1] = 0.0;
  cell->CLitter = 0.0;
  cell->CInter = 0.0;
  cell->CSlow = 0.0;

  for (lindex = 0; lindex < options.Nlayer; lindex++) {
    cell->layer[lindex].Cs = 0.0;
    cell->layer[lindex].T = 0.0;
    for (frost_area = 0; frost_area < options.Nfrost; frost_area++) {
      cell->layer[lindex].ice[frost_area] = 0.0;
    }
    cell->layer[lindex].kappa = 0.0;
    cell->layer[lindex].moist = 0.0;
    cell->layer[lindex].phi = 0.0;
  }

  cell->rootmoist = 0.0;
  cell->wetness = 0.0;
  // Fluxes
  cell->pot_evap = 0.0;
  cell->baseflow = 0.0;
  cell->runoff = 0.0;
  cell->inflow = 0.0;
  cell->RhLitter = 0.0;
  cell->RhLitter2Atm = 0.0;
  cell->RhInter = 0.0;
  cell->RhSlow = 0.0;
  cell->RhTot = 0.0;
  for (lindex = 0; lindex < options.Nlayer; lindex++) {
    cell->layer[lindex].esoil = 0.0;
    cell->layer[lindex].transp = 0.0;
    cell->layer[lindex].evap = 0.0;
  }
}

/******************************************************************************
 * @brief    This routine initializes the soil variable arrays for each new
 *           grid cell.
 *****************************************************************************/
void initialize_soil(cell_data_struct **cell,
                     size_t veg_num) {
  extern option_struct options;
  size_t veg, band;

  for (veg = 0; veg <= veg_num; veg++) {
    for (band = 0; band < options.SNOW_BAND; band++) {
      initialize_soil1(&cell[veg][band]);
    }
  }
}
