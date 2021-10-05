include <../../measurements/fret.scad>;
include <fret.scad>;

for (fret_index = [0 : fret_count]) {
  attached_fret(fret_index);
};
