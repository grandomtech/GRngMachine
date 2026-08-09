--[[
SISTEMA DE MÁQUINA RNG + AUTO GUI + RADAR 10M+ (ROBLOX STUDIO)
COMO USAR NO ROBLOX STUDIO:
1. Abra seu mapa no Roblox Studio.
2. No painel "Explorer", vá até StarterPlayer -> StarterPlayerScripts (ou StarterGui).
3. Crie um "LocalScript".
4. Cole TODO este código dentro do LocalScript.
5. Clique em "Play" para testar! A interface surgirá na tela automaticamente.
--]]
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
-- 1. TABELA DE RARIDADES E PROBABILIDADES
local BRAINROTS = {
{nome = "Skibidi Comum",       raridade = "Comum",        chance = 2,        valor = 1,        cor = Color3.fromRGB(180, 180, 180)},
{nome = "Rizzler Incomum",     raridade = "Incomum",      chance = 5,        valor = 5,        cor = Color3.fromRGB(100, 220, 100)},
{nome = "Sigma Raro",          raridade = "Raro",         chance = 20,       valor = 20,       cor = Color3.fromRGB(80, 150, 255)},
{nome = "Mewing Épico",        raridade = "Épico",        chance = 100,      valor = 100,      cor = Color3.fromRGB(170, 0, 255)},
{nome = "Gyatt Lendário",      raridade = "Lendário",     chance = 1000,     valor = 1000,     cor = Color3.fromRGB(255, 200, 0)},
{nome = "Grimace Mítico",      raridade = "Mítico",       chance = 50000,    valor = 50000,    cor = Color3.fromRGB(255, 50, 100)},
{nome = "Deus Brainrot",       raridade = "Deus Brainrot",chance = 1000000,  valor = 1000000,  cor = Color3.fromRGB(255, 0, 0)},
{nome = "Giga Secreto 10M+",   raridade = "Secreto",      chance = 10000000, valor = 10000000, cor = Color3.fromRGB(0, 255, 255)}
}
-- 2. CRIAÇÃO AUTOMÁTICA DA GUI (INTERFACE DO USUÁRIO)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RNG_Machine_Gui"
screenGui.ResetOnSpawn = false
screenGui.Parent = PlayerGui
-- Janela Principal
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 360, 0, 420)
mainFrame.Position = UDim2.new(0.5, -180, 0.5, -210)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true -- Permite arrastar a janela pela tela
mainFrame.Parent = screenGui
local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 16)
frameCorner.Parent = mainFrame
-- Título
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 50)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "⚡ MÁQUINA RNG BRAINROT ⚡"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 18
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = mainFrame
-- Contador de Giros
local counterLabel = Instance.new("TextLabel")
counterLabel.Size = UDim2.new(1, -40, 0, 30)
counterLabel.Position = UDim2.new(0, 20, 0, 50)
counterLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
counterLabel.Text = "Total de Giros: 0"
counterLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
counterLabel.TextSize = 14
counterLabel.Font = Enum.Font.GothamMedium
counterLabel.Parent = mainFrame
local counterCorner = Instance.new("UICorner")
counterCorner.CornerRadius = UDim.new(0, 8)
counterCorner.Parent = counterLabel
-- Texto do Nome do Personagem
local resultLabel = Instance.new("TextLabel")
resultLabel.Size = UDim2.new(1, -40, 0, 50)
resultLabel.Position = UDim2.new(0, 20, 0, 95)
resultLabel.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
resultLabel.Text = "Clique em Girar!"
resultLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
resultLabel.TextSize = 18
resultLabel.Font = Enum.Font.GothamBold
resultLabel.Parent = mainFrame
local resultCorner = Instance.new("UICorner")
resultCorner.CornerRadius = UDim.new(0, 8)
resultCorner.Parent = resultLabel
-- Texto de Raridade
local rarityLabel = Instance.new("TextLabel")
rarityLabel.Size = UDim2.new(1, -40, 0, 35)
rarityLabel.Position = UDim2.new(0, 20, 0, 150)
rarityLabel.BackgroundTransparency = 1
rarityLabel.Text = "Raridade: ---"
rarityLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
rarityLabel.TextSize = 14
rarityLabel.Font = Enum.Font.Gotham
rarityLabel.Parent = mainFrame
-- Botão Giro Manual
local spinButton = Instance.new("TextButton")
spinButton.Size = UDim2.new(1, -40, 0, 45)
spinButton.Position = UDim2.new(0, 20, 0, 200)
spinButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
spinButton.Text = "🎲 GIRO MANUAL"
spinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
spinButton.TextSize = 16
spinButton.Font = Enum.Font.GothamBold
spinButton.Parent = mainFrame
local spinCorner = Instance.new("UICorner")
spinCorner.CornerRadius = UDim.new(0, 10)
spinCorner.Parent = spinButton
-- Botão Auto Giro
local autoSpinButton = Instance.new("TextButton")
autoSpinButton.Size = UDim2.new(1, -40, 0, 45)
autoSpinButton.Position = UDim2.new(0, 20, 0, 255)
autoSpinButton.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
autoSpinButton.Text = "🔄 AUTO GIRO: OFF"
autoSpinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
autoSpinButton.TextSize = 16
autoSpinButton.Font = Enum.Font.GothamBold
autoSpinButton.Parent = mainFrame
local autoCorner = Instance.new("UICorner")
autoCorner.CornerRadius = UDim.new(0, 10)
autoCorner.Parent = autoSpinButton
-- Botão Radar 10M+ (Skip)
local radarButton = Instance.new("TextButton")
radarButton.Size = UDim2.new(1, -40, 0, 45)
radarButton.Position = UDim2.new(0, 20, 0, 310)
radarButton.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
radarButton.Text = "📡 RADAR 10M+: OFF (Skip < 10M)"
radarButton.TextColor3 = Color3.fromRGB(255, 255, 255)
radarButton.TextSize = 14
radarButton.Font = Enum.Font.GothamBold
radarButton.Parent = mainFrame
local radarCorner = Instance.new("UICorner")
radarCorner.CornerRadius = UDim.new(0, 10)
radarCorner.Parent = radarButton
-- 3. LÓGICA E ALGORITMO RNG
local totalGiros = 0
local autoGiroAtivo = false
local radar10MAtivo = false
local executandoGiro = false
local function formatarNumero(num)
if num >= 1000000 then
return string.format("%.1fM", num / 1000000)
elseif num >= 1000 then
return string.format("%.1fK", num / 1000)
else
return tostring(num)
end
end
-- Sorteio ponderado
local function sortearItem()
local roll = math.random(1, 10000000)
if roll == 1 then
return BRAINROTS[8] -- Secreto (10M+)
elseif roll <= 10 then
return BRAINROTS[7] -- Deus Brainrot
elseif roll <= 200 then
return BRAINROTS[6] -- Mítico
elseif roll <= 10000 then
return BRAINROTS[5] -- Lendário
elseif roll <= 100000 then
return BRAINROTS[4] -- Épico
elseif roll <= 500000 then
return BRAINROTS[3] -- Raro
elseif roll <= 2000000 then
return BRAINROTS[2] -- Incomum
else
return BRAINROTS[1] -- Comum
end
end
-- Processo de giro com sistema de Skip do Radar 10M+
local function realizarGiro()
if executandoGiro then return end
executandoGiro = true
while true do
totalGiros = totalGiros + 1
counterLabel.Text = "Total de Giros: " .. totalGiros
local item = sortearItem()
-- LÓGICA DO RADAR 10M+: Se ativado e o item for menor que 10M (10.000.000), pula (Skip)
if radar10MAtivo and item.valor < 10000000 then
task.wait(0.01) -- Skip ultrarrápido sem atualizar interface
else
-- Exibe resultado na tela
resultLabel.Text = item.nome
resultLabel.TextColor3 = item.cor
rarityLabel.Text = "Raridade: " .. item.raridade .. " (1 em " .. formatarNumero(item.chance) .. ")"
rarityLabel.TextColor3 = item.cor
-- Se encontrou um item 10M+ com o radar ligado, encerra o Auto Giro automaticamente
if radar10MAtivo and item.valor >= 10000000 then
autoGiroAtivo = false
autoSpinButton.Text = "🔄 AUTO GIRO: OFF"
autoSpinButton.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
end
break
end
if not autoGiroAtivo then
break
end
end
executandoGiro = false
end
-- 4. EVENTOS DOS BOTÕES
spinButton.MouseButton1Click:Connect(function()
if not executandoGiro then
task.spawn(realizarGiro)
end
end)
autoSpinButton.MouseButton1Click:Connect(function()
autoGiroAtivo = not autoGiroAtivo
if autoGiroAtivo then
autoSpinButton.Text = "🔄 AUTO GIRO: ON"
autoSpinButton.BackgroundColor3 = Color3.fromRGB(50, 180, 50)
task.spawn(function()
while autoGiroAtivo do
realizarGiro()
task.wait(0.1)
end
end)
else
autoSpinButton.Text = "🔄 AUTO GIRO: OFF"
autoSpinButton.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
end
end)
radarButton.MouseButton1Click:Connect(function()
radar10MAtivo = not radar10MAtivo
if radar10MAtivo then
radarButton.Text = "📡 RADAR 10M+: ON (Skip < 10M)"
radarButton.BackgroundColor3 = Color3.fromRGB(50, 180, 50)
else
radarButton.Text = "📡 RADAR 10M+: OFF (Skip < 10M)"
radarButton.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
end
end)
