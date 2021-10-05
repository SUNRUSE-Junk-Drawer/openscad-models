use <../../utilities/linear_interpolate.scad>;
use <fret.scad>;
use <fretboard.scad>;

/**
  * Calculates the length of the truss rod on the Y axis in millimeters.
  * @return The length of the truss rod on the Y axis in millimeters.
  */
function truss_rod_length_mm() = 1000;

/**
  * Calculates the position of the truss rod on the Y axis in millimeters.
  * @return The position of the truss rod on the Y axis in millimeters.
  */
function truss_rod_y_mm() = 0;

/**
  * Calculates the position of the truss rod on the Z axis in millimeters.
  * @param truss_rod_cutout_diameter_mm The diameter of the truss rod cutout, in
  *                                     millimeters.
  * @param body_thickness_mm            The thickness of the body, in
  *                                     millimeters.
  * @param fret_tang_cutout_height_mm   The height of the cutout for a fret's
  *                                     tang, in millimeters.
  * @return                             The position of the truss rod on the Z
  *                                     axis in millimeters.
  */
function truss_rod_z_mm(
  truss_rod_cutout_diameter_mm,
  body_thickness_mm,
  fret_tang_cutout_height_mm,
) = body_thickness_mm - fret_tang_cutout_height_mm - truss_rod_cutout_diameter_mm / 2 -0.01;
