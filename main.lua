function love.load()

  --Player 1
  p1 = {}
  p1.x = 50
  p1.y = 225
  p1.largura = 20
  p1.altura = 150
  p1.pontos = 0
  --p1.hitbox = p1.largura = 25 * p1.altura = 150

  --Player 2
  p2 = {}
  p2.x = 720
  p2.y = 225
  p2.largura = 20
  p2.altura = 150
  p2.pontos = 0
  --p2.hitbox = p2.largura = 25 * p2.altura = 150

  --Quadrado
  quad = {}
  quad.x = 380
  quad.y = 280
  quad.x_acel = 4
  quad.y_acel = 4
  quad.largura = 25
  quad.altura = 25

  font = love.graphics.newFont(25)
end

function love.update()

    --Player 1
    if love.keyboard.isDown("w") then
      if p1.y > 30 then
        p1.y = p1.y - 7
      end
    end
    if love.keyboard.isDown("s") then
      if p1.y < 450 then
        p1.y = p1.y + 7
      end
    end

    --Player 2
    if love.keyboard.isDown("up") then
      if p2.y > 30 then
        p2.y = p2.y - 7
      end
    end
    if love.keyboard.isDown("down") then
      if p2.y < 450 then
        p2.y = p2.y + 7
      end
    end

    --Quadrado
    quad.y = quad.y + quad.y_acel
    quad.x = quad.x + quad.x_acel
    --Colisão entre parede e Quadrado
    if quad.y < 27 or quad.y > 575 then
      quad.y_acel = quad.y_acel * -1
    end

    --Colisão entre P1 e Quadrado
    if quad.x + quad.largura + quad.x_acel >= p1.x and
       quad.x + quad.x_acel <= p1.x + p1.largura and
       quad.y + quad.altura >= p1.y and
       quad.y <= p1.y + p1.altura then
          quad.x_acel = quad.x_acel * -1
    end
    if quad.x + quad.largura >= p1.x and
       quad.x <= p1.x + p1.largura and
       quad.y + quad.altura + quad.y_acel >= p1.y and
       quad.y + quad.y_acel <= p1.y + p1.altura then
          quad.y_acel = quad.y_acel * -1
    end

    --Colisão entre P2 e Quadrado
    if quad.x + quad.largura + quad.x_acel >= p2.x and
       quad.x + quad.x_acel <= p2.x + p2.largura and
       quad.y + quad.altura >= p2.y and
       quad.y <= p2.y + p2.altura then
          quad.x_acel = quad.x_acel * -1
    end
    if quad.x + quad.largura >= p2.x and
       quad.x <= p2.x + p2.largura and
       quad.y + quad.altura + quad.y_acel >= p2.y and
       quad.y + quad.y_acel <= p2.y + p2.altura then
          quad.y_acel = quad.y_acel * -1
    end

    --Placar
    if quad.x <= 0 then
        p2.pontos = p2.pontos + 1
        quad.x = 380
        quad.y = 280
      end
    if quad.x >= 800 then
        p1.pontos = p1.pontos + 1
        quad.x = 380
        quad.y = 280
      end
end

function love.draw()

  love.graphics.rectangle("line", 0, 26, 800, 1)
  love.graphics.rectangle("fill", p1.x, p1.y, p1.largura, p1.altura)
  love.graphics.rectangle("fill", p2.x, p2.y, p2.largura, p2.altura)
  love.graphics.rectangle("fill", quad.x, quad.y, quad.largura, quad.altura)

  love.graphics.setFont(font)
  love.graphics.print("P1: "..p1.pontos, 75)
  love.graphics.print("P2: "..p2.pontos, 655)
end
