use <../cameras/wileyfox_swift_camera.scad>;
use <../consoles/game_boy_color_console.scad>;
use <../shroud.scad>;

shroud([
  ["camera", wileyfox_swift_camera()],
  ["console", game_boy_color_console()],
  ["wall_thickness_mm", 0.81],
  [
    "led",
    [
      ["diameter_mm", 6],
      ["sides", 32],
    ],
  ],
]);
