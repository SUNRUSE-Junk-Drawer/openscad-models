include <../../measurements/fret.scad>;
include <fret.scad>;

for (fret_index = [0 : fret_count]) {
  printed_fret(fret_index);
};
