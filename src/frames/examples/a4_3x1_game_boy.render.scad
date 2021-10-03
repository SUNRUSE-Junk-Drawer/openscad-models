use <../frame.scad>;
use <../inlay.scad>;
use <../glazings/a4_glazing.scad>;
use <../backings/a4_backing.scad>;
use <../borders/rounded_flat_border.scad>;
use <../inlays/nintendo_game_boy_cartridge_inlay.scad>;
use <../../utilities/slice_x.scad>;

settings = [
  ["glazing", a4_glazing()],
  ["backing", a4_backing()],
  [
    "border",
    rounded_flat_border([
      ["thickness_mm", 17.5],
      ["sides", 256],
    ]),
  ],
  [
    "inlays", [
      nintendo_game_boy_cartridge_inlay([
        [
          "origin", [
            ["x_mm", -80],
            ["y_mm", 0],
          ],
        ],
      ]),
      nintendo_game_boy_cartridge_inlay([
        [
          "origin", [
            ["x_mm", 0],
            ["y_mm", 0],
          ],
        ],
      ]),
      nintendo_game_boy_cartridge_inlay([
        [
          "origin", [
            ["x_mm", 80],
            ["y_mm", 0],
          ],
        ],
      ]),
    ],
  ],
];

translate([-150, 0, 0]) {
  slice_x(-10000, 0) {
    frame(settings);
  };
};

translate([-10, 0, 0]) {
  slice_x(-10000, -40) {
    inlay(settings);
  };
};

slice_x(-40, 40) {
  inlay(settings);
};

translate([10, 0, 0]) {
  slice_x(40, 10000) {
    inlay(settings);
  };
};

translate([150, 0, 0]) {
  slice_x(0, 10000) {
    frame(settings);
  };
};
