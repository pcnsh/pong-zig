const std = @import("std");
const rl = @import("raylib");

const SCREEN_WIDTH = 800;
const SCREEN_HEIGHT = 400;

pub const Bar = struct {
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
