-- BNXYUNG AIMBOT + ESP BASE (visual only, no memory edits)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Configuración visual
local ESP_COLOR = Color3.fromRGB(255, 0, 0)
local ESP_SIZE = 2

-- Crear ESP para cada jugador
function createESP(player)
    if player == LocalPlayer then return end
    local highlight = Instance.new("Highlight")
    highlight.Adornee = player.Character
    highlight.FillColor = ESP_COLOR
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 1
    highlight.Parent = player.Character
end

-- Aimbot básico (solo apunta, no dispara)
function aimAtClosest()
    local closest = nil
    local shortest = math.huge
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
            local pos = Camera:WorldToViewportPoint(player.Character.Head.Position)
            local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
            if dist < shortest then
                shortest = dist
                closest = player
            end
        end
    end
    if closest and closest.Character:FindFirstChild("Head") then
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, closest.Character.Head.Position)
    end
end

-- Activar ESP y Aimbot
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        wait(1)
        createESP(player)
    end)
end)

game:GetService("RunService").RenderStepped:Connect(function()
    aimAtClosest()
end)
