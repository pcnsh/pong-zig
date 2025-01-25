// raylib-zig (c) Nikolas Wipper 2023
const std = @import("std");
const rl = @import("raylib");

const SCREEN_WIDTH = 800;
const SCREEN_HEIGHT = 400;

const ball = @import("models/ball.zig");
const bar = @import("models/bar.zig");

const Ball = ball.Ball;
const Bar = bar.Bar;

pub fn main() anyerror!void {
    rl.initWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "PONG ZIG");
    defer rl.closeWindow();

    var ball_obj = Ball.init(0, 0, 16, 4);
    var bar_one = Bar.init(16, 150, 60, 4);

    // MAIN GAME LOOP
    rl.setTargetFPS(60);
    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(rl.Color.black);

        // UPDATE !!
        ball_obj.update();
        bar_one.update();
        // DRAW !!
        ball_obj.draw();
        bar_one.draw();
    }
}
