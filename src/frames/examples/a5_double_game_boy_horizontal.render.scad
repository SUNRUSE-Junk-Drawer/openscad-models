use <../frame.scad>;
use <../inlay.scad>;
use <../glazings/a5_glazing.scad>;
use <../backings/a5_backing.scad>;
use <../borders/rounded_flat_border.scad>;
use <../inlays/nintendo_game_boy_cartridge_inlay.scad>;
use <../../utilities/slice_x.scad>;

settings = [
  ["glazing", a5_glazing()],
  ["backing", a5_backing()],
  [
    "border",
    rounded_flat_border([
      ["thickness_mm", 17.5],
      ["sides", 64],
    ]),
  ],
  [
    "inlays", [
      nintendo_game_boy_cartridge_inlay([
        [
          "origin", [
            ["x_mm", -37.5],
            ["y_mm", 0],
          ],
        ],
      ]),
      nintendo_game_boy_cartridge_inlay([
        [
          "origin", [
            ["x_mm", 37.5],
            ["y_mm", 0],
          ],
        ],
      ]),
    ],
  ],
];

translate([-90, 0, 0]) {
  slice_x(-10000, 0) {
    frame(settings);
  };
};

inlay(settings);

translate([90, 0, 0]) {
  slice_x(0, 10000) {
    frame(settings);
  };
};
