// raylib-zig (c) Nikolas Wipper 2023
const std = @import("std");
const rl = @import("raylib");

const SCREEN_WIDTH = 800;
const SCREEN_HEIGHT = 400;

const Ball = struct {
    position: rl.Vector2,
    size: rl.Vector2,
    speed: rl.Vector2,

    pub fn init(x: f32, y: f32, size: f32, speed: f32) Ball {
        return Ball{
            .position = rl.Vector2.init(x, y),
            .size = rl.Vector2.init(size, size),
            .speed = rl.Vector2.init(speed, speed),
        };
    }

    pub fn update(self: *Ball) void {
        self.position = rl.math.vector2Add(self.position, self.speed);

        // check for y collisions
        if (self.position.y <= 0 or self.position.y + self.size.y >= SCREEN_HEIGHT) {
            self.speed.y *= -1;
        }

        // check for x collisions
        if (self.position.x <= 0 or self.position.x + self.size.x >= SCREEN_WIDTH) {
            self.speed.x *= -1;
        }
    }
    pub fn draw(self: *Ball) void {
        rl.drawRectangleV(self.position, self.size, rl.Color.red);
    }
};

const Bar = struct {
    position: rl.Vector2,
    size: rl.Vector2,
    speed: rl.Vector2,

    pub fn init(x: f32, y: f32, size: f32, speed: f32) Bar {
        return Bar{
            .position = rl.Vector2.init(x, y),
            .size = rl.Vector2.init(10, size),
            .speed = rl.Vector2.init(speed, speed),
        };
    }

    pub fn update(self: *Bar) void {
        if (rl.isKeyDown(rl.KeyboardKey.w)) {
            self.position.y = self.position.y - 7;
        }

        if (rl.isKeyDown(rl.KeyboardKey.s)) {
            self.position.y = self.position.y + 7;
        }
        if (self.position.y <= 0) {
            self.position.y = 0;
        }
        if (self.position.y + self.size.y >= SCREEN_HEIGHT) {
            self.position.y = SCREEN_HEIGHT - self.size.y;
        }
    }

    pub fn draw(self: *Bar) void {
        rl.drawRectangleV(self.position, self.size, rl.Color.red);
    }
};

pub fn main() anyerror!void {
    rl.initWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "PONG ZIG");
    defer rl.closeWindow();

    var ball = Ball.init(0, 0, 16, 4);
    var bar_one = Bar.init(0, 150, 60, 4);

    // MAIN GAME LOOP
    rl.setTargetFPS(60);
    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(rl.Color.black);

        // UPDATE !!
        ball.update();
        bar_one.update();
        // DRAW !!
        ball.draw();
        bar_one.draw();
    }
}
