FPS = 60
WIDTH = 310
HEIGHT = 310

class Player
  attr_accessor :size
  attr_accessor :center

  def initialize(shoes_app)
    @shoes_app = shoes_app
    @size = {:x => 15, :y => 8}
    @center = {:x => WIDTH / 2, :y => HEIGHT - @size[:y]}
    @shoes_app.fill('#00ffCC')
    @block = @shoes_app.rect(@center[:x] - @size[:x] / 2, @center[:y] - @size[:y] / 2, @size[:x], @size[:y])
  end

  def move(key)
    @center[:x] += key
    @block.left += key
  end

end

class Bullet
  def initialize(shoes_app, x, y, velocity_x, velocity_y)
    @shoes_app = shoes_app
    @size = {:x => 3, :y => 3}
    @center = {:x => x, :y => y}
    @velocity = {:x => velocity_x, :y => velocity_y}
    @shoes_app.fill('#004400')
    @block = @shoes_app.rect(@center[:x] - @size[:x] / 2, @center[:y] - @size[:y] / 2, @size[:x], @size[:y])
  end

  def move
    @center[:x] += @velocity[:x]
    @center[:y] += @velocity[:y]
    @block.left = @center[:x] - @size[:x] / 2;
    @block.top  = @center[:y] - @size[:y] / 2;
  end
end

Shoes.app do
  Shoes.show_log
  Shoes.debug " Space Invaders "
  @bullets = []
  @player = Player.new(self)

  def add_bullet
    player_center = @player.center
    player_size = @player.size
    bullet = Bullet.new(self, player_center[:x], player_center[:y] - player_size[:y] - 10, 0, -3)
    @bullets << bullet
  end

  keypress do |key|
    quit if key == :escape
    @player.move(4)  if key == :right
    @player.move(-4) if key == :left
    add_bullet if key == :up
  end

  last = now = Time.now
  animate = animate FPS do
    now = Time.now
    @bullets.each do |bullet|
      bullet.move
    end
    last = now
  end

end
