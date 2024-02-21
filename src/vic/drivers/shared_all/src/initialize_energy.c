/******************************************************************************
 * @section DESCRIPTION
 *
 * Initialize energy structure.
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

void initialize_energy1(energy_bal_struct *energy) {
  extern option_struct options;
  size_t index;

  // Prognostic states
  energy->AlbedoLake = 0.0;
  energy->AlbedoOver = 0.0;
  energy->AlbedoUnder = 0.0;
  energy->Cs[0] = 0.0;
  energy->Cs[1] = 0.0;
  energy->frozen = false;
  energy->kappa[0] = 0.0;
  energy->kappa[1] = 0.0;
  energy->Nfrost = 0;
  energy->Nthaw = 0;
  energy->T1_index = 0;
  energy->Tcanopy = 0;
  energy->Tcanopy_fbflag = false;
  energy->Tcanopy_fbcount = 0;
  energy->Tfoliage = 0.0;
  energy->Tfoliage_fbflag = false;
  energy->Tfoliage_fbcount = 0;
  energy->Tsurf = 0.0;
  energy->Tsurf_fbflag = false;
  energy->Tsurf_fbcount = 0;
  energy->unfrozen = 0.0;

  for (index = 0; index < options.Nnode - 1; index++) {
    energy->Cs_node[index] = 0.0;
    energy->ice[index] = 0.0;
    energy->kappa_node[index] = 0.0;
    energy->moist[index] = 0.0;
    energy->T[index] = 0.0;
    energy->T_fbflag[index] = false;
    energy->T_fbcount[index] = 0;
  }
  for (index = 0; index < MAX_FRONTS - 1; index++) {
    energy->fdepth[index] = 0.0;
    energy->tdepth[index] = 0.0;
  }
  // Fluxes
  energy->advected_sensible = 0.0;
  energy->advection = 0.0;
  energy->AtmosError = 0.0;
  energy->AtmosLatent = 0.0;
  energy->AtmosLatentSub = 0.0;
  energy->AtmosSensible = 0.0;
  energy->canopy_advection = 0.0;
  energy->canopy_latent = 0.0;
  energy->canopy_latent_sub = 0.0;
  energy->canopy_refreeze = 0.0;
  energy->canopy_sensible = 0.0;
  energy->deltaCC = 0.0;
  energy->deltaH = 0.0;
  energy->error = 0.0;
  energy->fusion = 0.0;
  energy->grnd_flux = 0.0;
  energy->latent = 0.0;
  energy->latent_sub = 0.0;
  energy->longwave = 0.0;
  energy->LongOverIn = 0.0;
  energy->LongUnderIn = 0.0;
  energy->LongUnderOut = 0.0;
  energy->melt_energy = 0.0;
  energy->NetLongAtmos = 0.0;
  energy->NetLongOver = 0.0;
  energy->NetLongUnder = 0.0;
  energy->NetShortAtmos = 0.0;
  energy->NetShortGrnd = 0.0;
  energy->NetShortOver = 0.0;
  energy->NetShortUnder = 0.0;
  energy->out_long_canopy = 0.0;
  energy->out_long_surface = 0.0;
  energy->refreeze_energy = 0.0;
  energy->sensible = 0.0;
  energy->shortwave = 0.0;
  energy->ShortOverIn = 0.0;
  energy->ShortUnderIn = 0.0;
  energy->snow_flux = 0.0;
}

/******************************************************************************
 * @brief    Initialize energy structure.
 *****************************************************************************/
void initialize_energy(energy_bal_struct **energy,
                       size_t Nveg) {
  extern option_struct options;
  size_t veg, band;

  // initialize miscellaneous energy balance terms
  for (veg = 0; veg <= Nveg; veg++) {
    for (band = 0; band < options.SNOW_BAND; band++) {
      initialize_energy1(&energy[veg][band]);
    }
  }
}
