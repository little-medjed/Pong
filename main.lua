--A função love.load() carrega os objetos usados no jogo
function love.load()
  --Declaração do objeto Player 1 e seus atributos
  p1 = {}
  p1.x = 50
  p1.y = 225
  p1.largura = 20
  p1.altura = 100
  p1.pontos = 0

  --Declaração do objeto Player 2 e seus atributos
  p2 = {}
  p2.x = 720
  p2.y = 225
  p2.largura = 20
  p2.altura = 100
  p2.pontos = 0

  --Declaração do objeto Quadrado e seus atributos
  quad = {}
  quad.x = 380
  quad.y = 280
  quad.x_acel = 4
  quad.y_acel = 4
  quad.largura = 25
  quad.altura = 25

 --Declaração da fonte
  font = love.graphics.newFont(25)
end

--A função love.update() atualiza as modificações do jogo em execução
function love.update()

    --Movimentação do Player 1
    --Quando w é pressionado e ele estiver abaixo da linha do placar mova o P1 pra cima
    if love.keyboard.isDown("w") then
      if p1.y > 30 then
        p1.y = p1.y - 7
      end
    end
    --Quando s é pressionado e ele estiver acima do fim da tela mova o P1 pra baixo
    if love.keyboard.isDown("s") then
      if p1.y < 500 then
        p1.y = p1.y + 7
      end
    end

    --Movimentação do Player 2
    --Quando a seta pra cima é pressionada e ele estiver abaixo da linha do placar mova o P2 pra cima
    if love.keyboard.isDown("up") then
      if p2.y > 30 then
        p2.y = p2.y - 7
      end
    end
    --Quando a seta pra baixo é pressionada e ele estiver acima do fim da tela mova o P2 pra baixo
    if love.keyboard.isDown("down") then
      if p2.y < 500 then
        p2.y = p2.y + 7
      end
    end

    --Movimentação do Quadrado
    --Posição X e Y recebem o valor delas mesmas mais sua aceleração
    quad.y = quad.y + quad.y_acel
    quad.x = quad.x + quad.x_acel
    --Colisão entre as paredes do eixo Y e Quadrado
    --Quando o Quadrado acerta em cima ou em baixo inverta o valor da aceleração Y
    if quad.y < 27 or quad.y > 575 then
      quad.y_acel = quad.y_acel * -1
    end

    --Colisão entre P1 e Quadrado
    --Esse if checa pra onde o Quadrado se move no eixo X,
    --se ele estiver proximo do centro da barra do P1 a aceleração sera invertida
    if quad.x + quad.largura + quad.x_acel >= p1.x and
       quad.x + quad.x_acel <= p1.x + p1.largura and
       quad.y + quad.altura >= p1.y and
       quad.y <= p1.y + p1.altura then
          quad.x_acel = quad.x_acel * -1
    end
    --Esse if checa pra onde o Quadrado se move no eixo Y,
    --se ele estiver proximo do centro da barra do P1 a aceleração sera invertida
    if quad.x + quad.largura >= p1.x and
       quad.x <= p1.x + p1.largura and
       quad.y + quad.altura + quad.y_acel >= p1.y and
       quad.y + quad.y_acel <= p1.y + p1.altura then
          quad.y_acel = quad.y_acel * -1
    end

    --Colisão entre P2 e Quadrado
    --Esse if checa pra onde o Quadrado se move no eixo X,
    --se ele estiver proximo do centro da barra do P2 a aceleração sera invertida
    if quad.x + quad.largura + quad.x_acel >= p2.x and
       quad.x + quad.x_acel <= p2.x + p2.largura and
       quad.y + quad.altura >= p2.y and
       quad.y <= p2.y + p2.altura then
          quad.x_acel = quad.x_acel * -1
    end
    --Esse if checa pra onde o Quadrado se move no eixo Y,
    --se ele estiver proximo do centro da barra do P2 a aceleração sera invertida 
    if quad.x + quad.largura >= p2.x and
       quad.x <= p2.x + p2.largura and
       quad.y + quad.altura + quad.y_acel >= p2.y and
       quad.y + quad.y_acel <= p2.y + p2.altura then
          quad.y_acel = quad.y_acel * -1
    end

    --Placar
    --Quando o Quadrado atravessar um lado da tela (eixo X),
    --marque um ponto pro player do lado oposto e retorne pro centro da tela
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

--A função love.draw() carrega a parte grafica do jogo
function love.draw()

 --A função love.graphics.rectangle desenha os retangulos, os parametros são:
 --Preenchimento fill(preenchido) e line(apenas as linhas de contorno)
 --Posição X e Y
 --Altura e largura
  love.graphics.rectangle("line", 0, 26, 800, 1)
  love.graphics.rectangle("fill", p1.x, p1.y, p1.largura, p1.altura)
  love.graphics.rectangle("fill", p2.x, p2.y, p2.largura, p2.altura)
  love.graphics.rectangle("fill", quad.x, quad.y, quad.largura, quad.altura)

 --A função love.graphics.setFont modifica a fonte usada pela fonte recebida no parametro
  love.graphics.setFont(font)
 --A função love.graphics.print imprime textos na tela, os parametros são o texto e o seu tamanho
  love.graphics.print("P1: "..p1.pontos, 75)
  love.graphics.print("P2: "..p2.pontos, 655)
end
