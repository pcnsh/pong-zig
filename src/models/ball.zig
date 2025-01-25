const std = @import("std");
const rl = @import("raylib");

const SCREEN_WIDTH = 800;
const SCREEN_HEIGHT = 400;

pub const Ball = struct {
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
            std.debug.print("hit", .{});
        }
    }
    pub fn draw(self: *Ball) void {
        rl.drawRectangleV(self.position, self.size, rl.Color.red);
    }
};
