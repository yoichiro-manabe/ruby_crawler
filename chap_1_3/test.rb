def area(x,y) x*y end

class Rect
  def initialize(x, y)
    @x, @y = x, y
  end

  attr_reader :x, :y

  def area() x*y end
end

area(10,5) # =>
Rect.new(10,5).area # =>